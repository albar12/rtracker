import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';

import '../../../realm/schemas.dart';
import 'image_load_event.dart';
import 'image_load_state.dart';

// Message structure for the isolate
class ProcessingMessage {
  final List<TransferableTypedData> dataChunks; // Chunks of image data
  final SendPort sendPort;                     // Port for sending results

  ProcessingMessage(this.dataChunks, this.sendPort);
}

// Function to run in the isolate
void processChunksInIsolate(ProcessingMessage message) {
  final results = <Uint8List>[];

  // Process each chunk of data
  for (final chunk in message.dataChunks) {
    // Retrieve the binary data from TransferableTypedData
    final data = chunk.materialize().asUint8List();
    results.add(data);
  }

  // Send processed results back to the main thread
  message.sendPort.send(results);
}

class ImageLoadBloc extends Bloc<ImageLoadEvent, ImageLoadState> {
  ImageLoadBloc() : super(ImageLoadInitial()) {
    on<ImageLoadStarted>(started);
    on<ImageLoadFromRealm>(loadImage);
  }

  FutureOr<void> started(ImageLoadStarted event, Emitter<ImageLoadState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    
    emit(ImageLoadSuccess(event.listImages));
  }

  FutureOr<void> loadImage(ImageLoadFromRealm event, Emitter<ImageLoadState> emit) async {
    final List<Uint8List> list = await processLargeRealmList(event.result);
    emit(ImageLoadSuccess(list));
  }

  // Function to process RealmList<ImageFile> with large images
  Future<List<Uint8List>> processLargeRealmList(RealmList<ImageFile> realmList) async {
    final receivePort = ReceivePort();

    // Convert RealmList<ImageFile> into TransferableTypedData for isolate processing
    final dataChunks = realmList
        .map((imageFile) => TransferableTypedData.fromList([Uint8List.fromList(imageFile.file)]))
        .toList();

    // Spawn the isolate
    await Isolate.spawn(
      processChunksInIsolate,
      ProcessingMessage(dataChunks, receivePort.sendPort),
    );

    // Wait for the result from the isolate
    final results = await receivePort.first as List<Uint8List>;
    return results;
  }
}
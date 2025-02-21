import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'scan_sn_event.dart';
part 'scan_sn_state.dart';

class ScanSnBloc extends Bloc<ScanSnEvent, ScanSnState> {
  ScanSnBloc() : super(ScanSnInitial()) {
    on<ScanSnEvent>((event, emit) {
      if (event is ChooseType){
        emit(ScanSelected(event.scanType));
      }
      if (event is DisplayBarcode){
        emit(BarcodeCaptured(event.barcode, event.barcodeCapture));
      }
    });
  }
}

enum ScanType {
 qrCode, barcode
}

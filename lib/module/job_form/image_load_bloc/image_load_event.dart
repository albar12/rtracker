import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../../../realm/schemas.dart';

@immutable
abstract class ImageLoadEvent {}

class ImageLoadStarted extends ImageLoadEvent {
  final List<Uint8List> listImages;

  ImageLoadStarted(this.listImages);
}

class ImageLoadFromRealm extends ImageLoadEvent {
  final RealmList<ImageFile> result;
  ImageLoadFromRealm(this.result);
}
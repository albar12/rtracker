import 'dart:typed_data';

import 'package:flutter/material.dart';

@immutable
abstract class ImageLoadState {}

class ImageLoadInitial extends ImageLoadState {}

class ImageLoadSuccess extends ImageLoadState {
  final List<Uint8List> listImages;

  ImageLoadSuccess(this.listImages);
}
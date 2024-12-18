import 'package:flutter/cupertino.dart';

class Widgets {
  static void fill({
    required TextEditingController textEditingController,
    String? value,
  }) async {
    textEditingController.text = value ?? "";
  }
}

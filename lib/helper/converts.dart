import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class Converts {
  static Future<File> uint8ListToFile(Uint8List data) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = await File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}').create();

    await tempFile.writeAsBytes(data);

    return tempFile;
  }
}

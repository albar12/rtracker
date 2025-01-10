import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ApiLogInterceptor extends Interceptor {
  File? logFile;

  ApiLogInterceptor() {
    _initializeLogFile();
  }

  Future<void> _initializeLogFile() async {
    // Request storage permission
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Get the Downloads directory
      Directory? downloadsDir = Directory('/storage/emulated/0/Downloads');
      if (!downloadsDir.existsSync()) {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      // Create a log file
      logFile = File('${downloadsDir.path}/api_logs.txt');
      if (!logFile!.existsSync()) {
        await logFile!.create();
      }
    } else {
      print('Storage permission denied.');
    }
  }

  Future<void> _writeToLogFile(String content) async {
    if (logFile != null) {
      await logFile!.writeAsString(
        content,
        mode: FileMode.append,
        flush: true,
      );
    } else {
      print('Log file is not initialized.');
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final log = '''
Request:
URL: ${options.uri}
Method: ${options.method}
Headers: ${options.headers}
Body: ${options.data}
''';
    _writeToLogFile(log);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final log = '''
Response:
URL: ${response.requestOptions.uri}
Status Code: ${response.statusCode}
Data: ${response.data}
''';
    _writeToLogFile(log);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final log = '''
Error:
URL: ${err.requestOptions.uri}
Message: ${err.message}
StackTrace: ${err.stackTrace}
''';
    _writeToLogFile(log);
    super.onError(err, handler);
  }
}

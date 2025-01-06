import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class LoggingInterceptor extends Interceptor {
  // Create a log file in a writable directory
  late File logFile;

  LoggingInterceptor() {
    _initializeLogFile();
  }

  // Initialize the log file in the appropriate directory
  Future<void> _initializeLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    logFile = File('${directory.path}/api_log.txt');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log request data
    _logToFile('Request: ${options.method} ${options.uri}\nHeaders: ${options.headers}\nBody: ${options.data}\n');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response data
    _logToFile('Response: ${response.statusCode} ${response.data}\n');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Log error data
    _logToFile('Error: ${err.message}\n');
    return super.onError(err, handler);
  }

  // Helper function to write logs to the file
  void _logToFile(String log) async {
    if (!logFile.existsSync()) {
      await logFile.create();
    }
    await logFile.writeAsString(log, mode: FileMode.append);
  }
}

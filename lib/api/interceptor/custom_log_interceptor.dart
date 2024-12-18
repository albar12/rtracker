import 'dart:convert';

import 'package:rtracker/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (Parameter.API_PRINT_LOGGING_ENABLED) {
      debugPrint("[LogInterceptor] Uri: ${options.uri}", wrapWidth: 1024);
    }

    try {
      if (Parameter.API_PRINT_LOGGING_ENABLED) {
        String? body;

        if (options.data != null) {
          if (options.data is Map) {
            body = json.encode(options.data);
          } else if (options.data is String) {
            body = options.data;
          } else if (options.data is! FormData) {
            body = json.encode(options.data.toJson());
          }

          debugPrint("[LogInterceptor] Request body: $body", wrapWidth: 1024);
        }
      }
    } finally {}

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (Parameter.API_PRINT_LOGGING_ENABLED) {
      debugPrint(
        "[LogInterceptor] Response body: ${response.data}",
        wrapWidth: 1024,
      );
    }

    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (Parameter.API_PRINT_LOGGING_ENABLED) {
      debugPrint(
        "[LogInterceptor] Response error message: ${err.message}",
        wrapWidth: 1024,
      );
    }

    return handler.next(err);
  }
}

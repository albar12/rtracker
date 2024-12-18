import 'package:dio/dio.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/preferences.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["Authorization"] = 'Bearer ${Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID) ?? ''}';
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class InterceptorWrapper extends Interceptor {
  final SharedPreferences? prefs;
  InterceptorWrapper(this.prefs);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(kHeader(prefs?.getString(kTokenKey) ?? ""));
    return handler.next(options); // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('http status code => ${response.statusCode} \nresponse data => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.data}');
    super.onError(err, handler);
  }
}

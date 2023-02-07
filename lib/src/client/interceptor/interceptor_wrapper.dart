import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class InterceptorWrapper extends Interceptor {
  final SharedPreferences? prefs;
  final String token;
  InterceptorWrapper(this.prefs,this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final mToken = token.isEmpty ? "${prefs?.getString(kTokenKey)}" : token;
    options.headers.addAll(kHeader("$mToken"));
    return handler.next(options); // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //debugPrint('http status code => ${response.statusCode} \nresponse data => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.data}');
    super.onError(err, handler);
  }
}

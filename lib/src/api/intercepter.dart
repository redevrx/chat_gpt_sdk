import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class InterceptorWrapper extends Interceptor {
  final SharedPreferences? prefs;
  InterceptorWrapper(this.prefs);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("header: ${options.headers}");
    // if (options.path.split("/").last != "kCompletion") {
    //   options.headers.addAll(kHeaderOrg(prefs?.getString(kOrgIdKey) ?? ""));
    //   return handler.next(options);
    // }
    options.headers.addAll(kHeader(prefs?.getString(kTokenKey) ?? ""));
    return handler.next(options); // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => Data: ${err.response?.data}');
    super.onError(err, handler);
  }
}

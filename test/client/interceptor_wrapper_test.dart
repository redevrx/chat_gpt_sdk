import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('interceptor test', () {
    test('interceptor test onRequest', () {
      final intercept = InterceptorsWrapper();

      intercept.onRequest(RequestOptions(), RequestInterceptorHandler());
    });
    test('interceptor test onResponse', () {
      final intercept = InterceptorsWrapper();
      final response = Response(
        data: "data",
        requestOptions: RequestOptions(),
      );
      intercept.onResponse(response, ResponseInterceptorHandler());
      expect(response.data, 'data');
    });
  });
}

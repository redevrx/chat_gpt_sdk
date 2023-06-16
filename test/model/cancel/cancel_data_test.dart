import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('cancel data model test', () {
    test('cancel data test cancel instance', () {
      final cancel = CancelData(cancelToken: CancelToken());
      expect(cancel.cancelToken, isA<CancelToken>());
    });
    test('cancel data test cancel instance', () {
      final cancel = CancelData(cancelToken: CancelToken());
      expect(cancel, isA<CancelData>());
    });
  });
}

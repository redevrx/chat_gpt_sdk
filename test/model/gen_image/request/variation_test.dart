import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('variation test', () {
    test('variation test from json', () async {
      final variation = await Variation(
        image: FileInfo('path', 'name'),
        size: ImageSize.size1024,
        responseFormat: Format.url,
        user: 'user',
        n: 1,
      ).convert();

      expect(variation, isA<FormData>());
    });
    test('variation test to json', () {
      final json = Variation(
        image: FileInfo('path', 'name'),
        size: ImageSize.size1024,
        responseFormat: Format.url,
        user: 'user',
        n: 1,
      ).toJson();

      expect(json, isA<Map>());
    });
  });
}

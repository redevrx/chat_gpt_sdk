import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('edit file test', () {
    test('edit file test', () async {
      final e = EditFile('path', 'name');
      final edit = await EditImageRequest(
        image: e,
        prompt: 'prompt',
        mask: e,
        n: 1,
        user: 'user',
        responseFormat: Format.url,
        size: ImageSize.size1024,
      ).convert();
      e.toString();

      expect(edit, isA<FormData>());
    });

    test('edit file test', () {
      final e = EditFile('path', 'name');
      e.toString();
      final json = EditImageRequest(
        image: e,
        prompt: 'prompt',
        mask: e,
        n: 1,
        user: 'user',
        responseFormat: Format.url,
        size: ImageSize.size1024,
      ).toJson();

      expect(json['prompt'], 'prompt');
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('upload file test', () {
    test('upload file test get from', () {
      final upload = UploadFile(file: EditFile("path", 'name'));

      expect(upload.getForm(), isA<Future<FormData>>());
    });
  });
}

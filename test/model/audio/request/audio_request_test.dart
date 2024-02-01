import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/audio/enum/audio_format.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('audio request test', () {
    test('audio request test set edit file', () {
      final request = AudioRequest(file: FileInfo("path", "name"));

      expect(request.file.name, 'name');
      expect(request.file.path, 'path');
      expect(request.toJson(), isA<Future<FormData>>());
    });
    test('audio request test set language', () {
      final request =
          AudioRequest(file: FileInfo("path", "name"), language: "en");

      expect(request.file.name, 'name');
      expect(request.file.path, 'path');
      expect(request.language, 'en');
      expect(request.toJson(), isA<Future<FormData>>());
    });
    test('audio request test set format', () {
      final request = AudioRequest(
        file: FileInfo("path", "name"),
        language: "en",
        responseFormat: AudioFormat.verboseJson,
      );

      expect(request.file.name, 'name');
      expect(request.file.path, 'path');
      expect(request.language, 'en');
      expect(request.responseFormat, AudioFormat.verboseJson);
      expect(request.toJson(), isA<Future<FormData>>());
    });
    test('audio request test set temperature', () {
      final request = AudioRequest(
        file: FileInfo("path", "name"),
        language: "en",
        responseFormat: AudioFormat.verboseJson,
        temperature: 1,
      );

      expect(request.file.name, 'name');
      expect(request.file.path, 'path');
      expect(request.language, 'en');
      expect(request.responseFormat, AudioFormat.verboseJson);
      expect(request.temperature, 1);
      expect(request.toJson(), isA<Future<FormData>>());
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('openai image size', () {
    test('openai image size get value size256', () {
      const size256 = ImageSize.size256;

      expect(size256.size, '256x256');
    });
    test('openai image size get value size512', () {
      const size512 = ImageSize.size512;

      expect(size512.size, '512x512');
    });
    test('openai image size get value size1024', () {
      const size1024 = ImageSize.size1024;

      expect(size1024.size, '1024x1024');
    });
  });
}

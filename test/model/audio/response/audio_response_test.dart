import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('audio response test', () {
    test('audio response test instance is AudioResponse', () {
      final response = AudioResponse('text');
      expect(response, isA<AudioResponse>());
    });
    test('audio response test match value response', () {
      final response = AudioResponse('text');
      expect(response.text, 'text');
    });
    test('audio response test value from json', () {
      final response = AudioResponse.fromJson({"text": "text"});
      expect(response.text, 'text');
    });
  });
}

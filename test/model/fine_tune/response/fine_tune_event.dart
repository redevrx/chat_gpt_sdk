import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('openai fine tune event test', () {
    test('openai fine tune event test from json', () {
      final json = {
        "level": 'level',
        'message': 'message',
        'created_at': 12312,
      };

      final event = FineTuneEvent.fromJson(json);

      expect(event.message, 'message');
      expect(event.level, 'level');
    });
  });
}

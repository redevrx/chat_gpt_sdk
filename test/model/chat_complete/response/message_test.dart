import 'package:chat_gpt_sdk/src/model/chat_complete/response/message.dart';
import 'package:test/test.dart';

void main() {
  group('Message', () {
    test('toJson() returns expected Map', () {
      final message = Message(role: 'sender', content: 'Hello, world!');
      expect(message.toJson(), {
        'role': 'sender',
        'content': 'Hello, world!',
        'function_call': null,
      });
    });

    test('fromJson() returns expected Message object', () {
      final json = {'role': 'receiver', 'content': 'Hi there!'};
      final message = Message.fromJson(json);
      expect(message.role, 'receiver');
      expect(message.content, 'Hi there!');
    });
  });
}

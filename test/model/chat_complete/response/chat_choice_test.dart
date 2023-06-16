import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/message.dart';
import 'package:test/test.dart';

void main() {
  group('toJson', () {
    test('toJson should return a valid JSON map', () {
      final chatChoice = ChatChoice(
        index: 0,
        message: Message(role: 'user', content: 'Hello'),
        finishReason: null,
      );

      final jsonMap = chatChoice.toJson();

      expect(jsonMap, isA<Map<String, dynamic>>());
      expect(jsonMap['index'], equals(0));
      expect(jsonMap['finish_reason'], equals(''));
      expect(jsonMap['message'], isA<Map<String, dynamic>>());
      expect(jsonMap['message']['role'], equals('user'));
      expect(jsonMap['message']['content'], equals('Hello'));
    });
  });

  group('fromJson', () {
    test('fromJson should decode JSON correctly', () {
      final Map<String, dynamic> json = {
        'index': 1,
        'message': {'role': 'bot', 'content': 'Hello, world!'},
        'finish_reason': null,
      };

      final chatChoice = ChatChoice.fromJson(json);

      expect(chatChoice.index, 1);
      expect(chatChoice.message?.role, 'bot');
      expect(chatChoice.message?.content, 'Hello, world!');
      expect(chatChoice.finishReason, null);
    });
  });
}

import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';
import 'package:test/test.dart';

void main() {
  group('choices test', () {
    test('choices test from json', () {
      final json = {
        "finish_reason": "finish_reason",
        "text": "text",
        "index": 1,
      };

      final choice = Choices.fromJson(json);

      expect(choice.text, 'text');
      expect(choice.index, 1);
    });

    test('choices test to json', () {
      final json = Choices("text", 1, 'finishReason').toJson();

      expect(json['text'], 'text');
      expect(json['index'], 1);
    });
  });
}

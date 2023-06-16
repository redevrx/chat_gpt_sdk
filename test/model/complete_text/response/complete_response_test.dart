import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';
import 'package:test/test.dart';

void main() {
  group('complete response test', () {
    test('complete response test from json', () {
      final choiceJson = {
        "finish_reason": "finish_reason",
        "text": "text",
        "index": 1,
      };

      final json = {
        "id": 'id',
        "object": "object",
        "created": 1,
        "model": "model",
        "choices": [choiceJson],
        "usage": null,
      };

      final response = CompleteResponse.fromJson(json);

      expect(response.model, 'model');
      expect(response.id, 'id');
      expect(response.object, 'object');
      expect(response.choices.length, 1);
    });
    test('complete response test to json', () {
      final choiceJson = {
        "finish_reason": "finish_reason",
        "text": "text",
        "index": 1,
      };

      final json = CompleteResponse(
        "id",
        "object",
        1,
        "model",
        [Choices.fromJson(choiceJson)],
        null,
      ).toJson();

      expect(json['model'], 'model');
      expect(json['id'], 'id');
      expect(json['object'], 'object');
      expect(json['choices'].length, 1);
    });
  });
}

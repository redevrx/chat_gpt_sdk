import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';
import 'package:test/test.dart';

void main() {
  group('openai embed response test', () {
    test('openai embed response test from json', () {
      final json = {
        "object": "object",
        "data": [
          {
            "object": "object",
            "embedding": [.0, .6],
            "index": 1,
          },
        ],
        "model": "model",
        "usage": {
          "prompt_tokens": 50,
          "completion_tokens": 10,
          "total_tokens": 60,
        },
      };

      final response = EmbedResponse.fromJson(json);

      expect(response.object, 'object');
      expect(response.model, 'model');
    });

    test('openai embed response test to json', () {
      final json = EmbedResponse(
        object: "object",
        data: [
          EmbedData.fromJson({
            "object": "object",
            "embedding": [.0, .6],
            "index": 1,
          }),
        ],
        model: "model",
        usage: Usage.fromJson({
          "prompt_tokens": 50,
          "completion_tokens": 10,
          "total_tokens": 60,
        }),
      ).toJson();

      expect(json['object'], 'object');
      expect(json['model'], 'model');
    });
  });
}

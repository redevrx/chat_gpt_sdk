import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';
import 'package:chat_gpt_sdk/src/model/edits/response/edit_response.dart';
import 'package:test/test.dart';

void main() {
  group('edit response test', () {
    test('edit response test from json', () {
      final json = {
        "object": "object",
        "created": 1,
        "choices": [
          {
            "text": "text",
            "index": 1,
          },
        ],
        "usage": {
          "prompt_tokens": 1,
          "completion_tokens": 0,
          "total_tokens": 1,
        },
      };

      final response = EditResponse.fromJson(json);
      expect(response.choices.length, 1);
      expect(response.object, 'object');
      expect(response.created, 1);
    });

    test('edit response test to json', () {
      final json = EditResponse(
        object: "object",
        created: 1,
        choices: [
          Choice.fromJson({
            "text": "text",
            "index": 1,
          }),
        ],
        usage: Usage.fromJson(
          {"prompt_tokens": 1, "completion_tokens": 0, "total_tokens": 1},
        ),
      ).toJson();

      expect(json['choices'].length, 1);
      expect(json['choices'][0]['text'], 'text');
      expect(json['created'], 1);
    });
  });
}

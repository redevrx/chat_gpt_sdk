import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('openai file response test', () {
    test('openai file response test from json', () {
      final json = {
        "data": [
          {
            "id": "id",
            "object": 'object',
            'bytes': 12312,
            'created_at': 12312,
            'filename': 'filename',
            'purpose': 'purpose',
          },
        ],
        "object": "object",
      };

      final response = FileResponse.fromJson(json);

      expect(response.object, 'object');
      expect(response.data.length, 1);
    });

    test('openai file response test to json', () {
      final json = FileResponse(
        data: [
          FileData.fromJson({
            "id": "id",
            "object": 'object',
            'bytes': 12312,
            'created_at': 12312,
            'filename': 'filename',
            'purpose': 'purpose',
          }),
        ],
        object: 'object',
      ).toJson();

      expect(json['object'], 'object');
      expect(json['data'].length, 1);
    });
  });
}

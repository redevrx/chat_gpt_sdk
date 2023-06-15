import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('openai file data model test', () {
    test('openai file data model test from json', () {
      final json = {
        "id": "id",
        "object": 'object',
        'bytes': 12312,
        'created_at': 12312,
        'filename': 'filename',
        'purpose': 'purpose',
      };

      final fileData = FileData.fromJson(json);

      expect(fileData.object, 'object');
      expect(fileData.bytes, 12312);
      expect(fileData.createdAt, 12312);
    });

    test('openai file data model test to json', () {
      final json = FileData(
        id: "id",
        object: "object",
        bytes: 12312,
        createdAt: 12312,
        filename: "filename",
        purpose: "purpose",
      ).toJson();

      expect(json['object'], 'object');
      expect(json['bytes'], 12312);
      expect(json['created_at'], 12312);
    });
  });
}

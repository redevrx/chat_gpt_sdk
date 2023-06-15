import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('openai upload file response', () {
    test('openai upload file response from json', () {
      final json = {
        "id": "id",
        "object": 'object',
        'bytes': 12312,
        'created_at': 12312,
        'filename': 'filename',
        'purpose': 'purpose',
      };

      final upload = UploadResponse.fromJson(json);

      expect(upload.object, 'object');
      expect(upload.bytes, 12312);
      expect(upload.createdAt, 12312);
    });

    test('openai upload file response to json', () {
      final json = UploadResponse(
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

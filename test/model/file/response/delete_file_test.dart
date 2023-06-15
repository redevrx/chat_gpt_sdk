import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('delete file model test', () {
    test('delete file model test from json', () {
      final json = {
        "id": "id",
        "object": "object",
        "deleted": true,
      };

      final request = DeleteFile.fromJson(json);

      expect(request.object, 'object');
      expect(request.deleted, true);
      expect(request.id, 'id');
    });
    test('delete file model test to json', () {
      final json =
          DeleteFile(id: "id", object: "object", deleted: true).toJson();

      expect(json['object'], 'object');
      expect(json['deleted'], true);
      expect(json['id'], 'id');
    });
  });
}

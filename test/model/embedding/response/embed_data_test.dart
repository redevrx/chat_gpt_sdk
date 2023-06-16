import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('embed data test', () {
    test('embed data test from json', () {
      final json = {
        "object": "object",
        "embedding": [.0, .6],
        "index": 1,
      };

      final request = EmbedData.fromJson(json);

      expect(request.object, 'object');
      expect(request.index, 1);
      expect(request.embedding.length, 2);
    });
    test('embed data test to json', () {
      final json =
          EmbedData(object: "object", embedding: [.0, .6], index: 2).toJson();

      expect(json['object'], 'object');
      expect(json['index'], 2);
      expect(json['embedding'].length, 2);
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';
import 'package:test/test.dart';

void main() {
  group('embed request test', () {
    test('embed request test to json', () {
      final json =
          EmbedRequest(model: TextEmbeddingAda002EmbedModel(), input: "input")
              .toJson();

      expect(json["model"], TextEmbeddingAda002EmbedModel().model);
      expect(json['input'], 'input');
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('embed request test', () {
    test('embed request test to json', () {
      final json =
          EmbedRequest(model: TextSearchAdaDoc001EmbedModel(), input: "input")
              .toJson();

      expect(json["model"], TextSearchAdaDoc001EmbedModel().model);
      expect(json['input'], 'input');
    });
  });
}

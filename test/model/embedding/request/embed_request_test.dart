
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('embed request test', () {
    test('embed request test to json', () {
      final json = EmbedRequest(model: EmbedModel.textSearchAdaDoc001, input: "input").toJson();

      expect(json["model"], EmbedModel.textSearchAdaDoc001.getName());
      expect(json['input'], 'input');
    });
  });
}
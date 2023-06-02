
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('openai embedding model test', () {
    test('openai embedding model test textEmbeddingAda002', () {
      const textEmbeddingAda002 = EmbedModel.textEmbeddingAda002;

      expect(textEmbeddingAda002.getName(), kEmbeddingAda002);
    });
    test('openai embedding model test textSearchAdaDoc001', () {
      const textSearchAdaDoc001 = EmbedModel.textSearchAdaDoc001;

      expect(textSearchAdaDoc001.getName(), kTextSearchAdaDoc001);
    });

    test('openai embedding model test null value', () {
      EmbedModel? textSearchAdaDoc001;

      expect(textSearchAdaDoc001, null);
    });
  });
}
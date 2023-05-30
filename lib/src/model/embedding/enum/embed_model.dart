import 'package:chat_gpt_sdk/src/utils/constants.dart';

enum EmbedModel { textEmbeddingAda002, textSearchAdaDoc001 }

extension EmbedExtension on EmbedModel {
  String getName() {
    switch (this) {
      case EmbedModel.textEmbeddingAda002:
        return kEmbeddingAda002;
      case EmbedModel.textSearchAdaDoc001:
        return kTextSearchAdaDoc001;
      default:
        return '';
    }
  }
}

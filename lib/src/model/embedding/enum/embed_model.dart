import 'package:chat_gpt_sdk/src/utils/constants.dart';

sealed class EmbedModel {
  String model;
  EmbedModel({required this.model});
}

class TextEmbeddingAda002EmbedModel extends EmbedModel {
  TextEmbeddingAda002EmbedModel() : super(model: kEmbeddingAda002);
}

class EmbedModelFromValue extends EmbedModel {
  EmbedModelFromValue({required super.model});
}

import 'package:chat_gpt_sdk/src/utils/constants.dart';

enum EmbedModel { EmbedTextModel }

extension embedExtension on EmbedModel {
  String getName() {
    switch (this) {
      case EmbedModel.EmbedTextModel:
        return kEmbedTextModel;
      default:
        return '';
    }
  }
}

class EmbedRequest {
  ///ID of the model to use. You can use the List models
  /// API to see all of your available models, or see our
  /// Model overview for descriptions of them.[model]
  final EmbedModel model;

  ///Input text to get embeddings for, encoded
  /// as a string or array of tokens. To get embeddings
  /// for multiple inputs in a single request, pass an array
  /// of strings or array of token arrays. Each input
  /// must not exceed 8192 tokens in length.[input]
  final String input;

  ///A unique identifier representing
  /// your end-user, which can help
  /// OpenAI to monitor and detect abuse.[user]
  final String? user;

  EmbedRequest({required this.model, required this.input, this.user = ""});

  Map<String, dynamic> toJson() =>
      Map.of({'model': model.getName(), 'input': input, 'user': user});
}

import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';

class EmbedRequest {
  ///ID of the model to use. You can use the List models
  /// API to see all of your available models, or see our
  /// Model overview for descriptions of them.[model]
  /// ## Embed models
  /// - TextEmbeddingAda002EmbedModel();
  /// - TextSearchAdaDoc001EmbedModel();
  /// - EmbedModelFromValue(model: 'your-model-name');
  final EmbedModel model;

  ///Input text to get embeddings for, encoded
  /// as a string or array of tokens. To get embeddings
  /// for multiple inputs in a single request, pass an array
  /// of strings or array of token arrays. Each input
  /// must not exceed 8192 tokens in length.[input]
  final dynamic input;

  ///A unique identifier representing
  /// your end-user, which can help
  /// OpenAI to monitor and detect abuse.[user]
  final String? user;

  ///The format to return the embeddings in. Can be either float or base64.
  /// [encodingFormat]
  final String? encodingFormat;

  final int? dimensions;

  EmbedRequest({
    required this.model,
    required this.input,
    this.user = "",
    this.encodingFormat,
    this.dimensions,
  });

  Map<String, dynamic> toJson() => Map.of({
        'model': model.model,
        'input': input,
        'user': user,
        'encoding_format': encodingFormat,
        'dimensions': dimensions,
      })
        ..removeWhere((_, value) => value == null);
}

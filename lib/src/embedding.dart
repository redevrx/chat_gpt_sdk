import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/model/embedding/request/embed_request.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'client/client.dart';
import 'model/embedding/response/embed_response.dart';

class Embedding {
  final OpenAIClient _client;
  Embedding(this._client);

  ///Get a vector representation of a given input
  /// that can be easily consumed by machine learning
  /// models and algorithms.[embedding]
  ///
  Future<EmbedResponse> embedding(
    EmbedRequest request, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kEmbedding,
      request.toJson(),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => EmbedResponse.fromJson(it),
    );
  }
}

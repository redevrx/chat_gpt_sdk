import 'package:chat_gpt_sdk/src/model/embedding/request/embed_request.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'client/client.dart';
import 'model/embedding/response/embed_response.dart';

class Embedding {
  final OpenAIClient _client;
  Embedding(this._client);

  final _cancel = CancelToken();

  ///Get a vector representation of a given input
  /// that can be easily consumed by machine learning
  /// models and algorithms.[embedding]
  ///
  Future<EmbedResponse> embedding(EmbedRequest request) async {
    return _client.post(kURL + kEmbedding, _cancel, request.toJson(),
        onSuccess: (it) => EmbedResponse.fromJson(it));
  }

  ///cancel embedding
  void cancelEmbedding() {
    _client.log.log("stop openAI embedding");
    _cancel.cancel();
  }
}

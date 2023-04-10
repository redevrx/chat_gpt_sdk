import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'client/client.dart';
import 'model/moderation/response/moderation_data.dart';

class Moderation {
  final OpenAIClient _client;
  Moderation(this._client);

  final _cancel = CancelToken();

  ///[input]
  ///The input text to classify
  ///[model]
  ///Two content moderations models are available:
  /// text-moderation-stable and text-moderation-latest.
  /// The default is text-moderation-latest which will
  /// be automatically upgraded over time. This ensures
  /// you are always using our most accurate model.
  /// If you use text-moderation-stable, we will
  /// provide advanced notice before updating the model.
  /// Accuracy of text-moderation-stable may be slightly
  /// lower than for text-moderation-latest.
  Future<ModerationData> create(
      {required String input,
      ModerationModel model = ModerationModel.textLast}) async {
    return _client.post(
        kURL + kModeration, _cancel, {"input": input, "model": model.getName()},
        onSuccess: (it) => ModerationData.fromJson(it));
  }

  ///cancel file
  void cancelModeration() {
    _client.log.log("stop openAI Moderation");
    _cancel.cancel();
  }
}

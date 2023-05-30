import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'client/client.dart';
import 'model/moderation/enum/moderation_model.dart';
import 'model/moderation/response/moderation_data.dart';

class Moderation {
  final OpenAIClient _client;
  Moderation(this._client);

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
  Future<ModerationData> create({
    required String input,
    ModerationModel model = ModerationModel.textLast,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      kURL + kModeration,
      {"input": input, "model": model.getName()},
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => ModerationData.fromJson(it),
    );
  }
}

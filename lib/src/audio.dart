import 'package:chat_gpt_sdk/src/model/audio/request/audio_request.dart';
import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'client/client.dart';
import 'model/audio/response/audio_response.dart';

class Audio {
  final OpenAIClient _client;
  Audio(this._client);

  ///Transcribes audio into the input language.[transcribes]
  Future<AudioResponse> transcribes(
    AudioRequest request, {
    void Function(CancelData cancelData)? onCancel,
  }) async {
    final mRequest = await request.toJson();

    return _client.postFormData(
      kURL + kTranscription,
      mRequest,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) => AudioResponse.fromJson(it),
    );
  }

  ///Translates audio into into English.[translate]
  Future<AudioResponse> translate(
    AudioRequest request, {
    void Function(CancelData cancelData)? onCancel,
  }) async {
    final mRequest = await request.toJson();

    return _client.postFormData(
      kURL + kTranslations,
      mRequest,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) => AudioResponse.fromJson(it),
    );
  }
}

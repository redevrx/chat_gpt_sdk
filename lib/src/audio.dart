import 'package:chat_gpt_sdk/src/model/audio/request/audio_request.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'client/client.dart';
import 'model/audio/response/audio_response.dart';

class Audio {
  final OpenAIClient _client;
  Audio(this._client);

  final _cancel = CancelToken();

  ///Transcribes audio into the input language.[transcribes]
  Future<AudioResponse> transcribes(AudioRequest request) async {
    final mRequest = await request.toJson();
    return _client.postFormData(kURL + kTranscription, _cancel, mRequest,
        complete: (it) => AudioResponse.fromJson(it));
  }

  ///Translates audio into into English.[translate]
  Future<AudioResponse> translate(AudioRequest request) async {
    final mRequest = await request.toJson();
    return _client.postFormData(kURL + kTranslations, _cancel, mRequest,
        complete: (it) => AudioResponse.fromJson(it));
  }

  ///cancel edit
  void cancelAudio() {
    _client.log.log("stop openAI Audio");
    _cancel.cancel();
  }
}

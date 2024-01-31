import 'dart:io';

import 'package:chat_gpt_sdk/src/model/audio/request/audio_request.dart';
import 'package:chat_gpt_sdk/src/model/audio/request/speech_request.dart';
import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
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
      _client.apiUrl + kTranscription,
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
      _client.apiUrl + kTranslations,
      mRequest,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) => AudioResponse.fromJson(it),
    );
  }

  ///Generates audio from the input text.
  /// [createSpeech]
  Future<File> createSpeech({
    required SpeechRequest request,
    String? savePath,
    String? fileName,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.postRawBody(
      _client.apiUrl + kCreateSpeech,
      request.toJson(),
      onSuccess: (it, fileExtension) async {
        final path = savePath ?? (await getApplicationCacheDirectory()).path;
        final name = fileName ?? DateTime.now().toIso8601String();
        final mFile = File(path + "/" + name + ".$fileExtension");

        mFile.writeAsBytes(it, mode: FileMode.write);

        return mFile;
      },
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }
}

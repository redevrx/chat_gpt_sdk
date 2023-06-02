import 'dart:io';

import 'package:chat_gpt_sdk/src/model/audio/enum/audio_format.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/edit_file.dart';
import 'package:dio/dio.dart';

class AudioRequest {
  ///The audio file to transcribe, in one of
  /// these formats: mp3, mp4, mpeg, mpga,
  /// m4a, wav, or webm.[file]
  final EditFile file;

  ///An optional text to guide the
  /// model's style or continue a previous
  /// audio segment. The prompt should match
  /// the audio language.[prompt]
  final String? prompt;

  ///The format of the transcript output,
  /// in one of these options: json,
  /// text, srt, verbose_json, or vtt. [responseFormat]
  final AudioFormat? responseFormat;

  ///The sampling temperature, between 0 and 1.
  /// Higher values like 0.8 will make the output more random,
  /// while lower values like 0.2 will make it more focused and
  /// deterministic. If set to 0, the model will use log probability
  /// to automatically increase the temperature
  /// until certain thresholds are hit.[temperature]
  final int temperature;

  ///The language of the input audio.
  /// Supplying the input language
  /// in ISO-639-1 format will improve
  /// accuracy and latency. [language]
  final String? language;

  AudioRequest({
    required this.file,
    this.prompt,
    this.responseFormat,
    this.temperature = 0,
    this.language,
  });

  Future<FormData> toJson() async {
    return FormData.fromMap({
      'file': File(file.name).existsSync()
          ? await MultipartFile.fromFile(file.path, filename: file.path)
          : null,
      'prompt': prompt,
      "model": "whisper-1",
      'response_format': responseFormat == null
          ? AudioFormat.json.getName()
          : responseFormat?.getName(),
      'temperature': temperature,
      'language': language,
    });
  }
}

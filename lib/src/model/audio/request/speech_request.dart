class SpeechRequest {
  ///One of the available
  ///<a href='https://platform.openai.com/docs/models/tts'>TTS models</a>
  ///: tts-1 or tts-1-hd
  ///[model]
  final String model;

  ///The text to generate audio for. The maximum length is 4096 characters.
  ///[input]
  final String input;

  ///The voice to use when generating the audio. Supported voices are alloy,
  /// echo, fable, onyx, nova, and shimmer.
  /// Previews of the voices are available in the
  ///<a href='https://platform.openai.com/docs/guides/text-to-speech/voice-options'>Text to speech guide.</a>
  final String voice;

  ///The format to audio in. Supported formats are mp3, opus, aac, and flac.
  ///[responseFormat]
  final String responseFormat;

  ///The speed of the generated audio.
  /// Select a value from 0.25 to 4.0. 1.0 is the default.
  /// [speed]
  final double? speed;

  SpeechRequest({
    required this.model,
    required this.input,
    this.voice = 'alloy',
    this.responseFormat = 'mp3',
    this.speed = 1,
  });

  Map<String, dynamic> toJson() => Map.of({
        'model': model,
        'input': input,
        'voice': voice,
        'response_format': responseFormat,
        'speed': speed,
      });
}

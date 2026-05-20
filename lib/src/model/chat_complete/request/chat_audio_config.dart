class ChatAudioConfig {
  /// The voice to use for audio outputs.
  /// alloy, echo, ash, coral, fable, onyx, nova, sage, shimmer
  final String voice;

  /// The format to return audio outputs in.
  /// wav, mp3, flac, opus, pcm16
  final String format;

  ChatAudioConfig({required this.voice, required this.format});

  Map<String, dynamic> toJson() => {'voice': voice, 'format': format};

  factory ChatAudioConfig.fromJson(Map<String, dynamic> json) =>
      ChatAudioConfig(
        voice: json['voice'] as String,
        format: json['format'] as String,
      );
}

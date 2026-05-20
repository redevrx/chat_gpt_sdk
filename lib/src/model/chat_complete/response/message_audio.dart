class MessageAudio {
  /// Unique identifier for this audio response.
  final String? id;

  /// Epoch timestamp when this audio response expires.
  final int? expiresAt;

  /// Base64 encoded audio data.
  final String? data;

  /// Transcript of the generated audio.
  final String? transcript;

  MessageAudio({this.id, this.expiresAt, this.data, this.transcript});

  factory MessageAudio.fromJson(Map<String, dynamic>? json) {
    if (json == null) return MessageAudio();
    return MessageAudio(
      id: json['id'] as String?,
      expiresAt: json['expires_at'] as int?,
      data: json['data'] as String?,
      transcript: json['transcript'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'expires_at': expiresAt,
    'data': data,
    'transcript': transcript,
  };
}

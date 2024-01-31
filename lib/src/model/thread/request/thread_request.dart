class ThreadRequest {
  final List<Map<String, dynamic>>? messages;

  ///Set of 16 key-value pairs that can be attached to an object.
  /// This can be useful for storing additional information about the
  /// object in a structured format. Keys can be a maximum of 64
  /// characters long and values can be a maxium of 512 characters long.
  /// [metadata]
  final Map<String, dynamic>? metadata;

  ThreadRequest({this.messages, this.metadata});

  Map<String, dynamic> toJson() => Map.of({
        'messages': messages,
        'metadata': metadata,
      })
        ..removeWhere((_, value) => value == null);
}

class ThreadRequest {
  final List<Map<String, dynamic>>? messages;

  ///Set of 16 key-value pairs that can be attached to an object.
  /// This can be useful for storing additional information about the
  /// object in a structured format. Keys can be a maximum of 64
  /// characters long and values can be a maxium of 512 characters long.
  /// [metadata]
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? tools;
  final Map<String, dynamic>? fileSearch;

  /// [fileIds]
  final List<String>? fileIds;

  ThreadRequest({
    this.messages,
    this.metadata,
    this.tools,
    this.fileSearch,
    this.fileIds,
  });

  Map<String, dynamic> toJson() => Map.of({
        'messages': messages,
        'metadata': metadata,
      })
        ..removeWhere((_, value) => value == null);

  Map<String, dynamic> toJsonV2() {
    final data = Map.of({
      'messages': messages,
      'metadata': metadata,
      "tools": tools,
      'tool_resources': {
        'file_search': fileSearch,
        'code_interpreter': {
          "file_ids": fileIds ?? [],
        },
      },
    })
      ..removeWhere((_, value) => value == null);

    if (fileSearch == null) {
      (data['tool_resources'] as Map?)?.remove('file_search');
    }

    if (fileIds?.isEmpty == true) {
      (data['tool_resources'] as Map?)?.remove('code_interpreter');
    }

    if (fileIds?.isEmpty == true && fileSearch == null) {
      data.remove('tool_resources');
    }

    return data;
  }
}

class CreateMessage {
  ///The role of the entity that is creating the message.
  /// Currently only user is supported.[role]
  final String role;

  ///The content of the message.[content]
  final String content;

  ///A list of
  ///<a href='https://platform.openai.com/docs/api-reference/files'>File</a>
  ///IDs that the message should use. There can be a maximum
  ///of 10 files attached to a message.
  /// Useful for tools like retrieval
  /// and code_interpreter that can access and use files.
  /// [fileIds]
  final List<Map<String, dynamic>>? fileIds;

  ///Set of 16 key-value pairs that can be attached to an object.
  /// This can be useful for storing additional
  /// information about the object in a structured format.
  /// Keys can be a maximum of 64 characters long and values
  /// can be a maxium of 512 characters long.
  /// [metadata]
  final Map<String, dynamic>? metadata;

  CreateMessage({
    required this.role,
    required this.content,
    this.fileIds,
    this.metadata,
  });

  Map<String, dynamic> toJson() => Map.of({
        'role': role,
        'content': content,
        'file_ids': fileIds,
        'metadata': metadata,
      })
        ..removeWhere((_, value) => value == null);
}

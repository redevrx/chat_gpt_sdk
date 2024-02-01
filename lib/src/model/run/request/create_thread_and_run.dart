class CreateThreadAndRun {
  ///The ID of the
  ///<a href='https://platform.openai.com/docs/api-reference/assistants'>assistant</a>
  /// to use to execute this run.
  /// [assistantId]
  final String assistantId;

  ///
  /// [thread]
  /// ## Example
  /// ```dart
  ///  {
  ///    "messages": [
  ///     {"role": "user", "content": "Explain deep learning to a 5 year old."}
  ///     ]
  ///   }
  /// ```
  final Map<String, dynamic>? thread;

  ///The ID of the
  ///<a href='https://platform.openai.com/docs/api-reference/models'>Model</a>
  /// to be used to execute this run.
  /// If a value is provided here, it will override the
  /// model associated with the assistant.
  /// If not, the model associated with the assistant will be used.
  /// [model]
  final String? model;

  ///Override the default system message of the assistant.
  /// This is useful for modifying the behavior on a per-run basis.
  /// [instructions]
  final String? instructions;

  ///Override the tools the assistant can use for this run.
  /// This is useful for modifying the behavior on a per-run basis.
  /// [tools]
  final List<Map<String, dynamic>>? tools;

  ///Set of 16 key-value pairs that can be attached to an object.
  /// This can be useful for storing additional information about
  /// the object in a structured format. Keys can be a maximum of 64
  /// characters long and values can be a maxium of 512 characters long.
  /// [metadata]
  final Map<String, dynamic>? metadata;

  CreateThreadAndRun({
    required this.assistantId,
    this.thread,
    this.model,
    this.instructions,
    this.tools,
    this.metadata,
  });

  Map<String, dynamic> toJson() => Map.of({
        'assistant_id': assistantId,
        'thread': thread,
        'model': model,
        'instructions': instructions,
        'tools': tools,
        'metadata': metadata,
      })
        ..removeWhere((_, value) => value == null);
}

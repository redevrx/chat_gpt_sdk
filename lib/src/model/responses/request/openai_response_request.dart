class OpenAiResponseRequest {
  /// The model to use for this response.
  final String model;

  /// The input to the model, which can be a String (text input)
  /// or a List of messages/items.
  final dynamic input;

  /// Optional reasoning parameters, e.g., effort level.
  final Map<String, dynamic>? reasoning;

  /// Optional flag indicating whether to run the model response in the background.
  final bool? background;

  /// Optional conversation that this response belongs to.
  /// Can be a conversation ID string or a conversation object.
  final dynamic conversation;

  /// Optional list of additional data to include in the model response.
  final List<String>? include;

  /// A list of tools the model may call (e.g. {"type": "web_search"}).
  final List<Map<String, dynamic>>? tools;

  /// Controls which (if any) tool is called by the model (e.g. "auto", "none", or a specific tool definition).
  final dynamic toolChoice;

  OpenAiResponseRequest({
    required this.model,
    required this.input,
    this.reasoning,
    this.background,
    this.conversation,
    this.include,
    this.tools,
    this.toolChoice,
  });

  Map<String, dynamic> toJson() => {
        'model': model,
        'input': input,
        if (reasoning != null) 'reasoning': reasoning,
        if (background != null) 'background': background,
        if (conversation != null) 'conversation': conversation,
        if (include != null) 'include': include,
        if (tools != null) 'tools': tools,
        if (toolChoice != null) 'tool_choice': toolChoice,
      };
}

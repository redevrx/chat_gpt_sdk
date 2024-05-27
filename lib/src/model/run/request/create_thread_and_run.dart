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

  ///A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the code_interpreter tool requires a list of file IDs, while the file_search tool requires a list of vector store IDs.
  final Map<String, dynamic>? toolResources;

  ///What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  final double? temperature;

  ///An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  ///
  /// We generally recommend altering this or temperature but not both.
  final double? topP;

  ///The maximum number of prompt tokens that may be used over the course of the run. The run will make a best effort to use only the number of prompt tokens specified, across multiple turns of the run. If the run exceeds the number of prompt tokens specified, the run will end with status incomplete. See incomplete_details for more info.
  final int? maxPromptTokens;

  ///The maximum number of completion tokens that may be used over the course of the run. The run will make a best effort to use only the number of completion tokens specified, across multiple turns of the run. If the run exceeds the number of completion tokens specified, the run will end with status incomplete. See incomplete_details for more info.
  final int? maxCompletionTokens;

  ///Controls for how a thread will be truncated prior to the run. Use this to control the intial context window of the run.
  final Map<String, dynamic>? truncationStrategy;

  ///Controls which (if any) tool is called by the model. none means the model will not call any tools and instead generates a message. auto is the default value and means the model can pick between generating a message or calling one or more tools. required means the model must call one or more tools before responding to the user. Specifying a particular tool like {"type": "file_search"} or {"type": "function", "function": {"name": "my_function"}} forces the model to call that tool.
  dynamic toolChoice;

  ///Specifies the format that the model must output. Compatible with GPT-4o, GPT-4 Turbo, and all GPT-3.5 Turbo models since gpt-3.5-turbo-1106.
  ///
  /// Setting to { "type": "json_object" } enables JSON mode, which guarantees the message the model generates is valid JSON.
  ///
  /// Important: when using JSON mode, you must also instruct the model to produce JSON yourself via a system or user message. Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit, resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off if finish_reason="length", which indicates the generation exceeded max_tokens or the conversation exceeded the max context length.
  dynamic responseFormat;

  CreateThreadAndRun({
    required this.assistantId,
    this.thread,
    this.model,
    this.instructions,
    this.tools,
    this.metadata,
    this.toolResources,
    this.temperature,
    this.topP,
    this.maxPromptTokens,
    this.maxCompletionTokens,
    this.truncationStrategy,
  });

  Map<String, dynamic> toJson() => Map.of({
        'assistant_id': assistantId,
        'thread': thread,
        'model': model,
        'instructions': instructions,
        'tools': tools,
        'metadata': metadata,
        'tool_resources': toolResources,
        'temperature': temperature,
        'top_p': topP,
        'max_prompt_tokens': maxPromptTokens,
        'max_completion_tokens': maxCompletionTokens,
        'truncation_strategy': truncationStrategy,
        'tool_choice': toolChoice,
        'response_format': responseFormat,
      })
        ..removeWhere((_, value) => value == null);
}

import 'package:chat_gpt_sdk/src/model/assistant/enum/assistant_model.dart';

class Assistant {
  ///ID of the model to use. You can use the List models
  /// API to see all of your available models, or see our Model
  /// overview for descriptions of them.
  /// [model]
  final AssistantModel model;

  ///The name of the assistant. The maximum length is 256 characters.
  ///[name]
  final String? name;

  ///The description of the assistant. The maximum length is 512 characters.
  ///[description]
  final String? description;

  ///The system instructions that the assistant uses.
  /// The maximum length is 32768 characters.
  /// [instructions]
  final String? instructions;

  ///A list of tool enabled on the assistant.
  /// There can be a maximum of 128 tools per assistant.
  /// Tools can be of types code_interpreter, retrieval, or
  /// https://platform.openai.com/docs/api-reference/assistants/createAssistant
  /// ### Code Interpreter
  /// "tools": [
  ///       { "type": "code_interpreter" }
  ///     ]
  ///### Enabling Retrieval
  ///"tools": [{"type": "retrieval"}]
  /// [tools]
  final List? tools;

  ///A list of file IDs attached to this assistant.
  /// There can be a maximum of 20 files attached to the assistant.
  /// Files are ordered by their creation date in ascending order.
  /// [fileIds]
  final List? fileIds;

  ///Set of 16 key-value pairs that can be attached to an object.
  /// This can be useful for storing additional information
  /// about the object in a structured format.
  /// Keys can be a maximum of 64 characters
  /// long and values can be a maxium of 512 characters long.
  /// [metadata]
  final Map? metadata;

  Assistant({
    required this.model,
    this.name,
    this.description,
    this.instructions,
    this.tools,
    this.fileIds,
    this.metadata,
  });

  Map<String, dynamic> toJson() => Map.of({
        "model": model.model,
        'name': name,
        'description': description,
        'instructions': instructions,
        'tools': tools ?? [],
        'file_ids': fileIds ?? [],
        'metadata': metadata ?? {},
      });
}

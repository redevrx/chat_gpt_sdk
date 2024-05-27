import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';
import 'package:chat_gpt_sdk/src/model/run/response/step_detail.dart';

class CreateRunResponse {
  CreateRunResponse({
    required this.metadata,
    required this.assistantId,
    required this.createdAt,
    required this.tools,
    required this.completedAt,
    required this.threadId,
    required this.fileIds,
    required this.startedAt,
    required this.model,
    required this.id,
    required this.object,
    required this.status,
    required this.usage,
    required this.instructions,
    required this.lastError,
    required this.failedAt,
    required this.cancelledAt,
    required this.expiresAt,
    required this.type,
    required this.stepDetails,
    this.requiredAction,
    this.incompleteDetails,
    this.temperature,
    this.topP,
    this.maxPromptTokens,
    this.maxCompletionTokens,
    this.truncationStrategy,
    this.toolChoice,
    this.responseFormat,
    this.toolResources,
  });

  Map<String, dynamic> metadata;
  String assistantId;
  int createdAt;
  List tools;
  int completedAt;
  String threadId;
  List<String> fileIds;
  int startedAt;
  String model;
  String id;
  String object;
  String status;
  Usage? usage;
  String instructions;
  Map<String, dynamic> lastError;
  int failedAt;
  int cancelledAt;
  int expiresAt;
  String type;
  StepDetail? stepDetails;
  Map<String, dynamic>? requiredAction;
  Map<String, dynamic>? incompleteDetails;
  double? temperature;
  double? topP;
  int? maxPromptTokens;
  int? maxCompletionTokens;
  Map<String, dynamic>? truncationStrategy;
  dynamic toolChoice;
  dynamic responseFormat;
  Map<String, dynamic>? toolResources;

  factory CreateRunResponse.fromJson(Map<String, dynamic> json) =>
      CreateRunResponse(
        metadata: json["metadata"] ?? {},
        assistantId: json["assistant_id"] ?? '',
        createdAt: json["created_at"] ?? 0,
        tools: json["tools"] == null
            ? []
            : List<dynamic>.from(json["tools"].map((x) => x)),
        completedAt: json["completed_at"] ?? 0,
        threadId: json["thread_id"] ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : List<String>.from(json["file_ids"].map((x) => x)),
        startedAt: json["started_at"] ?? 0,
        model: json["model"] ?? '',
        id: json["id"] ?? '',
        object: json["object"] ?? '',
        status: json["status"] ?? '',
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
        instructions: json['instructions'] ?? '',
        lastError: json['last_error'] ?? {},
        failedAt: json['failed_at'] ?? 0,
        cancelledAt: json['cancelled_at'] ?? 0,
        expiresAt: json['expires_at'] ?? 0,
        type: json['type'] ?? '',
        stepDetails: json['step_details'] == null
            ? null
            : StepDetail.fromJson(json['step_details']),
        requiredAction: json['required_action'],
        incompleteDetails: json['incomplete_details'],
        temperature: json['temperature'],
        topP: json['top_p'],
        maxPromptTokens: json['max_prompt_tokens'],
        maxCompletionTokens: json['max_completion_tokens'],
        truncationStrategy: json['truncation_strategy'],
        toolChoice: json['tool_choice'],
        responseFormat: json['response_format'],
        toolResources: json['tool_resources'],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata,
        "assistant_id": assistantId,
        "created_at": createdAt,
        "usage": usage?.toJson(),
        "tools": tools.map((x) => x.toJson()),
        "completed_at": completedAt,
        "thread_id": threadId,
        "file_ids": fileIds,
        "started_at": startedAt,
        "model": model,
        "id": id,
        "object": object,
        "status": status,
        'instructions': instructions,
        'last_error': lastError,
        'failed_at': failedAt,
        'cancelled_at': cancelledAt,
        'expires_at': expiresAt,
        'type': type,
        'step_details': stepDetails?.toJson(),
        'required_action': requiredAction,
        'incomplete_details': incompleteDetails,
        'temperature': temperature,
        'top_p': topP,
        'max_prompt_tokens': maxPromptTokens,
        'max_completion_tokens': maxCompletionTokens,
        'truncation_strategy': truncationStrategy,
        'tool_choice': toolChoice,
        'response_format': responseFormat,
        'tool_resources': toolResources,
      };
}

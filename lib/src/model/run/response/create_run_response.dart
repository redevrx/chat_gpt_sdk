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
        metadata: json["metadata"] == null
            ? {}
            : Map<String, dynamic>.from(json["metadata"]),
        assistantId: json["assistant_id"] as String? ?? '',
        createdAt: json["created_at"] as int? ?? 0,
        tools: json["tools"] == null
            ? []
            : List<dynamic>.from((json["tools"] as List? ?? []).map((x) => x)),
        completedAt: json["completed_at"] as int? ?? 0,
        threadId: json["thread_id"] as String? ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : List<String>.from(
                (json["file_ids"] as List? ?? []).map((x) => x.toString()),
              ),
        startedAt: json["started_at"] as int? ?? 0,
        model: json["model"] as String? ?? '',
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        status: json["status"] as String? ?? '',
        usage: json["usage"] == null
            ? null
            : Usage.fromJson(Map<String, dynamic>.from(json["usage"])),
        instructions: json['instructions'] as String? ?? '',
        lastError: json['last_error'] == null
            ? {}
            : Map<String, dynamic>.from(json['last_error']),
        failedAt: json['failed_at'] as int? ?? 0,
        cancelledAt: json['cancelled_at'] as int? ?? 0,
        expiresAt: json['expires_at'] as int? ?? 0,
        type: json['type'] as String? ?? '',
        stepDetails: json['step_details'] == null
            ? null
            : StepDetail.fromJson(
                Map<String, dynamic>.from(json['step_details']),
              ),
        requiredAction: json['required_action'] == null
            ? null
            : Map<String, dynamic>.from(json['required_action']),
        incompleteDetails: json['incomplete_details'] == null
            ? null
            : Map<String, dynamic>.from(json['incomplete_details']),
        temperature: (json['temperature'] as num?)?.toDouble(),
        topP: (json['top_p'] as num?)?.toDouble(),
        maxPromptTokens: json['max_prompt_tokens'] as int?,
        maxCompletionTokens: json['max_completion_tokens'] as int?,
        truncationStrategy: json['truncation_strategy'] == null
            ? null
            : Map<String, dynamic>.from(json['truncation_strategy']),
        toolChoice: json['tool_choice'],
        responseFormat: json['response_format'],
        toolResources: json['tool_resources'] == null
            ? null
            : Map<String, dynamic>.from(json['tool_resources']),
      );

  Map<String, dynamic> toJson() => {
    "metadata": metadata,
    "assistant_id": assistantId,
    "created_at": createdAt,
    "usage": usage?.toJson(),
    "tools": tools.map((x) {
      try {
        return x.toJson();
      } catch (_) {
        return x;
      }
    }).toList(),
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

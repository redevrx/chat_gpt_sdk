import 'package:chat_gpt_sdk/src/model/message/response/content_v2.dart';

class CreateMessageV2Response {
  String id;
  String object;
  int createdAt;
  String threadId;
  String role;
  List<ContentV2> content;
  String assistantId;
  String runId;
  List<dynamic> attachments;
  Map<String, dynamic> metadata;

  CreateMessageV2Response({
    required this.id,
    required this.object,
    required this.createdAt,
    required this.threadId,
    required this.role,
    required this.content,
    required this.assistantId,
    required this.runId,
    required this.attachments,
    required this.metadata,
  });

  factory CreateMessageV2Response.fromJson(Map<String, dynamic> json) =>
      CreateMessageV2Response(
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        createdAt: json["created_at"] as int? ?? 0,
        threadId: json["thread_id"] as String? ?? '',
        role: json["role"] as String? ?? '',
        content: json["content"] == null
            ? []
            : List<ContentV2>.from(
                (json["content"] as List? ?? [])
                    .map((x) => ContentV2.fromJson(Map<String, dynamic>.from(x))),
              ),
        assistantId: json["assistant_id"] as String? ?? '',
        runId: json["run_id"] as String? ?? '',
        attachments: json["attachments"] == null
            ? []
            : List<dynamic>.from((json["attachments"] as List? ?? []).map((x) => x)),
        metadata: json["metadata"] == null
            ? {}
            : Map<String, dynamic>.from(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created_at": createdAt,
    "thread_id": threadId,
    "role": role,
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "assistant_id": assistantId,
    "run_id": runId,
    "attachments": List<dynamic>.from(attachments.map((x) => x)),
    "metadata": metadata,
  };
}

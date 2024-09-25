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
        id: json["id"] ?? '',
        object: json["object"] ?? '',
        createdAt: json["created_at"] ?? 0,
        threadId: json["thread_id"] ?? '',
        role: json["role"] ?? '',
        content: List<ContentV2>.from(
            json["content"].map((x) => ContentV2.fromJson(x))),
        assistantId: json["assistant_id"] ?? '',
        runId: json["run_id"] ?? '',
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        metadata: json["metadata"] ?? {},
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

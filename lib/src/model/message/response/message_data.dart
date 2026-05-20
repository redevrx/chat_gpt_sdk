import 'package:chat_gpt_sdk/src/model/message/response/content.dart';

class MessageData {
  MessageData({
    required this.threadId,
    required this.metadata,
    required this.role,
    required this.fileIds,
    required this.createdAt,
    required this.id,
    required this.content,
    required this.object,
    required this.assistantId,
    required this.runId,
  });

  String threadId;
  Map<String, dynamic>? metadata;
  String role;
  List<String> fileIds;
  int createdAt;
  String id;
  List<Content> content;
  String object;
  String assistantId;
  String runId;

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        threadId: json["thread_id"] as String? ?? '',
        metadata: json["metadata"] == null
            ? null
            : Map<String, dynamic>.from(json["metadata"]),
        role: json["role"] as String? ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : (json["file_ids"] as List? ?? []).map((x) => x.toString()).toList(),
        createdAt: json["created_at"] as int? ?? 0,
        id: json["id"] as String? ?? '',
        content: json["content"] == null
            ? []
            : List<Content>.from(
                (json["content"] as List? ?? [])
                    .map((x) => Content.fromJson(Map<String, dynamic>.from(x))),
              ),
        object: json["object"] as String? ?? '',
        assistantId: json['assistant_id'] as String? ?? '',
        runId: json['run_id'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "thread_id": threadId,
    "metadata": metadata,
    "role": role,
    "file_ids": fileIds.map((x) => x).toList(),
    "created_at": createdAt,
    "id": id,
    "content": content.map((x) => x.toJson()).toList(),
    "object": object,
    'assistant_id': assistantId,
    'run_id': runId,
  };
}

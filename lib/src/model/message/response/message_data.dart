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
        threadId: json["thread_id"] ?? '',
        metadata: json["metadata"] == null ? null : json["metadata"],
        role: json["role"] ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : List<String>.from(json["file_ids"].map((x) => x)),
        createdAt: json["created_at"] ?? 0,
        id: json["id"] ?? '',
        content: json["content"] == null
            ? []
            : List<Content>.from(
                json["content"].map((x) => Content.fromJson(x)),
              ),
        object: json["object"] ?? '',
        assistantId: json['assistant_id'] ?? '',
        runId: json['run_id'] ?? '',
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

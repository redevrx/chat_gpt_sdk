class CreateThreadAndRunData {
  CreateThreadAndRunData({
    required this.instructions,
    required this.metadata,
    required this.assistantId,
    required this.createdAt,
    required this.tools,
    required this.threadId,
    required this.expiresAt,
    required this.fileIds,
    required this.model,
    required this.id,
    required this.object,
    required this.status,
  });

  String instructions;
  Map<String, dynamic> metadata;
  String assistantId;
  int createdAt;
  List<Map<String, dynamic>> tools;
  String threadId;
  int expiresAt;
  List<Map<String, dynamic>> fileIds;
  String model;
  String id;
  String object;
  String status;

  factory CreateThreadAndRunData.fromJson(Map<String, dynamic> json) =>
      CreateThreadAndRunData(
        instructions: json["instructions"] ?? '',
        metadata: json["metadata"] ?? {},
        assistantId: json["assistant_id"] ?? '',
        createdAt: json["created_at"] ?? '',
        tools: json["tools"] == null
            ? []
            : List<Map<String, dynamic>>.from(json["tools"].map((x) => x)),
        threadId: json["thread_id"] ?? '',
        expiresAt: json["expires_at"] ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : List<Map<String, dynamic>>.from(json["file_ids"].map((x) => x)),
        model: json["model"] ?? '',
        id: json["id"] ?? '',
        object: json["object"] ?? '',
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions,
        "metadata": metadata,
        "assistant_id": assistantId,
        "created_at": createdAt,
        "tools": tools,
        "thread_id": threadId,
        "expires_at": expiresAt,
        "file_ids": fileIds,
        "model": model,
        "id": id,
        "object": object,
        "status": status,
      };
}

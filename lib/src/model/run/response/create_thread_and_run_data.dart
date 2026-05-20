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
        instructions: json["instructions"] as String? ?? '',
        metadata: json["metadata"] == null
            ? {}
            : Map<String, dynamic>.from(json["metadata"]),
        assistantId: json["assistant_id"] as String? ?? '',
        createdAt: json["created_at"] as int? ?? 0,
        tools: json["tools"] == null
            ? []
            : List<Map<String, dynamic>>.from(
                (json["tools"] as List? ?? [])
                    .map((x) => Map<String, dynamic>.from(x)),
              ),
        threadId: json["thread_id"] as String? ?? '',
        expiresAt: json["expires_at"] as int? ?? 0,
        fileIds: json["file_ids"] == null
            ? []
            : List<Map<String, dynamic>>.from(
                (json["file_ids"] as List? ?? [])
                    .map((x) => Map<String, dynamic>.from(x)),
              ),
        model: json["model"] as String? ?? '',
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        status: json["status"] as String? ?? '',
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

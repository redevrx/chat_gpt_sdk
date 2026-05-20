class AssistantFileData {
  AssistantFileData({
    required this.assistantId,
    required this.createdAt,
    required this.id,
    required this.object,
  });

  String assistantId;
  int createdAt;
  String id;
  String object;

  factory AssistantFileData.fromJson(Map<String, dynamic> json) =>
      AssistantFileData(
        assistantId: json["assistant_id"] as String? ?? '',
        createdAt: json["created_at"] as int? ?? 0,
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "assistant_id": assistantId,
    "created_at": createdAt,
    "id": id,
    "object": object,
  };
}

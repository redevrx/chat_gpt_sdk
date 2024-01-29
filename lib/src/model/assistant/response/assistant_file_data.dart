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
        assistantId: json["assistant_id"] ?? '',
        createdAt: json["created_at"] ?? 0,
        id: json["id"] ?? '',
        object: json["object"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "assistant_id": assistantId,
        "created_at": createdAt,
        "id": id,
        "object": object,
      };
}

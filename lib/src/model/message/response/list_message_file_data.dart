class ListMessageFileData {
  ListMessageFileData({
    required this.createdAt,
    required this.messageId,
    required this.id,
    required this.object,
  });

  int createdAt;
  String messageId;
  String id;
  String object;

  factory ListMessageFileData.fromJson(Map<String, dynamic> json) =>
      ListMessageFileData(
        createdAt: json["created_at"] as int? ?? 0,
        messageId: json["message_id"] as String? ?? '',
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt,
    "message_id": messageId,
    "id": id,
    "object": object,
  };
}

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
        createdAt: json["created_at"] ?? 0,
        messageId: json["message_id"] ?? '',
        id: json["id"] ?? '',
        object: json["object"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "message_id": messageId,
        "id": id,
        "object": object,
      };
}

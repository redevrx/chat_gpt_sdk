class MessageCreation {
  MessageCreation({
    required this.messageId,
  });

  String messageId;

  factory MessageCreation.fromJson(Map<String, dynamic> json) =>
      MessageCreation(
        messageId: json["message_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "message_id": messageId,
      };
}

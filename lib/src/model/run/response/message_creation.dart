class MessageCreation {
  MessageCreation({required this.messageId});

  String messageId;

  factory MessageCreation.fromJson(Map<String, dynamic> json) =>
      MessageCreation(messageId: json["message_id"] as String? ?? '');

  Map<String, dynamic> toJson() => {"message_id": messageId};
}

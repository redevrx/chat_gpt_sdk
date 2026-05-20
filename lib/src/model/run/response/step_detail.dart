import 'message_creation.dart';

class StepDetail {
  StepDetail({required this.messageCreation, required this.type});

  MessageCreation messageCreation;
  String type;

  factory StepDetail.fromJson(Map<String, dynamic> json) => StepDetail(
        messageCreation: json["message_creation"] == null
            ? MessageCreation(messageId: '')
            : MessageCreation.fromJson(
                Map<String, dynamic>.from(json["message_creation"]),
              ),
        type: json["type"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "message_creation": messageCreation.toJson(),
    "type": type,
  };
}

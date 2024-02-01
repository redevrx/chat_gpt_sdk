import 'message_creation.dart';

class StepDetail {
  StepDetail({
    required this.messageCreation,
    required this.type,
  });

  MessageCreation messageCreation;
  String type;

  factory StepDetail.fromJson(Map<String, dynamic> json) => StepDetail(
        messageCreation: MessageCreation.fromJson(json["message_creation"]),
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "message_creation": messageCreation.toJson(),
        "type": type,
      };
}

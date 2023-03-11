import 'message.dart';

class ChatChoice {
  final int index;
  final Message message;
  final String? finishReason;

  ChatChoice(
      {required this.index, required this.message, required this.finishReason});

  factory ChatChoice.fromJson(Map<String, dynamic> json) => ChatChoice(
        index: json["index"],
        message: Message.fromJson(json["message"]),
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "message": message.toJson(),
        "finish_reason": finishReason ?? "",
      };
}

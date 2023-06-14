import 'package:chat_gpt_sdk/src/model/chat_complete/response/message.dart';

class ChatChoiceSSE {
  final String id = "${DateTime.now().millisecondsSinceEpoch}";
  final int index;
  final Message? message;
  final String? finishReason;

  ChatChoiceSSE({
    required this.index,
    required this.message,
    this.finishReason,
  });

  factory ChatChoiceSSE.fromJson(Map<String, dynamic> json) => ChatChoiceSSE(
        index: json["index"],
        message: json["delta"] == null ? null : Message.fromJson(json["delta"]),
        finishReason:
            json["finish_reason"] == null ? "" : json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "delta": message?.toJson(),
        "finish_reason": finishReason ?? "",
      };
}

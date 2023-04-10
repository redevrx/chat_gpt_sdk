import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice_sse.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

class ChatCTResponseSSE {
  final String id;
  final String object;
  final int created;
  final List<ChatChoiceSSE> choices;
  final Usage? usage;
  final String conversionId = "${DateTime.now().millisecondsSinceEpoch}";

  ChatCTResponseSSE(
      {required this.id,
      required this.object,
      required this.created,
      required this.choices,
      required this.usage});

  factory ChatCTResponseSSE.fromJson(Map<String, dynamic> json) =>
      ChatCTResponseSSE(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        choices: List<ChatChoiceSSE>.from(
            json["choices"].map((x) => ChatChoiceSSE.fromJson(x))),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage?.toJson(),
      };
}

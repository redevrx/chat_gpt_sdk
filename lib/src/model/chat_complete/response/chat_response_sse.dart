import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice_sse.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

class ChatResponseSSE {
  final String id;
  final String object;
  final int created;
  final List<ChatChoiceSSE> choices;
  final Usage? usage;
  String conversionId = "${DateTime.now().millisecondsSinceEpoch}";

  ChatResponseSSE(
      {required this.id,
      required this.object,
      required this.created,
      required this.choices,
      required this.usage,});

  factory ChatResponseSSE.fromJson(Map<String, dynamic> json) =>
      ChatResponseSSE(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        choices: List<ChatChoiceSSE>.from(
            json["choices"].map((x) => ChatChoiceSSE.fromJson(x)),),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "choices": List<Map>.from(choices.map((x) => x.toJson())),
        "usage": usage?.toJson(),
      };
}

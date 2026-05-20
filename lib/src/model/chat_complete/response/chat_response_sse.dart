import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice_sse.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

class ChatResponseSSE {
  final String id;
  final String object;
  final int? created;
  final List<ChatChoiceSSE>? choices;
  final Usage? usage;
  final String? model;
  String conversionId = "${DateTime.now().millisecondsSinceEpoch}";

  ChatResponseSSE({
    required this.id,
    required this.object,
    required this.created,
    required this.choices,
    required this.usage,
    this.model,
  });

  factory ChatResponseSSE.fromJson(Map<String, dynamic> json) =>
      ChatResponseSSE(
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        created: json["created"] as int?,
        model: json["model"] as String?,
        choices: (json["choices"] == null)
            ? null
            : (json["choices"] as List? ?? [])
                  .map((e) => ChatChoiceSSE.fromJson(Map<String, dynamic>.from(e)))
                  .toList(),
        usage: json["usage"] == null
            ? null
            : Usage.fromJson(Map<String, dynamic>.from(json["usage"])),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created": created,
    "choices": choices?.map((e) => e.toJson()).toList(),
    "usage": usage?.toJson(),
    "model": model,
  };
}

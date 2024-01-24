import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';

import '../../complete_text/response/usage.dart';

class ChatCTResponse {
  final String id;
  final String object;
  final int created;
  final List<ChatChoice> choices;
  final Usage? usage;
  final String conversionId = "${DateTime.now().millisecondsSinceEpoch}";
  final String? systemFingerprint;
  final String model;

  ChatCTResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.choices,
    required this.usage,
    required this.systemFingerprint,
    required this.model,
  });

  factory ChatCTResponse.fromJson(Map<String, dynamic> json) => ChatCTResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        choices: List<ChatChoice>.from(
          json["choices"].map((x) => ChatChoice.fromJson(x)),
        ),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
        systemFingerprint: json['system_fingerprint'] ?? '',
        model: json['model'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "choices": List<Map>.from(choices.map((x) => x.toJson())),
        "usage": usage?.toJson(),
        "system_fingerprint": systemFingerprint,
        'model': model,
      };
}

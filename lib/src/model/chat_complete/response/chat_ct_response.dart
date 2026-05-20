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
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        created: json["created"] as int? ?? 0,
        choices: json["choices"] == null
            ? []
            : List<ChatChoice>.from(
                (json["choices"] as List? ?? [])
                    .map((x) => ChatChoice.fromJson(Map<String, dynamic>.from(x))),
              ),
        usage: json["usage"] == null
            ? null
            : Usage.fromJson(Map<String, dynamic>.from(json["usage"])),
        systemFingerprint: json['system_fingerprint'] as String? ?? '',
        model: json['model'] as String? ?? '',
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

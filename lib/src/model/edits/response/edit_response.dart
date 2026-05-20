import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

class EditResponse {
  EditResponse({
    required this.object,
    required this.created,
    required this.choices,
    required this.usage,
  });

  String object;
  int created;
  List<Choice> choices;
  Usage usage;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  factory EditResponse.fromJson(Map<String, dynamic> json) => EditResponse(
        object: json["object"] as String? ?? '',
        created: json["created"] as int? ?? 0,
        choices: json["choices"] == null
            ? []
            : List<Choice>.from(
                (json["choices"] as List? ?? [])
                    .map((x) => Choice.fromJson(Map<String, dynamic>.from(x))),
              ),
        usage: json["usage"] == null
            ? Usage(0, 0, 0)
            : Usage.fromJson(Map<String, dynamic>.from(json["usage"])),
      );

  Map<String, dynamic> toJson() => {
    "object": object,
    "created": created,
    "choices": List<Map>.from(choices.map((x) => x.toJson())),
    "usage": usage.toJson(),
  };
}

class Choice {
  Choice({required this.text, required this.index});

  String text;
  int index;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        text: json["text"] as String? ?? '',
        index: json["index"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {"text": text, "index": index};
}

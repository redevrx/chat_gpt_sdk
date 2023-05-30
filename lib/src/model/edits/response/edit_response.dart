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
        object: json["object"],
        created: json["created"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        usage: Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "created": created,
        "choices": List<Map>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
      };
}

class Choice {
  Choice({
    required this.text,
    required this.index,
  });

  String text;
  int index;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        text: json["text"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "index": index,
      };
}

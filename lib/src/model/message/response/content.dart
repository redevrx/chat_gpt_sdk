import 'package:chat_gpt_sdk/src/model/message/response/text.dart';

class Content {
  Content({
    required this.text,
    required this.type,
  });

  Text? text;
  String type;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        text: json["text"] == null ? null : Text.fromJson(json["text"]),
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "text": text?.toJson(),
        "type": type,
      };
}

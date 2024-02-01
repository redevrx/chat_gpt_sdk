import 'package:chat_gpt_sdk/src/model/message/response/text_data.dart';

class Content {
  Content({
    required this.text,
    required this.type,
  });

  TextData? text;
  String type;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        text: json["text"] == null ? null : TextData.fromJson(json["text"]),
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "text": text?.toJson(),
        "type": type,
      };
}

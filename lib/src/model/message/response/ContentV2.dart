import 'package:chat_gpt_sdk/src/model/message/response/text_data.dart';

class ContentV2 {
  String type;
  TextData text;

  ContentV2({
    required this.type,
    required this.text,
  });

  factory ContentV2.fromJson(Map<String, dynamic> json) => ContentV2(
        type: json["type"],
        text: TextData.fromJson(json["text"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text.toJson(),
      };
}

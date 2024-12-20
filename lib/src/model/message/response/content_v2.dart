import 'package:chat_gpt_sdk/src/model/message/response/text_data.dart';
import 'package:chat_gpt_sdk/src/model/message/response/image_data.dart';

class ContentV2 {
  String type;
  TextData? text;
  ImageData? image;

  ContentV2({
    required this.type,
    this.text,
    this.image,
  });

  factory ContentV2.fromJson(Map<String, dynamic> json) {
    final type = json["type"];
    final image = (type == 'image_url' || type == 'image_file')
        ? json[type] != null
        ? ImageData.fromJson(json[type]!)
        : null
        : null;

    return ContentV2(
      type: type,
      text: type == 'text' && json["text"] != null ? TextData.fromJson(json["text"]!) : null,
      image: image,
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "text": text?.toJson(),
    type: image?.toJson(), // Dynamically set 'image_url' or 'image_file'
  };
}

import 'package:chat_gpt_sdk/src/model/gen_image/response/image_data.dart';

class GenImgResponse {
  GenImgResponse({
    this.created,
    this.data,
  });

  int? created;
  List<ImageData?>? data;
  final String conversionId = "${DateTime.now().millisecondsSinceEpoch}";

  factory GenImgResponse.fromJson(Map<String, dynamic> json) => GenImgResponse(
        created: json["created"],
        data: json["data"] == null
            ? []
            : List<ImageData?>.from(
                json["data"]!.map((x) => ImageData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "data":
            data == null ? [] : List<Map>.from(data!.map((x) => x!.toJson())),
      };
}

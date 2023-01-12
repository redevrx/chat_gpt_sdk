

class GenerateImgRes {
  GenerateImgRes({
    this.created,
    this.data,
  });

  int? created;
  List<ImgData?>? data;

  factory GenerateImgRes.fromJson(Map<String, dynamic> json) => GenerateImgRes(
    created: json["created"],
    data: json["data"] == null ? [] : List<ImgData?>.from(json["data"]!.map((x) => ImgData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "created": created,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
  };
}

class ImgData {
  ImgData({
    this.url,
  });

  String? url;

  factory ImgData.fromJson(Map<String, dynamic> json) => ImgData(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
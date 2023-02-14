class ImageData {
  ImageData({
    this.url,
    this.b64Json
  });

  String? url;
  String? b64Json;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    url: json["url"],
    b64Json: json["b64_json"]
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "b64_json": b64Json
  };
}
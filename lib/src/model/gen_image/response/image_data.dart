class ImageData {
  ImageData({this.url, this.b64Json});

  String? url;
  String? b64Json;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        url: json["url"] as String?,
        b64Json: json["b64_json"] as String?,
      );

  Map<String, dynamic> toJson() => {"url": url, "b64_json": b64Json};
}

class ImageData {
  ImageData({
    this.url,
  });

  String? url;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
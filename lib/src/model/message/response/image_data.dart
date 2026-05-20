class ImageData {
  String? url;
  String? fileId;
  String? detail;

  ImageData({this.url, this.fileId, this.detail});

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        fileId: json["file_id"] as String? ?? '',
        url: json["url"] as String? ?? '',
        detail: json["detail"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "file_id": fileId,
    "url": url,
    "detail": detail,
  };
}

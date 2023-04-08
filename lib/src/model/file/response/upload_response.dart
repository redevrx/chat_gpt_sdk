class UploadResponse {
  UploadResponse({
    required this.id,
    required this.object,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  String id;
  String object;
  int bytes;
  int createdAt;
  String filename;
  String purpose;

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
        id: json["id"],
        object: json["object"],
        bytes: json["bytes"],
        createdAt: json["created_at"],
        filename: json["filename"],
        purpose: json["purpose"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "bytes": bytes,
        "created_at": createdAt,
        "filename": filename,
        "purpose": purpose,
      };
}

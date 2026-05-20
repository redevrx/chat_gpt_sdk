class FileData {
  FileData({
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

  factory FileData.fromJson(Map<String, dynamic> json) => FileData(
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        bytes: json["bytes"] as int? ?? 0,
        createdAt: json["created_at"] as int? ?? 0,
        filename: json["filename"] as String? ?? '',
        purpose: json["purpose"] as String? ?? '',
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

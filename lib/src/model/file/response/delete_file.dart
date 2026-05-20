class DeleteFile {
  DeleteFile({required this.id, required this.object, required this.deleted});

  String id;
  String object;
  bool deleted;

  factory DeleteFile.fromJson(Map<String, dynamic> json) => DeleteFile(
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        deleted: json["deleted"] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "deleted": deleted,
  };
}

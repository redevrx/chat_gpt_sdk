class ThreadDeleteResponse {
  ThreadDeleteResponse({
    required this.deleted,
    required this.id,
    required this.object,
  });

  bool deleted;
  String id;
  String object;

  factory ThreadDeleteResponse.fromJson(Map<String, dynamic> json) =>
      ThreadDeleteResponse(
        deleted: json["deleted"] ?? false,
        id: json["id"] ?? '',
        object: json["object"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "deleted": deleted,
        "id": id,
        "object": object,
      };
}

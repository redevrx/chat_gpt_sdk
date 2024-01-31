class ThreadResponse {
  ThreadResponse({
    required this.metadata,
    required this.createdAt,
    required this.id,
    required this.object,
  });

  Map<String, dynamic> metadata;
  int createdAt;
  String id;
  String object;

  factory ThreadResponse.fromJson(Map<String, dynamic> json) => ThreadResponse(
        metadata: json["metadata"] ?? {},
        createdAt: json["created_at"] ?? 0,
        id: json["id"] ?? '',
        object: json["object"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata,
        "created_at": createdAt,
        "id": id,
        "object": object,
      };
}

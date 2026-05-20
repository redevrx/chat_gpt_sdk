class ThreadResponse {
  ThreadResponse({
    required this.metadata,
    required this.createdAt,
    required this.id,
    required this.object,
    this.toolResources,
  });

  Map<String, dynamic> metadata;
  int createdAt;
  String id;
  String object;
  Map<String, dynamic>? toolResources;

  factory ThreadResponse.fromJson(Map<String, dynamic> json) => ThreadResponse(
        metadata: json["metadata"] == null
            ? {}
            : Map<String, dynamic>.from(json["metadata"]),
        createdAt: json["created_at"] as int? ?? 0,
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        toolResources: json['tool_resources'] == null
            ? null
            : Map<String, dynamic>.from(json['tool_resources']),
      );

  Map<String, dynamic> toJson() => {
    "metadata": metadata,
    "created_at": createdAt,
    "id": id,
    "object": object,
    'tool_resources': toolResources,
  };
}

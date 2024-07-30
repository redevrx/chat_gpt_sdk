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
  Map<String, double>? toolResources;

  factory ThreadResponse.fromJson(Map<String, dynamic> json) => ThreadResponse(
      metadata: json["metadata"] ?? {},
      createdAt: json["created_at"] ?? 0,
      id: json["id"] ?? '',
      object: json["object"] ?? '',
      toolResources: json['tool_resources'] is Map<String, double>
          ? json['tool_resources']
          : null);

  Map<String, dynamic> toJson() => {
        "metadata": metadata,
        "created_at": createdAt,
        "id": id,
        "object": object,
        'tool_resources': toolResources,
      };
}

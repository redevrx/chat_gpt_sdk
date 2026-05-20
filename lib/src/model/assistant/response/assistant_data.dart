class AssistantData {
  AssistantData({
    required this.instructions,
    required this.metadata,
    required this.name,
    required this.fileIds,
    required this.createdAt,
    required this.model,
    required this.id,
    required this.tools,
    required this.object,
    this.description,
    this.topP,
    this.temperature,
  });

  String instructions;
  Map metadata;
  String name;
  List<String> fileIds;
  int createdAt;
  String model;
  String id;
  List<dynamic> tools;
  String object;
  final String? description;
  final double? topP;
  final double? temperature;

  factory AssistantData.fromJson(Map<String, dynamic> json) => AssistantData(
        instructions: json["instructions"] as String? ?? '',
        metadata: json["metadata"] == null
            ? {}
            : Map<dynamic, dynamic>.from(json["metadata"]),
        name: json["name"] as String? ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : List<String>.from(
                (json["file_ids"] as List? ?? []).map((x) => x.toString()),
              ),
        createdAt: json["created_at"] as int? ?? 0,
        model: json["model"] as String? ?? '',
        id: json["id"] as String? ?? '',
        tools: json["tools"] == null
            ? []
            : List<dynamic>.from((json["tools"] as List? ?? []).map((x) => x)),
        object: json["object"] as String? ?? '',
        description: json['description'] as String?,
        topP: (json['top_p'] as num?)?.toDouble(),
        temperature: (json['temperature'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "instructions": instructions,
    "metadata": metadata,
    "name": name,
    "file_ids": fileIds.map((x) => x).toList(),
    "created_at": createdAt,
    "model": model,
    "id": id,
    "tools": tools.map((x) {
      try {
        return x.toJson();
      } catch (_) {
        return x;
      }
    }).toList(),
    "object": object,
    'description': description,
    'top_p': topP,
    'temperature': temperature,
  };
}

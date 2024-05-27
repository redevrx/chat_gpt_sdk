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
        instructions: json["instructions"] ?? '',
        metadata: json["metadata"] ?? {},
        name: json["name"] ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : List<String>.from(json["file_ids"].map((x) => x)),
        createdAt: json["created_at"] ?? 0,
        model: json["model"] ?? '',
        id: json["id"] ?? '',
        tools: json["tools"] == null
            ? []
            : List<dynamic>.from(json["tools"].map((x) => x)),
        object: json["object"],
        description: json['description'],
        topP: json['top_p'],
        temperature: json['temperature'],
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions,
        "metadata": metadata,
        "name": name,
        "file_ids": fileIds.map((x) => x),
        "created_at": createdAt,
        "model": model,
        "id": id,
        "tools": tools.map((x) => x.toJson()),
        "object": object,
        'description': description,
        'top_p': topP,
        'temperature': temperature,
      };
}

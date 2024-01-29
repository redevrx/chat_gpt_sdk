import 'package:chat_gpt_sdk/src/model/assistant/response/tool.dart';

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
  });

  String instructions;
  Map metadata;
  String name;
  List<Map<String, dynamic>> fileIds;
  int createdAt;
  String model;
  String id;
  List<Tool> tools;
  String object;

  factory AssistantData.fromJson(Map<String, dynamic> json) => AssistantData(
        instructions: json["instructions"] ?? '',
        metadata: json["metadata"] ?? {},
        name: json["name"] ?? '',
        fileIds: json["file_ids"] == null
            ? []
            : List<Map<String, dynamic>>.from(json["file_ids"].map((x) => x)),
        createdAt: json["created_at"] ?? 0,
        model: json["model"] ?? '',
        id: json["id"] ?? '',
        tools: json["tools"] == null
            ? []
            : List<Tool>.from(json["tools"].map((x) => Tool.fromJson(x))),
        object: json["object"],
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
      };
}

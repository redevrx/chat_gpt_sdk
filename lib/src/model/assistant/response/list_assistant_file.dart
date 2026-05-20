import 'package:chat_gpt_sdk/src/model/assistant/response/assistant_file_data.dart';

class ListAssistantFile {
  String object;
  List<AssistantFileData> data;
  String firstId;
  String lastId;
  bool hasMore;

  ListAssistantFile({
    required this.object,
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory ListAssistantFile.fromJson(Map<String, dynamic> json) =>
      ListAssistantFile(
        object: json["object"] as String? ?? '',
        data: json["data"] == null
            ? []
            : List<AssistantFileData>.from(
                (json["data"] as List? ?? [])
                    .map((x) => AssistantFileData.fromJson(Map<String, dynamic>.from(x))),
              ),
        firstId: json["first_id"] as String? ?? '',
        lastId: json["last_id"] as String? ?? '',
        hasMore: json["has_more"] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": data.map((x) => x.toJson()),
    "first_id": firstId,
    "last_id": lastId,
    "has_more": hasMore,
  };
}

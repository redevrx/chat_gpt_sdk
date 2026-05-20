import 'list_message_file_data.dart';

class ListMessageFile {
  ListMessageFile({
    required this.firstId,
    required this.data,
    required this.lastId,
    required this.hasMore,
    required this.object,
  });

  String firstId;
  List<ListMessageFileData> data;
  String lastId;
  bool hasMore;
  String object;

  factory ListMessageFile.fromJson(Map<String, dynamic> json) =>
      ListMessageFile(
        firstId: json["first_id"] as String? ?? '',
        data: json["data"] == null
            ? []
            : List<ListMessageFileData>.from(
                (json["data"] as List? ?? [])
                    .map((x) => ListMessageFileData.fromJson(Map<String, dynamic>.from(x))),
              ),
        lastId: json["last_id"] as String? ?? '',
        hasMore: json["has_more"] as bool? ?? false,
        object: json["object"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "first_id": firstId,
    "data": data.map((x) => x.toJson()),
    "last_id": lastId,
    "has_more": hasMore,
    "object": object,
  };
}

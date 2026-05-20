import 'package:chat_gpt_sdk/src/model/run/response/create_run_response.dart';

class ListRun {
  ListRun({
    required this.firstId,
    required this.data,
    required this.lastId,
    required this.hasMore,
    required this.object,
  });

  String firstId;
  List<CreateRunResponse> data;
  String lastId;
  bool hasMore;
  String object;

  factory ListRun.fromJson(Map<String, dynamic> json) => ListRun(
        firstId: json["first_id"] as String? ?? '',
        data: json["data"] == null
            ? []
            : List<CreateRunResponse>.from(
                (json["data"] as List? ?? [])
                    .map((x) => CreateRunResponse.fromJson(Map<String, dynamic>.from(x))),
              ),
        lastId: json["last_id"] as String? ?? '',
        hasMore: json["has_more"] as bool? ?? false,
        object: json["object"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "first_id": firstId,
    "data": data.map((x) => x.toJson()).toList(),
    "last_id": lastId,
    "has_more": hasMore,
    "object": object,
  };
}

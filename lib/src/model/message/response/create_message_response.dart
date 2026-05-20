import 'message_data.dart';

class CreateMessageResponse {
  CreateMessageResponse({
    required this.firstId,
    required this.data,
    required this.lastId,
    required this.hasMore,
    required this.object,
  });

  String firstId;
  List<MessageData> data;
  String lastId;
  bool hasMore;
  String object;

  factory CreateMessageResponse.fromJson(Map<String, dynamic> json) =>
      CreateMessageResponse(
        firstId: json["first_id"] as String? ?? '',
        data: json["data"] == null
            ? []
            : List<MessageData>.from(
                (json["data"] as List? ?? [])
                    .map((x) => MessageData.fromJson(Map<String, dynamic>.from(x))),
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

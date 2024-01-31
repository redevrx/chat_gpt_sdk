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
        firstId: json["first_id"] ?? '',
        data: json["data"] == null
            ? []
            : List<MessageData>.from(
                json["data"].map((x) => MessageData.fromJson(x)),
              ),
        lastId: json["last_id"] ?? '',
        hasMore: json["has_more"] ?? false,
        object: json["object"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "first_id": firstId,
        "data": data.map((x) => x.toJson()).toList(),
        "last_id": lastId,
        "has_more": hasMore,
        "object": object,
      };
}

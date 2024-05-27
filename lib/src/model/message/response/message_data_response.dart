import 'package:chat_gpt_sdk/src/model/message/response/create_message_v2_response.dart';

class MessageDataResponse {
  MessageDataResponse({
    required this.firstId,
    required this.data,
    required this.lastId,
    required this.hasMore,
    required this.object,
  });

  String firstId;
  List<CreateMessageV2Response> data;
  String lastId;
  bool hasMore;
  String object;

  factory MessageDataResponse.fromJson(Map<String, dynamic> json) =>
      MessageDataResponse(
        firstId: json["first_id"] ?? '',
        data: json["data"] == null
            ? []
            : List<CreateMessageV2Response>.from(
                json["data"].map((x) => CreateMessageV2Response.fromJson(x)),
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

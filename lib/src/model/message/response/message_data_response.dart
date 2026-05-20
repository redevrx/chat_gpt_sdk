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
        firstId: json["first_id"] as String? ?? '',
        data: json["data"] == null
            ? []
            : List<CreateMessageV2Response>.from(
                (json["data"] as List? ?? [])
                    .map((x) => CreateMessageV2Response.fromJson(Map<String, dynamic>.from(x))),
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

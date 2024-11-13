import 'package:chat_gpt_sdk/src/model/chat_complete/request/json_schema.dart';

class ResponseFormat {
  final String type;
  final JsonSchema? json_schema;

  ResponseFormat({required this.type, this.json_schema});

  ResponseFormat.jsonSchema({required this.json_schema}) : type = 'json_schema';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (json_schema != null) {
      data['json_schema'] = json_schema!.toJson();
    }

    return data;
  }

  static final jsonObject = ResponseFormat(type: "json_object");
}

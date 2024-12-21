import 'package:chat_gpt_sdk/src/model/chat_complete/request/json_schema.dart';

class ResponseFormat {
  final String type;
  final JsonSchema? jsonSchema;

  ResponseFormat({required this.type, this.jsonSchema});

  ResponseFormat.jsonSchema({required this.jsonSchema}) : type = 'json_schema';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (jsonSchema != null) {
      data['json_schema'] = jsonSchema!.toJson();
    }

    return data;
  }

  static final jsonObject = ResponseFormat(type: "json_object");
}

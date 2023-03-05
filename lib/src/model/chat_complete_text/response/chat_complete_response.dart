import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

import 'choices.dart';

class GPTResponse {
  final String id;
  final String object;
  final int created;
  final List<Choices> choices;
  final Usage usage;

  GPTResponse(this.id, this.object, this.created, this.choices, this.usage);

  factory GPTResponse.fromJson(Map<String, dynamic> json) => GPTResponse(
        json['id'] as String,
        json['object'] as String,
        json['created'] as int,
        (json['choices'] as List<dynamic>)
            .map((e) => Choices.fromJson(e as Map<String, dynamic>))
            .toList(),
        Usage.fromJson(json['usage'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => responseToJson(this);

  Map<String, dynamic> responseToJson(GPTResponse instance) =>
      <String, dynamic>{
        'id': instance.id,
        'object': instance.object,
        'created': instance.created,
        'choices': instance.choices,
        'usage': instance.usage,
      };
}

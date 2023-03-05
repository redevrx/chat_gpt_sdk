import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

import 'choices.dart';

///CT is Complete text [CTResponse]
class CTResponse {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choices> choices;
  final Usage usage;

  CTResponse(
      this.id, this.object, this.created, this.model, this.choices, this.usage);

  factory CTResponse.fromJson(Map<String, dynamic> json) => CTResponse(
        json['id'] as String,
        json['object'] as String,
        json['created'] as int,
        json['model'] as String,
        (json['choices'] as List<dynamic>)
            .map((e) => Choices.fromJson(e as Map<String, dynamic>))
            .toList(),
        Usage.fromJson(json['usage'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => responseToJson(this);

  Map<String, dynamic> responseToJson(CTResponse instance) => <String, dynamic>{
        'id': instance.id,
        'object': instance.object,
        'created': instance.created,
        'model': instance.model,
        'choices': instance.choices,
        'usage': instance.usage,
      };
}

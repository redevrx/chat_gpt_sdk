import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

import 'choices.dart';

///CT is Complete text [CompleteResponse]
class CompleteResponse {
  final String conversionId = "${DateTime.now().millisecondsSinceEpoch}";
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choices> choices;
  final Usage? usage;

  CompleteResponse(
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
  );

  factory CompleteResponse.fromJson(Map<String, dynamic> json) =>
      CompleteResponse(
        json['id'],
        json['object'],
        json['created'],
        json['model'],
        (json['choices'] as List)
            .map((e) => Choices.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['usage'] == null
            ? null
            : Usage.fromJson(json['usage'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => responseToJson(this);

  Map<String, dynamic> responseToJson(CompleteResponse instance) =>
      <String, dynamic>{
        'id': instance.id,
        'object': instance.object,
        'created': instance.created,
        'model': instance.model,
        'choices': instance.choices,
        'usage': instance.usage,
      };
}

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
        json['id'] as String? ?? '',
        json['object'] as String? ?? '',
        json['created'] as int? ?? 0,
        json['model'] as String? ?? '',
        (json['choices'] as List? ?? [])
            .map((e) => Choices.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        json['usage'] == null
            ? null
            : Usage.fromJson(Map<String, dynamic>.from(json['usage'])),
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteRes _$CompleteResFromJson(Map<String, dynamic> json) => CompleteRes(
      json['id'] as String,
      json['object'] as String,
      json['created'] as int,
      json['model'] as String,
      (json['choices'] as List<dynamic>)
          .map((e) => Choices.fromJson(e as Map<String, dynamic>))
          .toList(),
      Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompleteResToJson(CompleteRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
      'usage': instance.usage,
    };

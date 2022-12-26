// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Choices _$ChoicesFromJson(Map<String, dynamic> json) => Choices(
      json['text'] as String,
      json['index'] as int,
      json['logprobs'],
      json['finish_reason'] as String,
    );

Map<String, dynamic> _$ChoicesToJson(Choices instance) => <String, dynamic>{
      'text': instance.text,
      'index': instance.index,
      'logprobs': instance.logprobs,
      'finish_reason': instance.finish_reason,
    };

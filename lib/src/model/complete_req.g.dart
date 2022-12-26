// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteReq _$CompleteReqFromJson(Map<String, dynamic> json) => CompleteReq(
      prompt: json['prompt'] as String,
      model: json['model'] as String,
      temperature: (json['temperature'] as num?)?.toDouble() ?? .3,
      max_tokens: json['max_tokens'] as int? ?? 100,
      top_p: (json['top_p'] as num?)?.toDouble() ?? 1.0,
      frequency_penalty: (json['frequency_penalty'] as num?)?.toDouble() ?? .0,
      presence_penalty: (json['presence_penalty'] as num?)?.toDouble() ?? .0,
    );

Map<String, dynamic> _$CompleteReqToJson(CompleteReq instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'model': instance.model,
      'temperature': instance.temperature,
      'max_tokens': instance.max_tokens,
      'top_p': instance.top_p,
      'frequency_penalty': instance.frequency_penalty,
      'presence_penalty': instance.presence_penalty,
    };

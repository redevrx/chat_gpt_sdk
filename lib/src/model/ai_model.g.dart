// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiModel _$AiModelFromJson(Map<String, dynamic> json) => AiModel(
      (json['data'] as List<dynamic>)
          .map((e) => ModelData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['object'] as String,
    );

Map<String, dynamic> _$AiModelToJson(AiModel instance) => <String, dynamic>{
      'data': instance.data,
      'object': instance.object,
    };

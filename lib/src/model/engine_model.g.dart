// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineModel _$EngineModelFromJson(Map<String, dynamic> json) => EngineModel(
      (json['data'] as List<dynamic>)
          .map((e) => EngineData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['object'] as String,
    );

Map<String, dynamic> _$EngineModelToJson(EngineModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'object': instance.object,
    };

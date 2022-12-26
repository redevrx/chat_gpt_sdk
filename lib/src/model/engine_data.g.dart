// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engine_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineData _$EngineDataFromJson(Map<String, dynamic> json) => EngineData(
      json['id'] as String,
      json['object'] as String,
      json['owner'] as String,
      json['ready'] as bool,
    );

Map<String, dynamic> _$EngineDataToJson(EngineData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'owner': instance.owner,
      'ready': instance.ready,
    };

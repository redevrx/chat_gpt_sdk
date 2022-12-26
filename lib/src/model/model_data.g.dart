// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelData _$ModelDataFromJson(Map<String, dynamic> json) => ModelData(
      json['id'] as String,
      json['object'] as String,
      json['owned_by'] as String,
      (json['permission'] as List<dynamic>)
          .map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelDataToJson(ModelData instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'owned_by': instance.owned_by,
      'permission': instance.permission,
    };

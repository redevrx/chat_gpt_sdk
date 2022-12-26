// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'err_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorData _$ErrorDataFromJson(Map<String, dynamic> json) => ErrorData(
      json['message'] as String,
      json['type'] as String,
      json['param'],
      json['code'] as String,
    );

Map<String, dynamic> _$ErrorDataToJson(ErrorData instance) => <String, dynamic>{
      'message': instance.message,
      'type': instance.type,
      'param': instance.param,
      'code': instance.code,
    };

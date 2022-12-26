// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      json['id'] as String,
      json['object'] as String,
      json['created'] as int,
      json['allow_create_engine'] as bool,
      json['allow_sampling'] as bool,
      json['allow_logprobs'] as bool,
      json['allow_search_indices'] as bool,
      json['allow_view'] as bool,
      json['allow_fine_tuning'] as bool,
      json['organization'] as String,
      json['group'],
      json['is_blocking'] as bool?,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'allow_create_engine': instance.allow_create_engine,
      'allow_sampling': instance.allow_sampling,
      'allow_logprobs': instance.allow_logprobs,
      'allow_search_indices': instance.allow_search_indices,
      'allow_view': instance.allow_view,
      'allow_fine_tuning': instance.allow_fine_tuning,
      'organization': instance.organization,
      'group': instance.group,
      'is_blocking': instance.is_blocking,
    };

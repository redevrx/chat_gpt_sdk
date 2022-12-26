import 'package:json_annotation/json_annotation.dart';
part 'permission.g.dart';

@JsonSerializable()
class Permission {
  final String id;
  final String object;
  final int created;
  final bool allow_create_engine;
  final bool allow_sampling;
  final bool allow_logprobs;
  final bool allow_search_indices;
  final bool allow_view;
  final bool allow_fine_tuning;
  final String organization;
  final dynamic group;
  final bool? is_blocking;

  Permission(this.id, this.object, this.created, this.allow_create_engine, this.allow_sampling, this.allow_logprobs, this.allow_search_indices, this.allow_view, this.allow_fine_tuning, this.organization, this.group, this.is_blocking);
  factory Permission.fromJson(Map<String,dynamic> data) => _$PermissionFromJson(data);
  Map<String,dynamic> toJson() => _$PermissionToJson(this);
}

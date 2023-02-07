import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';

class ModelData {
  final String id;
  final String object;
  final String ownerBy;
  final List<Permission>? permission;

  ModelData(this.id, this.object, this.ownerBy, this.permission);
  factory ModelData.fromJson(Map<String,dynamic> json) => ModelData(
    json['id'] as String,
    json['object'] as String,
    json['owned_by'] as String,
    json['permission'] == null ? null : (json['permission'] as List<dynamic>)
        .map((e) => Permission.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String,dynamic> toJson() =><String, dynamic>{
    'id': id,
    'object': object,
    'owned_by': ownerBy,
    'permission': permission,
  };

}
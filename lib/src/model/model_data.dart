import 'package:chat_gpt_sdk/src/model/permission.dart';
import 'package:json_annotation/json_annotation.dart';
part 'model_data.g.dart';

@JsonSerializable()
class ModelData {
  final String id;
  final String object;
  final String owned_by;
  final List<Permission> permission;

  ModelData(this.id, this.object, this.owned_by, this.permission);
  factory ModelData.fromJson(Map<String,dynamic> data) => _$ModelDataFromJson(data);
  Map<String,dynamic> toJson() => _$ModelDataToJson(this);
}
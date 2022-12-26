
import 'package:json_annotation/json_annotation.dart';
import 'engine_data.dart';
part 'engine_model.g.dart';

@JsonSerializable()
class EngineModel {
  final List<EngineData> data;
  final String object;

  EngineModel(this.data, this.object);
  factory EngineModel.fromJson(Map<String,dynamic> data) => _$EngineModelFromJson(data);
  Map<String,dynamic> toJson() => _$EngineModelToJson(this);
}
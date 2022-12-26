
import 'package:json_annotation/json_annotation.dart';
part 'engine_data.g.dart';

@JsonSerializable()
class EngineData {
  final String id;
  final String object;
  final String owner;
  final bool ready;

  EngineData(this.id, this.object, this.owner, this.ready);
  factory EngineData.fromJson(Map<String,dynamic> data) => _$EngineDataFromJson(data);
  Map<String,dynamic> toJson() => _$EngineDataToJson(this);
}
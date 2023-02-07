import 'engine_data.dart';

class EngineModel {
  final List<EngineData> data;
  final String object;

  EngineModel(this.data, this.object);
  factory EngineModel.fromJson(Map<String, dynamic> json) => EngineModel(
        (json['data'] as List<dynamic>)
            .map((e) => EngineData.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['object'] as String,
      );

  Map<String, dynamic> toJson() => _EngineModelToJson(this);
  Map<String, dynamic> _EngineModelToJson(EngineModel instance) =>
      <String, dynamic>{
        'data': instance.data,
        'object': instance.object,
      };
}

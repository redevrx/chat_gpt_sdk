import 'model_data.dart';

class AiModel {
  final List<ModelData> data;
  final String object;

  AiModel(this.data, this.object);
  factory AiModel.fromJson(Map<String, dynamic> json) => AiModel(
        (json['data'] as List<Map>)
            .map((e) => ModelData.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['object'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'object': object,
      };
}

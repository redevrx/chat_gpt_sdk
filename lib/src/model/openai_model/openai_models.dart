import 'openai_model_data.dart';

class AiModel {
  final List<ModelData> data;
  final dynamic object;

  AiModel(this.data, this.object);
  factory AiModel.fromJson(Map<String, dynamic> json) => AiModel(
        (json['data'] as List<dynamic>)
            .map((e) => ModelData.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['object'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'object': object,
      };
}

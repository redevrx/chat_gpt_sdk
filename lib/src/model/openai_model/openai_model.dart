import 'model_data.dart';

class OpenAiModel {
  final List<ModelData> data;
  final String object;

  OpenAiModel(this.data, this.object);
  factory OpenAiModel.fromJson(Map<String, dynamic> json) => OpenAiModel(
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

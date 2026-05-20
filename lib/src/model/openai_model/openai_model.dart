import 'model_data.dart';

class OpenAiModel {
  final List<ModelData> data;
  final String object;

  OpenAiModel(this.data, this.object);

  factory OpenAiModel.fromJson(Map<String, dynamic> json) => OpenAiModel(
        (json['data'] as List? ?? [])
            .map((e) => ModelData.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        json['object'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'object': object,
  };
}

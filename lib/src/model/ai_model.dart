import 'package:chat_gpt/src/model/model_data.dart';
import 'package:flutter/physics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ai_model.g.dart';

@JsonSerializable()
class AiModel {
  final List<ModelData> data;
  final String object;

  AiModel(this.data, this.object);
  factory AiModel.fromJson(Map<String,dynamic> data) => _$AiModelFromJson(data);
  Map<String,dynamic> toJson() => _$AiModelToJson(this);
}


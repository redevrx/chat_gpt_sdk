import 'package:chat_gpt/src/model/usage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'choices.dart';
part 'complete_res.g.dart';

@JsonSerializable()
class CompleteRes {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choices> choices;
  final Usage usage;

  CompleteRes(
      this.id, this.object, this.created, this.model, this.choices, this.usage);

  factory CompleteRes.fromJson(Map<String, dynamic> data) =>
      _$CompleteResFromJson(data);
  Map<String, dynamic> toJson() => _$CompleteResToJson(this);
}

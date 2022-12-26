import 'package:json_annotation/json_annotation.dart';
part 'choices.g.dart';

@JsonSerializable()
class Choices {
  final String text;
  final int index;
  final dynamic? logprobs;
  final String finish_reason;

  Choices(this.text, this.index, this.logprobs, this.finish_reason);

  factory Choices.fromJson(Map<String,dynamic> data) => _$ChoicesFromJson(data);
  Map<String,dynamic> toJson() => _$ChoicesToJson(this);
}
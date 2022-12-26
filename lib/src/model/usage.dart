import 'package:json_annotation/json_annotation.dart';
part 'usage.g.dart';

@JsonSerializable()
class Usage {
  final int prompt_tokens;
  final int completion_tokens;
  final int total_tokens;

  Usage(this.prompt_tokens, this.completion_tokens, this.total_tokens);

  factory Usage.fromJson(Map<String,dynamic> data) => _$UsageFromJson(data);
  Map<String,dynamic> toJson() => _$UsageToJson(this);
}
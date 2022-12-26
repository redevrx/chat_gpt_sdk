import 'package:json_annotation/json_annotation.dart';
part 'err_data.g.dart';

@JsonSerializable()
class ErrorData {
  final String message;
  final String type;
  final dynamic param;
  final String code;

  ErrorData(this.message, this.type, this.param, this.code);

  factory ErrorData.fromJson(Map<String,dynamic> data) => _$ErrorDataFromJson(data);
  Map<String,dynamic> toJson() => _$ErrorDataToJson(this);
}
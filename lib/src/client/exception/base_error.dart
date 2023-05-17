import 'package:chat_gpt_sdk/src/model/error/error_model.dart';

abstract class BaseErrorWrapper implements Exception {
  final OpenAIError? data;
  final int? code;

  BaseErrorWrapper({this.data, this.code});

  @override
  String toString() => "status code :$code  message :${data?.error?.toMap()}\n";
}

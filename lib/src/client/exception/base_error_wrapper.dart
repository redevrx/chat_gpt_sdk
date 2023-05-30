import 'package:chat_gpt_sdk/src/model/error/openai_error.dart';

abstract class BaseErrorWrapper implements Exception {
  final OpenAIError? data;
  final int? code;

  BaseErrorWrapper({this.data, this.code});

  @override
  String toString() => "status code :$code  message :${data?.error.toMap()}\n";
}

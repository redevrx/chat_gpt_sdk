import 'package:chat_gpt_sdk/src/client/exception/base_error_wrapper.dart';

class MissingNameException extends BaseErrorWrapper {
  @override
  String toString() =>
      "OpenAI Function Call Message Model Require Name Parameter";
}

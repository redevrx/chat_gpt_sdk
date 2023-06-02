import 'package:chat_gpt_sdk/src/client/exception/base_error_wrapper.dart';

///[MissingTokenException]
///not found access token
class MissingTokenException extends BaseErrorWrapper {
  @override
  String toString() =>
      "Not Missing Your Token look more https://beta.openai.com/account/api-keys";
}

import 'package:chat_gpt_sdk/src/client/exception/base_error.dart';

class MissionTokenException extends BaseErrorWrapper {
  @override
  String toString() =>
      "Not Missing Your Token look more https://beta.openai.com/account/api-keys";
}

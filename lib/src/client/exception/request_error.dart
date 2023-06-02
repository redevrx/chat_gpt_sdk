import 'package:chat_gpt_sdk/src/client/exception/base_error_wrapper.dart';

///[RequestError]
///narmal error
class RequestError extends BaseErrorWrapper {
  RequestError({super.data, super.code});
}

///Cause: Invalid Authentication
/// Solution: Ensure the correct API
/// key and requesting organization are being used.
class OpenAIAuthError extends BaseErrorWrapper {
  OpenAIAuthError({super.data, super.code});
}

///Cause: You are sending requests too quickly.
/// Solution: Pace your requests. Read the Rate limit guide.
class OpenAIRateLimitError extends BaseErrorWrapper {
  OpenAIRateLimitError({super.data, super.code});
}

///Cause: Issue on our servers.
///Solution: Retry your request
/// after a brief wait and
/// contact us if the issue persists. Check the status page.
class OpenAIServerError extends BaseErrorWrapper {
  OpenAIServerError({super.data, super.code});
}

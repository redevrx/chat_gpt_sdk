import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/client/exception/base_error_wrapper.dart';
import 'package:chat_gpt_sdk/src/model/error/openai_error.dart';
import 'package:test/test.dart';

void main() {
  group('base error wrapper test', () {
    test("base error wrapper test implement MissingTokenException", () {
      expect(MissingTokenException(), isA<BaseErrorWrapper>());
    });
    test("base error wrapper test implement OpenAIAuthError", () {
      final authError = OpenAIAuthError(
        data: OpenAIError(
          message: "",
          error: ErrorData.fromJson(null),
        ),
        code: 404,
      );
      authError.toString();
      expect(authError, isA<BaseErrorWrapper>());
    });
    test("base error wrapper test implement OpenAIServerError", () {
      final serverError = OpenAIServerError(
        data: OpenAIError(
          message: "",
          error: ErrorData.fromJson(null),
        ),
        code: 404,
      );
      serverError.toString();
      expect(serverError, isA<BaseErrorWrapper>());
    });
    test("base error wrapper test implement OpenAIRateLimitError", () {
      final rateLimit = OpenAIRateLimitError(
        data: OpenAIError(
          message: "",
          error: ErrorData.fromJson(null),
        ),
        code: 404,
      );
      rateLimit.toString();

      expect(rateLimit, isA<BaseErrorWrapper>());
    });
    test("base error wrapper test implement OpenAIRateLimitError", () {
      final requestError = RequestError(
        data: OpenAIError(
          message: "",
          error: ErrorData.fromJson(null),
        ),
        code: 404,
      );
      requestError.toString();

      expect(requestError, isA<BaseErrorWrapper>());
    });
  });
}

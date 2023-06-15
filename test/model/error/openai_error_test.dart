import 'package:chat_gpt_sdk/src/model/error/openai_error.dart';
import 'package:test/test.dart';

void main() {
  group('openai error data test', () {
    test('openai error data test from json', () {
      final json = {
        "error": {"message": "message", "code": '404', "type": "type"},
      };

      final errorData = OpenAIError.fromJson(json, 'message');

      expect(errorData.error.code, '404');
      expect(errorData.message, 'message');
    });
    test('openai error data test to json', () {
      final json = OpenAIError(
        message: 'message',
        error: ErrorData.fromJson(
          {"message": "message", "code": '404', "type": "type"},
        ),
      );

      expect(json.message, 'message');
      expect(
        json.error.toMap(),
        {"message": "message", "code": '404', "type": "type"},
      );
    });
  });
}

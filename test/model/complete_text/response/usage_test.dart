import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';
import 'package:test/test.dart';

void main() {
  group('fromJson', () {
    test('should create a Usage object from a valid json', () {
      final json = {
        "prompt_tokens": 50,
        "completion_tokens": 10,
        "total_tokens": 60,
      };

      final usage = Usage.fromJson(json);

      expect(usage.promptTokens, 50);
      expect(usage.completionTokens, 10);
      expect(usage.totalTokens, 60);
    });

    test(
      'should create a Usage object from a valid json without completion tokens',
      () {
        final json = {
          "prompt_tokens": 50,
          "total_tokens": 50,
        };

        final usage = Usage.fromJson(json);

        expect(usage.promptTokens, 50);
        expect(usage.totalTokens, 50);
      },
    );
  });

  group('toJson', () {
    test('should create a valid json from a Usage object', () {
      final usage = Usage(50, 10, 60);

      final json = usage.toJson();

      expect(json['prompt_tokens'], 50);
      expect(json['completion_tokens'], 10);
      expect(json['total_tokens'], 60);
    });
  });
}

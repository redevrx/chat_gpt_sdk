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
        final json = {"prompt_tokens": 50, "total_tokens": 50};

        final usage = Usage.fromJson(json);

        expect(usage.promptTokens, 50);
        expect(usage.totalTokens, 50);
      },
    );
    test(
      'should create a Usage object from a valid json with completion_tokens_details',
      () {
        final json = {
          "prompt_tokens": 50,
          "completion_tokens": 30,
          "total_tokens": 80,
          "completion_tokens_details": {
            "reasoning_tokens": 20,
            "accepted_prediction_tokens": 0,
            "rejected_prediction_tokens": 0,
          },
        };

        final usage = Usage.fromJson(json);

        expect(usage.promptTokens, 50);
        expect(usage.completionTokens, 30);
        expect(usage.totalTokens, 80);
        expect(usage.completionTokensDetails?.reasoningTokens, 20);
        expect(usage.completionTokensDetails?.acceptedPredictionTokens, 0);
        expect(usage.completionTokensDetails?.rejectedPredictionTokens, 0);
      },
    );

    test(
      'should create a Usage object from a valid json with prompt_tokens_details',
      () {
        final json = {
          "prompt_tokens": 100,
          "completion_tokens": 20,
          "total_tokens": 120,
          "prompt_tokens_details": {"cached_tokens": 50},
        };

        final usage = Usage.fromJson(json);

        expect(usage.promptTokens, 100);
        expect(usage.completionTokens, 20);
        expect(usage.totalTokens, 120);
        expect(usage.promptTokensDetails?.cachedTokens, 50);
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

    test(
      'should serialize completion_tokens_details and reasoning_tokens correctly',
      () {
        final usage = Usage(
          50,
          30,
          80,
          completionTokensDetails: CompletionTokensDetails(
            reasoningTokens: 20,
            acceptedPredictionTokens: 0,
            rejectedPredictionTokens: 0,
          ),
        );

        final json = usage.toJson();

        expect(json['prompt_tokens'], 50);
        expect(json['completion_tokens'], 30);
        expect(json['total_tokens'], 80);
        expect(json['completion_tokens_details']['reasoning_tokens'], 20);
        expect(
          json['completion_tokens_details']['accepted_prediction_tokens'],
          0,
        );
        expect(
          json['completion_tokens_details']['rejected_prediction_tokens'],
          0,
        );
      },
    );

    test(
      'should serialize prompt_tokens_details and cached_tokens correctly',
      () {
        final usage = Usage(
          100,
          20,
          120,
          promptTokensDetails: PromptTokensDetails(cachedTokens: 50),
        );

        final json = usage.toJson();

        expect(json['prompt_tokens'], 100);
        expect(json['completion_tokens'], 20);
        expect(json['total_tokens'], 120);
        expect(json['prompt_tokens_details']['cached_tokens'], 50);
      },
    );
  });
}

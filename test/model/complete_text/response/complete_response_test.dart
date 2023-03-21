import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

void main() {
  test('Constructor should create a CTResponse object with values', () {
    final choices = [Choices('first text', 1, {}, 'first reason')];
    final usage = Usage(1, 2, 3);
    final response = CTResponse(
        'example id', 'example object', 100, 'example model', choices, usage);

    expect(response.id, 'example id');
    expect(response.object, 'example object');
    expect(response.created, 100);
    expect(response.model, 'example model');
    expect(response.choices, isNotEmpty);
    expect(response.choices.first.text, 'first text');
    expect(response.choices.first.index, 1);
    expect(response.choices.first.logprobs, {});
    expect(response.choices.first.finishReason, 'first reason');
    expect(response.usage.promptTokens, 1);
    expect(response.usage.completionTokens, 2);
    expect(response.usage.totalTokens, 3);
  });

  test(
      'fromJson should return a CTResponse object with values when given a valid JSON',
      () {
    final json = {
      'id': 'example id',
      'object': 'example object',
      'created': 1,
      'model': 'example model',
      'choices': [
        {
          'text': 'example text',
          'index': 1,
          'logprobs': {},
          'finish_reason': 'example reason'
        }
      ],
      'usage': {'prompt_tokens': 1, 'completion_tokens': 0, 'total_tokens': 1}
    };

    final result = CTResponse.fromJson(json);

    expect(result.id, 'example id');
    expect(result.object, 'example object');
    expect(result.created, 1);
    expect(result.model, 'example model');
    expect(result.choices, isNotEmpty);
    expect(result.choices.first.text, 'example text');
    expect(result.choices.first.index, 1);
    expect(result.choices.first.logprobs, {});
    expect(result.choices.first.finishReason, 'example reason');
    expect(result.usage.promptTokens, 1);
    expect(result.usage.completionTokens, 0);
    expect(result.usage.totalTokens, 1);
  });

  test('fromJson should throw a TypeError when given an invalid JSON', () {
    final json = {'id': 'example id'};
    expect(() => CTResponse.fromJson(json), throwsA(TypeMatcher<TypeError>()));
  });

  test('toJson should return a JSON map with values', () {
    final choices = [Choices('example text', 1, {}, 'example reason')];
    final usage = Usage(0, 1, 2);
    final response = CTResponse(
        'example id', 'example object', 1, 'example model', choices, usage);

    final result = response.toJson();

    expect(result['id'], 'example id');
    expect(result['object'], 'example object');
    expect(result['created'], 1);
    expect(result['model'], 'example model');
    expect(result['choices'], isNotEmpty);
    expect(result['choices'][0], isNotNull);
    expect(result['choices'][0].text, 'example text');
    expect(result['choices'][0].index, 1);
    expect(result['choices'][0].logprobs, {});
    expect(result['choices'][0].finishReason, 'example reason');
    expect(result['usage'].promptTokens, 0);
    expect(result['usage'].completionTokens, 1);
    expect(result['usage'].totalTokens, 2);
  });
}

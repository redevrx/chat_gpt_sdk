import 'package:flutter_test/flutter_test.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';

void main() {
  test('Constructor variables should be equal to member variables', () {
    final text = 'example text';
    final index = 1;
    final logprobs = {};
    final finishReason = 'example reason';

    final result = Choices(text, index, logprobs, finishReason);
    expect(result.text, text);
    expect(result.index, index);
    expect(result.logprobs, logprobs);
    expect(result.finishReason, finishReason);
  });

  test(
      'fromJson should return a Choices object with values when given a valid JSON',
      () {
    final json = {
      'text': 'example text',
      'index': 1,
      'logprobs': {},
      'finish_reason': 'example reason'
    };

    final result = Choices.fromJson(json);

    expect(result.text, 'example text');
    expect(result.index, 1);
    expect(result.logprobs, {});
    expect(result.finishReason, 'example reason');
  });

  test(
      'fromJson should return a Choices object with null for finishReason when given a JSON without it',
      () {
    final json = {
      'text': 'example text',
      'index': 1,
      'logprobs': {},
    };

    final result = Choices.fromJson(json);
    expect(result.finishReason, isNull);
  });

  test('fromJson should throw an exception when given an invalid JSON', () {
    final json = {'text': 'example text'};
    expect(() => Choices.fromJson(json), throwsA(TypeMatcher<TypeError>()));
  });

  test('choicesToJson should return a JSON map with values', () {
    final choices = Choices('example text', 1, {}, 'example reason');

    final result = choices.toJson();

    expect(result['text'], 'example text');
    expect(result['index'], 1);
    expect(result['logprobs'], {});
    expect(result['finish_reason'], 'example reason');
  });
}

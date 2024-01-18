import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('CompleteText', () {
    test('fromJson creates a valid instance', () {
      final json = {
        'prompt': 'Hello world!',
        'model': Gpt3TurboInstruct().model,
        'temperature': 0.8,
        'max_tokens': 150,
        'top_p': 0.9,
        'frequency_penalty': 0.5,
        'presence_penalty': 0.5,
        'stop': [' Human:', ' AI:'],
      };

      final completeText = CompleteText.fromJson(json);

      expect(completeText.prompt, 'Hello world!');
      expect(completeText.model.model, Gpt3TurboInstruct().model);
      expect(completeText.temperature, 0.8);
      expect(completeText.maxTokens, 150);
      expect(completeText.topP, 0.9);
      expect(completeText.frequencyPenalty, 0.5);
      expect(completeText.presencePenalty, 0.5);
      expect(completeText.stop, [' Human:', ' AI:']);
      expect(completeText.toJson()['prompt'], 'Hello world!');
    });

    test('toJson returns a valid Map', () {
      final completeText = CompleteText(
        prompt: 'Hello world!',
        model: Gpt3TurboInstruct(),
        temperature: 0.8,
        maxTokens: 150,
        topP: 0.9,
        frequencyPenalty: 0.5,
        presencePenalty: 0.5,
        stop: [' Human:', ' AI:'],
      );

      final json = completeText.toJson();

      expect(json['prompt'], 'Hello world!');
      expect(json['model'], Gpt3TurboInstruct().model);
      expect(json['temperature'], 0.8);
      expect(json['max_tokens'], 150);
      expect(json['top_p'], 0.9);
      expect(json['frequency_penalty'], 0.5);
      expect(json['presence_penalty'], 0.5);
      expect(json['stop'], [' Human:', ' AI:']);
      expect(completeText.toJson()['prompt'], 'Hello world!');
    });

    test('constructor creates a valid instance with default values', () {
      final completeText =
          CompleteText(prompt: 'Hello world!', model: Gpt3TurboInstruct());

      expect(completeText.prompt, 'Hello world!');
      expect(completeText.model.model, Gpt3TurboInstruct().model);
      expect(completeText.temperature, 0.3);
      expect(completeText.maxTokens, 100);
      expect(completeText.topP, 1.0);
      expect(completeText.frequencyPenalty, 0.0);
      expect(completeText.presencePenalty, 0.0);
      expect(completeText.stop, isNull);
    });
  });
}

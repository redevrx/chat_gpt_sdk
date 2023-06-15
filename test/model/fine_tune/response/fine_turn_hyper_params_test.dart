import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('fine tune hyper params test', () {
    test('fine tune hyper params test from json', () {
      final json = {
        "batch_size": 12,
        'learning_rate_multiplier': .5,
        'n_epochs': 1,
        'prompt_loss_weight': .5,
      };

      final fineTube = FineTuneHyperParams.fromJson(json);

      expect(fineTube.batchSize, 12);
      expect(fineTube.learningRateMultiplier, .5);
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('fine tune model test', () {
    test('fine tune model test from json', () {
      final json = {
        "id": 'id',
        'model': 'model',
        'created_at': 123123,
        'events': [
          {
            "level": 'level',
            'message': 'message',
            'created_at': 12312,
          },
        ],
        'fine_tuned_model': 'fine_tuned_model',
        'hyperparams': {
          "batch_size": 12,
          'learning_rate_multiplier': .5,
          'n_epochs': 1,
          'prompt_loss_weight': .5,
        },
        'organization_id': 'organization_id',
        'result_files': ['s', 'p'],
        'status': 'status',
        'validation_files': ['s', 'p'],
        'training_files': [
          {
            "id": 'id',
            'bytes': 213,
            'filename': 'filename',
            'purpose': 'purpose',
          },
        ],
      };

      final model = FineTuneModel.fromJson(json);

      expect(model.id, 'id');
      expect(model.trainingFiles.last?.bytes, 213);
      expect(model.hyperparams?.batchSize, 12);
    });
  });
}

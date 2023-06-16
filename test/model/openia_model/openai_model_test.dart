import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/model_data.dart';
import 'package:test/test.dart';

void main() {
  group('openai model test', () {
    test('openai model test from data', () {
      final json = {
        'data': [
          {
            'id': 'id',
            'object': 'object',
            'owned_by': 'owned_by',
            'permission': [
              {
                'id': 'id',
                'object': 'object',
                'created': 1,
                'allow_create_engine': true,
                'allow_sampling': true,
                'allow_logprobs': true,
                'allow_search_indices': true,
                'allow_view': true,
                'allow_fine_tuning': true,
                'organization': 'organization',
                'is_blocking': true,
              },
            ],
          },
        ],
        'object': 'object',
      };

      final model = OpenAiModel.fromJson(json);

      expect(model.object, 'object');
    });

    test('openai model test to data', () {
      final json = OpenAiModel(
        [
          ModelData.fromJson({
            'id': 'id',
            'object': 'object',
            'owned_by': 'owned_by',
            'permission': [
              {
                'id': 'id',
                'object': 'object',
                'created': 1,
                'allow_create_engine': true,
                'allow_sampling': true,
                'allow_logprobs': true,
                'allow_search_indices': true,
                'allow_view': true,
                'allow_fine_tuning': true,
                'organization': 'organization',
                'is_blocking': true,
              },
            ],
          }),
        ],
        'object',
      ).toJson();

      expect(json['object'], 'object');
    });
  });
}

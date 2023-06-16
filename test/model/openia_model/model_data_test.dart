import 'package:chat_gpt_sdk/src/model/openai_model/model_data.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';
import 'package:test/test.dart';

void main() {
  group('model data test', () {
    test('model data test from json', () {
      final json = {
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
      };

      final model = ModelData.fromJson(json);

      expect(model.object, 'object');
      expect(model.id, 'id');
    });
    test('model data test to json', () {
      final json = ModelData("id", 'object', 'ownerBy', [
        Permission.fromJson({
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
        }),
      ]).toJson();

      expect(json['object'], 'object');
      expect(json['id'], 'id');
    });
  });
}

import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';
import 'package:test/test.dart';

void main() {
  group('permission test', () {
    test('permission test from json', () {
      final json = {
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
      };

      final permission = Permission.fromJson(json);

      expect(permission.object, 'object');
      expect(permission.created, 1);
    });

    test('permission test to json', () {
      final json = Permission(
        "id",
        'object',
        1,
        true,
        true,
        true,
        true,
        true,
        true,
        'organization',
        true,
      ).toJson();

      expect(json['object'], 'object');
      expect(json['created'], 1);
    });
  });
}

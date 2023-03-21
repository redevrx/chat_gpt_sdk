import 'package:chat_gpt_sdk/src/model/openai_model/openai_model_data.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test fromJson method', () {
    final permission = Permission(
      'test_permission_id',
      'test_permission_object',
      123,
      true,
      false,
      true,
      false,
      true,
      false,
      'test_organization',
      'test_group',
      null,
    );

    final modelData = ModelData(
      'test_id',
      'test_object',
      'test_owner',
      [permission],
    );

    expect(modelData.id, 'test_id');
    expect(modelData.object, 'test_object');
    expect(modelData.ownerBy, 'test_owner');
    expect(modelData.permission!.length, 1);
    expect(modelData.permission![0].id, 'test_permission_id');
    expect(modelData.permission![0].object, 'test_permission_object');
    expect(modelData.permission![0].created, 123);
    expect(modelData.permission![0].allowCreate_engine, true);
    expect(modelData.permission![0].allowSampling, false);
    expect(modelData.permission![0].allowLogprobs, true);
    expect(modelData.permission![0].allowSearchIndices, false);
    expect(modelData.permission![0].allowView, true);
    expect(modelData.permission![0].allowFineTuning, false);
    expect(modelData.permission![0].organization, 'test_organization');
    expect(modelData.permission![0].group, 'test_group');
    expect(modelData.permission![0].isBlocking, null);
  });

  test('Test fromJson method with all fields', () {
    final json = {
      'id': 'test_id',
      'object': 'test_object',
      'owned_by': 'test_owner',
      'permission': [
        {
          'id': 'test_permission_id',
          'object': 'test_permission_object',
          'created': 1234567890,
          'allow_create_engine': true,
          'allow_sampling': false,
          'allow_logprobs': true,
          'allow_search_indices': true,
          'allow_view': false,
          'allow_fine_tuning': true,
          'organization': 'test_org',
          'group': null,
          'is_blocking': false,
        }
      ]
    };

    final testModelData = ModelData.fromJson(json);

    expect(testModelData.id, 'test_id');
    expect(testModelData.object, 'test_object');
    expect(testModelData.ownerBy, 'test_owner');

    expect(testModelData.permission!.length, 1);
    expect(testModelData.permission![0].id, 'test_permission_id');
    expect(testModelData.permission![0].object, 'test_permission_object');
    expect(testModelData.permission![0].created, 1234567890);
    expect(testModelData.permission![0].allowCreate_engine, true);
    expect(testModelData.permission![0].allowSampling, false);
    expect(testModelData.permission![0].allowLogprobs, true);
    expect(testModelData.permission![0].allowSearchIndices, true);
    expect(testModelData.permission![0].allowView, false);
    expect(testModelData.permission![0].allowFineTuning, true);
    expect(testModelData.permission![0].organization, 'test_org');
    expect(testModelData.permission![0].group, null);
    expect(testModelData.permission![0].isBlocking, false);
  });

  test('Test fromJson method with null permission field', () {
    final json = {
      'id': 'test_id',
      'object': 'test_object',
      'owned_by': 'test_owner',
      'permission': null,
    };

    final testModelData = ModelData.fromJson(json);

    expect(testModelData.id, 'test_id');
    expect(testModelData.object, 'test_object');
    expect(testModelData.ownerBy, 'test_owner');
    expect(testModelData.permission, null);
  });

  group('toJson method test', () {
    test('Test toJson method with null permission', () {
      final testModelData =
          ModelData('test_id', 'test_object', 'test_owner', null);
      final expectedJson = <String, dynamic>{
        'id': 'test_id',
        'object': 'test_object',
        'owned_by': 'test_owner',
        'permission': null,
      };
      expect(testModelData.toJson(), expectedJson);
    });

    test('Test toJson method with non-empty permission', () {
      final permission1 = Permission(
        'test_permission_id_1',
        'test_permission_object_1',
        1234567890,
        true,
        false,
        true,
        true,
        false,
        true,
        'test_org_1',
        null,
        false,
      );
      final permission2 = Permission(
        'test_permission_id_2',
        'test_permission_object_2',
        1234567891,
        true,
        true,
        false,
        true,
        false,
        false,
        'test_org_2',
        null,
        false,
      );
      final testModelData = ModelData(
          'test_id', 'test_object', 'test_owner', [permission1, permission2]);
      final expectedJson = <String, dynamic>{
        'id': 'test_id',
        'object': 'test_object',
        'owned_by': 'test_owner',
        'permission': [
          {
            'id': 'test_permission_id_1',
            'object': 'test_permission_object_1',
            'created': 1234567890,
            'allow_create_engine': true,
            'allow_sampling': false,
            'allow_logprobs': true,
            'allow_search_indices': true,
            'allow_view': false,
            'allow_fine_tuning': true,
            'organization': 'test_org_1',
            'group': null,
            'is_blocking': false,
          },
          {
            'id': 'test_permission_id_2',
            'object': 'test_permission_object_2',
            'created': 1234567891,
            'allow_create_engine': true,
            'allow_sampling': true,
            'allow_logprobs': false,
            'allow_search_indices': true,
            'allow_view': false,
            'allow_fine_tuning': false,
            'organization': 'test_org_2',
            'group': null,
            'is_blocking': false,
          },
        ],
      };
      expect(testModelData.toJson(), expectedJson);
    });
  });
}

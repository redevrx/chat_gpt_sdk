import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/openai_model_data.dart';

void main() {
  test('Test fromJson method with empty data', () {
    final json = {
      'data': [],
      'object': 'test_object',
    };

    final testAiModel = AiModel.fromJson(json);

    expect(testAiModel.data, []);
    expect(testAiModel.object, 'test_object');
  });

  test('Test fromJson method with non-empty data', () {
    final json = {
      'data': [
        {
          'id': 'test_id_1',
          'object': 'test_object_1',
          'owned_by': 'test_owner_1',
          'permission': null,
        },
        {
          'id': 'test_id_2',
          'object': 'test_object_2',
          'owned_by': 'test_owner_2',
          'permission': [
            {
              'id': 'test_permission_id_2_1',
              'object': 'test_permission_object_2_1',
              'created': 1234567890,
              'allow_create_engine': true,
              'allow_sampling': false,
              'allow_logprobs': true,
              'allow_search_indices': true,
              'allow_view': false,
              'allow_fine_tuning': true,
              'organization': 'test_org_2_1',
              'group': null,
              'is_blocking': false,
            },
            {
              'id': 'test_permission_id_2_2',
              'object': 'test_permission_object_2_2',
              'created': 1234567891,
              'allow_create_engine': true,
              'allow_sampling': true,
              'allow_logprobs': false,
              'allow_search_indices': true,
              'allow_view': false,
              'allow_fine_tuning': false,
              'organization': 'test_org_2_2',
              'group': null,
              'is_blocking': false,
            },
          ],
        },
      ],
      'object': 'test_object',
    };

    final testAiModel = AiModel.fromJson(json);

    expect(testAiModel.object, 'test_object');
    expect(testAiModel.data.length, 2);

    final expectedModelData1 = ModelData(
      'test_id_1',
      'test_object_1',
      'test_owner_1',
      null,
    );
    expect(testAiModel.data[0].id, expectedModelData1.id);
    expect(testAiModel.data[0].object, expectedModelData1.object);
    expect(testAiModel.data[0].ownerBy, expectedModelData1.ownerBy);
    expect(testAiModel.data[0].permission, expectedModelData1.permission);

    final expectedPermission1 = Permission(
      'test_permission_id_2_1',
      'test_permission_object_2_1',
      1234567890,
      true,
      false,
      true,
      true,
      false,
      true,
      'test_org_2_1',
      null,
      false,
    );
    final expectedPermission2 = Permission(
      'test_permission_id_2_2',
      'test_permission_object_2_2',
      1234567891,
      true,
      true,
      false,
      true,
      false,
      false,
      'test_org_2_2',
      null,
      false,
    );
    expect(testAiModel.data[1].id, 'test_id_2');
    expect(testAiModel.data[1].object, 'test_object_2');
    expect(testAiModel.data[1].ownerBy, 'test_owner_2');
    expect(testAiModel.data[1].permission!.length, 2);
    expect(testAiModel.data[1].permission![0].id, expectedPermission1.id);
    expect(
        testAiModel.data[1].permission![0].object, expectedPermission1.object);
    expect(testAiModel.data[1].permission![0].created,
        expectedPermission1.created);
    expect(testAiModel.data[1].permission![0].allowCreate_engine,
        expectedPermission1.allowCreate_engine);
    expect(testAiModel.data[1].permission![0].allowSampling,
        expectedPermission1.allowSampling);
    expect(testAiModel.data[1].permission![0].allowLogprobs,
        expectedPermission1.allowLogprobs);
    expect(testAiModel.data[1].permission![0].allowSearchIndices,
        expectedPermission1.allowSearchIndices);
    expect(testAiModel.data[1].permission![0].allowView,
        expectedPermission1.allowView);
    expect(testAiModel.data[1].permission![0].allowFineTuning,
        expectedPermission1.allowFineTuning);
    expect(testAiModel.data[1].permission![0].organization,
        expectedPermission1.organization);
    expect(testAiModel.data[1].permission![0].group, expectedPermission1.group);
    expect(testAiModel.data[1].permission![0].isBlocking,
        expectedPermission1.isBlocking);

    expect(testAiModel.data[1].permission![1].id, expectedPermission2.id);
    expect(
        testAiModel.data[1].permission![1].object, expectedPermission2.object);
    expect(testAiModel.data[1].permission![1].created,
        expectedPermission2.created);
    expect(testAiModel.data[1].permission![1].allowCreate_engine,
        expectedPermission2.allowCreate_engine);
    expect(testAiModel.data[1].permission![1].allowSampling,
        expectedPermission2.allowSampling);
    expect(testAiModel.data[1].permission![1].allowLogprobs,
        expectedPermission2.allowLogprobs);
    expect(testAiModel.data[1].permission![1].allowSearchIndices,
        expectedPermission2.allowSearchIndices);
    expect(testAiModel.data[1].permission![1].allowView,
        expectedPermission2.allowView);
    expect(testAiModel.data[1].permission![1].allowFineTuning,
        expectedPermission2.allowFineTuning);
    expect(testAiModel.data[1].permission![1].organization,
        expectedPermission2.organization);
    expect(testAiModel.data[1].permission![1].group, expectedPermission2.group);
    expect(testAiModel.data[1].permission![1].isBlocking,
        expectedPermission2.isBlocking);
  });

  test('Test constructor with non-empty data', () {
    final modelData1 = ModelData(
      'test_id_1',
      'test_object_1',
      'test_owner_1',
      null,
    );

    final permission1 = Permission(
      'test_permission_id_2_1',
      'test_permission_object_2_1',
      1234567890,
      true,
      false,
      true,
      true,
      false,
      true,
      'test_org_2_1',
      null,
      false,
    );
    final permission2 = Permission(
      'test_permission_id_2_2',
      'test_permission_object_2_2',
      1234567891,
      true,
      true,
      false,
      true,
      false,
      false,
      'test_org_2_2',
      null,
      false,
    );

    final aiModel = AiModel(
      [
        modelData1,
        ModelData('test_id_2', 'test_object_2', 'test_owner_2',
            [permission1, permission2])
      ],
      'test_object',
    );

    expect(aiModel.object, 'test_object');
    expect(aiModel.data.length, 2);

    expect(aiModel.data[0].id, 'test_id_1');
    expect(aiModel.data[0].object, 'test_object_1');
    expect(aiModel.data[0].ownerBy, 'test_owner_1');
    expect(aiModel.data[0].permission, null);

    expect(aiModel.data[1].id, 'test_id_2');
    expect(aiModel.data[1].object, 'test_object_2');
    expect(aiModel.data[1].ownerBy, 'test_owner_2');
    expect(aiModel.data[1].permission!.length, 2);
    expect(aiModel.data[1].permission![0].id, permission1.id);
    expect(aiModel.data[1].permission![0].object, permission1.object);
    expect(aiModel.data[1].permission![0].created, permission1.created);
    expect(aiModel.data[1].permission![0].allowCreate_engine,
        permission1.allowCreate_engine);
    expect(aiModel.data[1].permission![0].allowSampling,
        permission1.allowSampling);
    expect(aiModel.data[1].permission![0].allowLogprobs,
        permission1.allowLogprobs);
    expect(aiModel.data[1].permission![0].allowSearchIndices,
        permission1.allowSearchIndices);
    expect(aiModel.data[1].permission![0].allowView, permission1.allowView);
    expect(aiModel.data[1].permission![0].allowFineTuning,
        permission1.allowFineTuning);
    expect(
        aiModel.data[1].permission![0].organization, permission1.organization);
    expect(aiModel.data[1].permission![0].group, permission1.group);
    expect(aiModel.data[1].permission![0].isBlocking, permission1.isBlocking);

    expect(aiModel.data[1].permission![1].id, permission2.id);
    expect(aiModel.data[1].permission![1].object, permission2.object);
    expect(aiModel.data[1].permission![1].created, permission2.created);
    expect(aiModel.data[1].permission![1].allowCreate_engine,
        permission2.allowCreate_engine);
    expect(aiModel.data[1].permission![1].allowSampling,
        permission2.allowSampling);
    expect(aiModel.data[1].permission![1].allowLogprobs,
        permission2.allowLogprobs);
    expect(aiModel.data[1].permission![1].allowSearchIndices,
        permission2.allowSearchIndices);
    expect(aiModel.data[1].permission![1].allowView, permission2.allowView);
    expect(aiModel.data[1].permission![1].allowFineTuning,
        permission2.allowFineTuning);
    expect(
        aiModel.data[1].permission![1].organization, permission2.organization);
    expect(aiModel.data[1].permission![1].group, permission2.group);
    expect(aiModel.data[1].permission![1].isBlocking, permission2.isBlocking);
  });

  test('toJson returns expected JSON', () {
    final expectedJson = {
      'data': [
        {
          'id': 'test_id_1',
          'object': 'test_object_1',
          'owned_by': 'test_owner_1',
          'permission': null,
        },
        {
          'id': 'test_id_2',
          'object': 'test_object_2',
          'owned_by': 'test_owner_2',
          'permission': [
            {
              'id': 'test_permission_id_2_1',
              'object': 'test_permission_object_2_1',
              'created': 1234567890,
              'allow_create_engine': true,
              'allow_sampling': false,
              'allow_logprobs': true,
              'allow_search_indices': true,
              'allow_view': false,
              'allow_fine_tuning': true,
              'organization': 'test_org_2_1',
              'group': null,
              'is_blocking': false,
            },
            {
              'id': 'test_permission_id_2_2',
              'object': 'test_permission_object_2_2',
              'created': 1234567891,
              'allow_create_engine': true,
              'allow_sampling': true,
              'allow_logprobs': false,
              'allow_search_indices': true,
              'allow_view': false,
              'allow_fine_tuning': false,
              'organization': 'test_org_2_2',
              'group': null,
              'is_blocking': false,
            },
          ],
        },
      ],
      'object': 'test_object',
    };

    final testAiModel = AiModel.fromJson(expectedJson);
    final actualJson = testAiModel.toJson();

    expect(actualJson['object'], expectedJson['object']);
  });

  test('Test AiModel toJson method', () {
    final modelData1 = ModelData(
      'test_id_1',
      'test_object_1',
      'test_owner_1',
      null,
    );
    final modelData2 = ModelData(
      'test_id_2',
      'test_object_2',
      'test_owner_2',
      [
        Permission(
          'test_permission_id_2_1',
          'test_permission_object_2_1',
          1234567890,
          true,
          false,
          true,
          true,
          false,
          true,
          'test_org_2_1',
          null,
          false,
        ),
        Permission(
          'test_permission_id_2_2',
          'test_permission_object_2_2',
          1234567891,
          true,
          true,
          false,
          true,
          false,
          false,
          'test_org_2_2',
          null,
          false,
        ),
      ],
    );
    final aiModel = AiModel([modelData1, modelData2], 'test_object');

    final expectedJson = {
      'data': [
        {
          'id': 'test_id_1',
          'object': 'test_object_1',
          'owned_by': 'test_owner_1',
          'permission': null,
        },
        {
          'id': 'test_id_2',
          'object': 'test_object_2',
          'owned_by': 'test_owner_2',
          'permission': [
            {
              'id': 'test_permission_id_2_1',
              'object': 'test_permission_object_2_1',
              'created': 1234567890,
              'allow_create_engine': true,
              'allow_sampling': false,
              'allow_logprobs': true,
              'allow_search_indices': true,
              'allow_view': false,
              'allow_fine_tuning': true,
              'organization': 'test_org_2_1',
              'group': null,
              'is_blocking': false,
            },
            {
              'id': 'test_permission_id_2_2',
              'object': 'test_permission_object_2_2',
              'created': 1234567891,
              'allow_create_engine': true,
              'allow_sampling': true,
              'allow_logprobs': false,
              'allow_search_indices': true,
              'allow_view': false,
              'allow_fine_tuning': false,
              'organization': 'test_org_2_2',
              'group': null,
              'is_blocking': false,
            },
          ],
        },
      ],
      'object': 'test_object',
    };

    expect(aiModel.toJson(), expectedJson);
  });
}

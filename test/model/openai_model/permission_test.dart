import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test constructor with valid input', () {
    final expectedId = 'test_id';
    final expectedObject = 'test_object';
    final expectedCreated = 12345;
    final expectedAllowCreateEngine = true;
    final expectedAllowSampling = false;
    final expectedAllowLogprobs = true;
    final expectedAllowSearchIndices = false;
    final expectedAllowView = true;
    final expectedAllowFineTuning = false;
    final expectedOrganization = 'test_org';
    final expectedGroup = 'test_group';
    final expectedIsBlocking = true;

    final testPermission = Permission(
      expectedId,
      expectedObject,
      expectedCreated,
      expectedAllowCreateEngine,
      expectedAllowSampling,
      expectedAllowLogprobs,
      expectedAllowSearchIndices,
      expectedAllowView,
      expectedAllowFineTuning,
      expectedOrganization,
      expectedGroup,
      expectedIsBlocking,
    );

    expect(testPermission.id, expectedId);
    expect(testPermission.object, expectedObject);
    expect(testPermission.created, expectedCreated);
    expect(testPermission.allowCreate_engine, expectedAllowCreateEngine);
    expect(testPermission.allowSampling, expectedAllowSampling);
    expect(testPermission.allowLogprobs, expectedAllowLogprobs);
    expect(testPermission.allowSearchIndices, expectedAllowSearchIndices);
    expect(testPermission.allowView, expectedAllowView);
    expect(testPermission.allowFineTuning, expectedAllowFineTuning);
    expect(testPermission.organization, expectedOrganization);
    expect(testPermission.group, expectedGroup);
    expect(testPermission.isBlocking, expectedIsBlocking);
  });

  test('Test fromJson method', () {
    final expectedId = 'test_id';
    final expectedObject = 'test_object';
    final expectedCreated = 12345;
    final expectedAllowCreateEngine = true;
    final expectedAllowSampling = false;
    final expectedAllowLogprobs = true;
    final expectedAllowSearchIndices = false;
    final expectedAllowView = true;
    final expectedAllowFineTuning = false;
    final expectedOrganization = 'test_org';
    final expectedGroup = 'test_group';
    final expectedIsBlocking = true;

    final json = {
      'id': expectedId,
      'object': expectedObject,
      'created': expectedCreated,
      'allow_create_engine': expectedAllowCreateEngine,
      'allow_sampling': expectedAllowSampling,
      'allow_logprobs': expectedAllowLogprobs,
      'allow_search_indices': expectedAllowSearchIndices,
      'allow_view': expectedAllowView,
      'allow_fine_tuning': expectedAllowFineTuning,
      'organization': expectedOrganization,
      'group': expectedGroup,
      'is_blocking': expectedIsBlocking,
    };

    final testPermission = Permission.fromJson(json);

    expect(testPermission.id, expectedId);
    expect(testPermission.object, expectedObject);
    expect(testPermission.created, expectedCreated);
    expect(testPermission.allowCreate_engine, expectedAllowCreateEngine);
    expect(testPermission.allowSampling, expectedAllowSampling);
    expect(testPermission.allowLogprobs, expectedAllowLogprobs);
    expect(testPermission.allowSearchIndices, expectedAllowSearchIndices);
    expect(testPermission.allowView, expectedAllowView);
    expect(testPermission.allowFineTuning, expectedAllowFineTuning);
    expect(testPermission.organization, expectedOrganization);
    expect(testPermission.group, expectedGroup);
    expect(testPermission.isBlocking, expectedIsBlocking);
  });

  test('Test Permission toJson method', () {
    final permission = Permission(
      'test_permission_id',
      'test_permission_object',
      1234567890,
      true,
      false,
      true,
      true,
      false,
      true,
      'test_org',
      null,
      false,
    );

    final expectedJson = <String, dynamic>{
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
    };

    final json = permission.toJson();

    expect(json, equals(expectedJson));
  });
}

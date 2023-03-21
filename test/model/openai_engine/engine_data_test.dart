import 'package:chat_gpt_sdk/src/model/openai_engine/engine_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test engineDataToJson method', () {
    final testData = EngineData('test_id', 'test_object', 'test_owner', true);

    final expectedJson = <String, dynamic>{
      'id': 'test_id',
      'object': 'test_object',
      'owner': 'test_owner',
      'ready': true,
    };

    final actualJson = testData.engineDataToJson(testData);
    expect(actualJson, expectedJson);
  });

  test('Test fromJson method with valid input', () {
    final inputJson = <String, dynamic>{
      'id': 'test_id',
      'object': 'test_object',
      'owner': 'test_owner',
      'ready': true,
    };

    final expectedData =
        EngineData('test_id', 'test_object', 'test_owner', true);

    final actualData = EngineData.fromJson(inputJson);
    expect(actualData.id, expectedData.id);
    expect(actualData.object, expectedData.object);
    expect(actualData.owner, expectedData.owner);
    expect(actualData.ready, expectedData.ready);
  });

  test('Test constructor with valid input', () {
    final expectedId = 'test_id';
    final expectedObject = 'test_object';
    final expectedOwner = 'test_owner';
    final expectedReady = true;

    final testData =
        EngineData(expectedId, expectedObject, expectedOwner, expectedReady);

    expect(testData.id, expectedId);
    expect(testData.object, expectedObject);
    expect(testData.owner, expectedOwner);
    expect(testData.ready, expectedReady);
  });

  test('Test toJson method', () {
    final expectedJson = {
      'id': 'test_id',
      'object': 'test_object',
      'owner': 'test_owner',
      'ready': true,
    };

    final testEngineData = EngineData(
      'test_id',
      'test_object',
      'test_owner',
      true,
    );

    final json = testEngineData.toJson();

    expect(json['id'], expectedJson['id']);
    expect(json['object'], expectedJson['object']);
    expect(json['owner'], expectedJson['owner']);
    expect(json['ready'], expectedJson['ready']);
  });
}

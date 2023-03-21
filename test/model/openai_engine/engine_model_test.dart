import 'package:flutter_test/flutter_test.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/openai_engine/engine_data.dart';

void main() {
  test('Test constructor with valid input', () {
    final expectedData = [
      EngineData('id_1', 'object_1', 'owner_1', true),
      EngineData('id_2', 'object_2', 'owner_2', false),
    ];
    final expectedObject = 'test_object';

    final testModel = EngineModel(expectedData, expectedObject);

    expect(testModel.data, expectedData);
    expect(testModel.object, expectedObject);
  });

  test('Test fromJson method', () {
    final expectedData = [
      EngineData('id_1', 'object_1', 'owner_1', true),
      EngineData('id_2', 'object_2', 'owner_2', false),
    ];
    final expectedObject = 'test_object';

    final json = {
      'data': [
        {'id': 'id_1', 'object': 'object_1', 'owner': 'owner_1', 'ready': true},
        {
          'id': 'id_2',
          'object': 'object_2',
          'owner': 'owner_2',
          'ready': false
        },
      ],
      'object': 'test_object'
    };

    final testModel = EngineModel.fromJson(json);

    expect(testModel.data.length, expectedData.length);
    expect(testModel.data[0].id, expectedData[0].id);
    expect(testModel.data[0].object, expectedData[0].object);
    expect(testModel.data[0].owner, expectedData[0].owner);
    expect(testModel.data[0].ready, expectedData[0].ready);
    expect(testModel.data[1].id, expectedData[1].id);
    expect(testModel.data[1].object, expectedData[1].object);
    expect(testModel.data[1].owner, expectedData[1].owner);
    expect(testModel.data[1].ready, expectedData[1].ready);
    expect(testModel.object, expectedObject);
  });

  test('Test toJson method', () {
    final engineData1 =
        EngineData('engine_id_1', 'engine_object_1', 'engine_owner_1', true);
    final engineData2 =
        EngineData('engine_id_2', 'engine_object_2', 'engine_owner_2', false);
    final engineModel =
        EngineModel([engineData1, engineData2], 'engine_object');

    final expectedJson = {
      'data': [
        {
          'id': 'engine_id_1',
          'object': 'engine_object_1',
          'owner': 'engine_owner_1',
          'ready': true,
        },
        {
          'id': 'engine_id_2',
          'object': 'engine_object_2',
          'owner': 'engine_owner_2',
          'ready': false,
        },
      ],
      'object': 'engine_object',
    };

    final engineModelJson = engineModel.toJson();
    expect(engineModelJson['object'], expectedJson['object']);

    final data = expectedJson['data'] as List<Map<String, dynamic>>;
    expect(engineModelJson['data'].length, data.length);
    expect(engineModelJson['data'][0].id, data[0]['id']);
    expect(engineModelJson['data'][0].object, data[0]['object']);
    expect(engineModelJson['data'][0].owner, data[0]['owner']);
    expect(engineModelJson['data'][0].ready, data[0]['ready']);
    expect(engineModelJson['data'][1].id, data[1]['id']);
    expect(engineModelJson['data'][1].object, data[1]['object']);
    expect(engineModelJson['data'][1].owner, data[1]['owner']);
    expect(engineModelJson['data'][1].ready, data[1]['ready']);
  });
}

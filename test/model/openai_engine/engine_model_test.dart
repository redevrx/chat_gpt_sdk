import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/openai_engine/engine_data.dart';
import 'package:test/test.dart';

void main() {
  group('engine model test', () {
    test('engine model test from json', () {
      final json = {
        'data': [
          {
            'id': 'id',
            'object': 'object',
            'owner': 'owner',
            'ready': false,
          },
        ],
        'object': 'object',
      };

      final engine = EngineModel.fromJson(json);

      expect(engine.object, 'object');
      expect(engine.data.length, 1);
    });

    test('engine model test to json', () {
      final json = EngineModel(
        [
          EngineData.fromJson({
            'id': 'id',
            'object': 'object',
            'owner': 'owner',
            'ready': false,
          }),
        ],
        'object',
      ).toJson();

      expect(json['object'], 'object');
      expect(json['data'].length, 1);
    });
  });
}

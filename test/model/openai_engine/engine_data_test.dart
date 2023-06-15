import 'package:chat_gpt_sdk/src/model/openai_engine/engine_data.dart';
import 'package:test/test.dart';

void main() {
  group('engine data test', () {
    test('engine data test from json', () {
      final json = {
        'id': 'id',
        'object': 'object',
        'owner': 'owner',
        'ready': false,
      };

      final engine = EngineData.fromJson(json);

      expect(engine.id, 'id');
      expect(engine.object, 'object');
    });

    test('engine data test to json', () {
      final json = EngineData("id", 'object', 'owner', false).toJson();

      expect(json['id'], 'id');
      expect(json['object'], 'object');
    });
  });
}

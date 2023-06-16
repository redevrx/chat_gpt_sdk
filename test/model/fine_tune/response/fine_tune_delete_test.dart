import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('openai Fine Tune delete test', () {
    test('openai  Fine Tune delete test to json', () {
      final json = {
        "id": 'id',
        "object": 'object',
        'deleted': true,
      };
      final tineTune = FineTuneDelete.fromJson(json);

      expect(tineTune.object, 'object');
      expect(tineTune.deleted, true);
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('training file test', () {
    test('training file test from json', () {
      final json = {
        "id": 'id',
        'bytes': 213,
        'filename': 'filename',
        'purpose': 'purpose',
      };

      final training = TrainingFiles.fromJson(json);

      expect(training.bytes, 213);
      expect(training.filename, 'filename');
    });
  });
}

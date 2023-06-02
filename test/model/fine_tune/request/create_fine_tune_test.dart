
import 'package:chat_gpt_sdk/src/model/fine_tune/request/create_fine_tune.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('openai create fine tune test', () {
    test('openai create fine tune test to json', () {
      final fineTune = CreateFineTune(trainingFile: 'trainingFile').toJson();

      expect(fineTune['training_file'], 'trainingFile');
      expect(fineTune['n_epochs'], 4);
    });
  });
}
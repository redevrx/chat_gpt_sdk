import 'package:chat_gpt_sdk/src/model/fine_tune/enum/fine_model.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/request/create_fine_tune.dart';
import 'package:test/test.dart';

void main() {
  group('openai create fine tune test', () {
    test('openai create fine tune test to json', () {
      final fineTune = CreateFineTune(
        trainingFile: 'trainingFile',
        model: Babbage002FineModel(),
      ).toJson();

      expect(fineTune['training_file'], 'trainingFile');
      expect(fineTune['n_epochs'], 4);
    });
  });
}

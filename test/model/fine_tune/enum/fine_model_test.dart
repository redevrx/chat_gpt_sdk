import 'package:chat_gpt_sdk/src/model/fine_tune/enum/fine_model.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:test/test.dart';

void main() {
  group('openai fine tune model test', () {
    test('openai fine tune model test get value babbage', () {
      final babbage = Babbage002FineModel();

      expect(babbage.model, kBabbage002Model);
    });
    test('openai fine tune model test get from value', () {
      final davinci = FineModelFromValue(model: 'model');

      expect(davinci.model, 'model');
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/enum/fine_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('openai fine tune model test', () {
    test('openai fine tune model test get value ada', () {
      const ada = FineModel.ada;

      expect(ada.getName(), kAdaModel);
    });
    test('openai fine tune model test get value babbage', () {
      const babbage = FineModel.babbage;

      expect(babbage.getName(), kBabbageModel);
    });
    test('openai fine tune model test get value curie', () {
      const curie = FineModel.curie;

      expect(curie.getName(), kCurieModel);
    });
    test('openai fine tune model test get value davinci', () {
      const davinci = FineModel.davinci;

      expect(davinci.getName(), kDavinciModel);
    });
  });
}

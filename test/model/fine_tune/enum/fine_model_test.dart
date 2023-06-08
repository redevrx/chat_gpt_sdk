import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/enum/fine_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('openai fine tune model test', () {
    test('openai fine tune model test get value ada', () {
      final ada = AdaFineModel();

      expect(ada.model, kAdaModel);
    });
    test('openai fine tune model test get value babbage', () {
      final babbage = BabbageFineModel();

      expect(babbage.model, kBabbageModel);
    });
    test('openai fine tune model test get value curie', () {
      final curie = CurieFineModel();

      expect(curie.model, kCurieModel);
    });
    test('openai fine tune model test get value davinci', () {
      final davinci = DavinciFineModel();

      expect(davinci.model, kDavinciModel);
    });
    test('openai fine tune model test get from value', () {
      final davinci = FineModelFromValue(model: 'model');

      expect(davinci.model, 'model');
    });
  });
}

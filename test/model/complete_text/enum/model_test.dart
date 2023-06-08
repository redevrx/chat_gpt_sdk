import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('openai completion model test', () {
    test('openai completion model test set value textDavinci3', () {
      final textDavinci3 = TextDavinci3Model();

      expect(textDavinci3.model, kTextDavinci3);
    });
    test('openai completion model test set value textDavinci2', () {
      final textDavinci2 = TextDavinci2Model();

      expect(textDavinci2.model, kTextDavinci2);
    });
    test('openai completion model test set value codeDavinci2', () {
      final codeDavinci2 = CodeDavinci2Model();

      expect(codeDavinci2.model, kCodeDavinci2);
    });
    test('openai completion model test set value textCurie001', () {
      final textCurie001 = TextCurie001Model();

      expect(textCurie001.model, kTextCurie001);
    });
    test('openai completion model test set value textBabbage001', () {
      final textBabbage001 = TextBabbage001Model();

      expect(textBabbage001.model, kTextBabbage001);
    });
    test('openai completion model test set value textAda001', () {
      final textAda001 = TextAda001Model();

      expect(textAda001.model, kTextAda001);
    });
    test('openai completion model test set value davinci', () {
      final davinci = DavinciModel();

      expect(davinci.model, kDavinciModel);
    });
    test('openai completion model test set value curie', () {
      final curie = CurieModel();

      expect(curie.model, kCurieModel);
    });
    test('openai completion model test set value babbage', () {
      final babbage = BabbageModel();

      expect(babbage.model, kBabbageModel);
    });
    test('openai completion model test set value ada', () {
      final ada = AdaModel();

      expect(ada.model, kAdaModel);
    });
    test('openai completion model test set value null', () {
      Model? ada;

      expect(ada, null);
    });
  });
}

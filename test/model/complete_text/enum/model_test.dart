import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('openai completion model test', () {
    test('openai completion model test set value textDavinci3', () {
      const textDavinci3 = Model.textDavinci3;

      expect(textDavinci3.getName(), kTextDavinci3);
    });
    test('openai completion model test set value textDavinci2', () {
      const textDavinci2 = Model.textDavinci2;

      expect(textDavinci2.getName(), kTextDavinci2);
    });
    test('openai completion model test set value codeDavinci2', () {
      const codeDavinci2 = Model.codeDavinci2;

      expect(codeDavinci2.getName(), kCodeDavinci2);
    });
    test('openai completion model test set value textCurie001', () {
      const textCurie001 = Model.textCurie001;

      expect(textCurie001.getName(), kCodeDavinci2);
    });
    test('openai completion model test set value textBabbage001', () {
      const textBabbage001 = Model.textBabbage001;

      expect(textBabbage001.getName(), kTextBabbage001);
    });
    test('openai completion model test set value textAda001', () {
      const textAda001 = Model.textAda001;

      expect(textAda001.getName(), kTextAda001);
    });
    test('openai completion model test set value davinci', () {
      const davinci = Model.davinci;

      expect(davinci.getName(), kDavinciModel);
    });
    test('openai completion model test set value curie', () {
      const curie = Model.curie;

      expect(curie.getName(), kCurieModel);
    });
    test('openai completion model test set value babbage', () {
      const babbage = Model.babbage;

      expect(babbage.getName(), kBabbageModel);
    });
    test('openai completion model test set value ada', () {
      const ada = Model.ada;

      expect(ada.getName(), kAdaModel);
    });
    test('openai completion model test set value null', () {
      Model? ada;

      expect(ada, null);
    });
  });
}

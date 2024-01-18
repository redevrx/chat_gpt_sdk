import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('openai completion model test', () {
    test('openai completion model test set value Gpt3.5 Turbo Instruct', () {
      final gpt3 = Gpt3TurboInstruct();

      expect(gpt3.model, kGpt3TurboInstruct);
    });
    test('openai completion model test set value davinci 002', () {
      final davinci = Davinci002Model();

      expect(davinci.model, kDavinci002Model);
    });
    test('openai completion model test set value Babbage002', () {
      final babbage002 = Babbage002Model();

      expect(babbage002.model, kBabbage002Model);
    });
    test('openai completion model test set value null', () {
      Model? ada;

      expect(ada, null);
    });
  });
}

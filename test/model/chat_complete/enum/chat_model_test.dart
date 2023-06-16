import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('chat openai model test', () {
    test('chat openai model test get gpt_4', () {
      final gpt_4 = Gpt4ChatModel();

      expect(gpt_4.model, 'gpt-4');
      expect(gpt_4.model, isA<String>());
    });
    test('chat openai model test get gptTurbo0301', () {
      final gptTurbo0301 = GptTurbo0301ChatModel();

      expect(gptTurbo0301.model, 'gpt-3.5-turbo-0301');
      expect(gptTurbo0301.model, isA<String>());
    });
    test('chat openai model test get gptTurbo', () {
      final gptTurbo = GptTurboChatModel();

      expect(gptTurbo.model, 'gpt-3.5-turbo');
      expect(gptTurbo.model, isA<String>());
    });
    test('chat openai model test get gpt_4_0314', () {
      final gpt_4_0314 = Gpt40314ChatModel();

      expect(gpt_4_0314.model, 'gpt-4-0314');
      expect(gpt_4_0314.model, isA<String>());
    });
    test('chat openai model test get gpt_4_32k', () {
      final gpt_4_32k = Gpt432kChatModel();

      expect(gpt_4_32k.model, 'gpt-4-32k');
      expect(gpt_4_32k.model, isA<String>());
    });
    test('chat openai model test get gpt_4_32k_0314', () {
      final gpt_4_32k_0314 = Gpt432k0314ChatModel();

      expect(gpt_4_32k_0314.model, 'gpt-4-32k-0314');
      expect(gpt_4_32k_0314.model, isA<String>());
    });
    test('chat openai model test get gpt_4_32k_0314', () {
      ChatModel? gpt_4_32k_0314;

      expect(gpt_4_32k_0314, null);
    });

    test('chat openai model test get gpt40631', () {
      final gpt40631 = Gpt40631ChatModel();

      expect(gpt40631.model, kChatGpt40631);
      expect(gpt40631.model, isA<String>());
    });

    test('chat openai model test get value', () {
      final gpt40631 = ChatModelFromValue(model: "model");

      expect(gpt40631.model, 'model');
      expect(gpt40631.model, isA<String>());
    });
  });
}

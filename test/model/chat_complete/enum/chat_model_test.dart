import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chat openai model test', () {
    test('chat openai model test get gpt_4', () {
      const gpt_4 = ChatModel.gpt_4;

      expect(gpt_4.name, 'gpt-4');
      expect(gpt_4.name, isA<String>());
    });
    test('chat openai model test get gptTurbo0301', () {
      const gptTurbo0301 = ChatModel.gptTurbo0301;

      expect(gptTurbo0301.name, 'gpt-3.5-turbo-0301');
      expect(gptTurbo0301.name, isA<String>());
    });
    test('chat openai model test get gptTurbo', () {
      const gptTurbo = ChatModel.gptTurbo;

      expect(gptTurbo.name, 'gpt-3.5-turbo');
      expect(gptTurbo.name, isA<String>());
    });
    test('chat openai model test get gpt_4_0314', () {
      const gpt_4_0314 = ChatModel.gpt_4_0314;

      expect(gpt_4_0314.name, 'gpt-4-0314');
      expect(gpt_4_0314.name, isA<String>());
    });
    test('chat openai model test get gpt_4_32k', () {
      const gpt_4_32k = ChatModel.gpt_4_32k;

      expect(gpt_4_32k.name, 'gpt-4-32k');
      expect(gpt_4_32k.name, isA<String>());
    });
    test('chat openai model test get gpt_4_32k_0314', () {
      const gpt_4_32k_0314 = ChatModel.gpt_4_32k_0314;

      expect(gpt_4_32k_0314.name, 'gpt-4-32k-0314');
      expect(gpt_4_32k_0314.name, isA<String>());
    });
    test('chat openai model test get gpt_4_32k_0314', () {
      ChatModel? gpt_4_32k_0314;

      expect(gpt_4_32k_0314, null);
    });
  });
}

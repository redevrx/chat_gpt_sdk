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

    test('chat openai model test get o1', () {
      final o1 = O1ChatModel();
      expect(o1.model, 'o1');
      expect(o1.model, isA<String>());
    });

    test('chat openai model test get o1-2024-12-17', () {
      final o1_2024 = O12024ChatModel();
      expect(o1_2024.model, 'o1-2024-12-17');
      expect(o1_2024.model, isA<String>());
    });

    test('chat openai model test get o1-preview', () {
      final o1Preview = O1PreviewChatModel();
      expect(o1Preview.model, 'o1-preview');
      expect(o1Preview.model, isA<String>());
    });

    test('chat openai model test get o1-preview-2024-09-12', () {
      final o1Preview2024 = O1Preview2024ChatModel();
      expect(o1Preview2024.model, 'o1-preview-2024-09-12');
      expect(o1Preview2024.model, isA<String>());
    });

    test('chat openai model test get o1-mini', () {
      final o1Mini = O1MiniChatModel();
      expect(o1Mini.model, 'o1-mini');
      expect(o1Mini.model, isA<String>());
    });

    test('chat openai model test get o1-mini-2024-09-12', () {
      final o1Mini2024 = O1Mini2024ChatModel();
      expect(o1Mini2024.model, 'o1-mini-2024-09-12');
      expect(o1Mini2024.model, isA<String>());
    });

    test('chat openai model test get o3-mini', () {
      final o3Mini = O3MiniChatModel();
      expect(o3Mini.model, 'o3-mini');
      expect(o3Mini.model, isA<String>());
    });

    test('chat openai model test get o3-mini-2025-01-31', () {
      final o3Mini2025 = O3Mini2025ChatModel();
      expect(o3Mini2025.model, 'o3-mini-2025-01-31');
      expect(o3Mini2025.model, isA<String>());
    });
  });
}

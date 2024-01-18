import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/edits/enum/edit_model.dart';
import 'package:test/test.dart';

void main() {
  group('chat openai model test', () {
    test('chat openai model test get gpt4 edit', () {
      final codeEditModel = Gpt4();

      expect(codeEditModel.model, kChatGpt4);
      expect(codeEditModel.model, isA<String>());
    });
    test('chat openai model test get from value', () {
      final custom = EditModelFromValue(model: 'custom-model');

      expect(custom.model, 'custom-model');
      expect(custom.model, isA<String>());
    });
  });
}

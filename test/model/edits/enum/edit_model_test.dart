import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/edits/enum/edit_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chat openai model test', () {
    test('chat openai model test get codeEditModel', () {
      final codeEditModel = CodeEditModel();

      expect(codeEditModel.model, kEditsCoedModel);
      expect(codeEditModel.model, isA<String>());
    });
    test('chat openai model test get textEditModel', () {
      final textEditModel = TextEditModel();

      expect(textEditModel.model, kEditsTextModel);
      expect(textEditModel.model, isA<String>());
    });
    test('chat openai model test get from value', () {
      final custom = EditModelFromValue(model: 'custom-model');

      expect(custom.model, 'custom-model');
      expect(custom.model, isA<String>());
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/edits/enum/edit_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chat openai model test', () {
    test('chat openai model test get codeEditModel', () {
      const codeEditModel = EditModel.codeEditModel;

      expect(codeEditModel.getName(), kEditsCoedModel);
      expect(codeEditModel.getName(), isA<String>());
    });
    test('chat openai model test get textEditModel', () {
      const textEditModel = EditModel.textEditModel;

      expect(textEditModel.getName(), kEditsTextModel);
      expect(textEditModel.getName(), isA<String>());
    });
  });
}

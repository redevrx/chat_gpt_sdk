
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/edits/enum/edit_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('openai test edit request', () {
    test('openai test edit request from json', () {
      final request = EditRequest(model: EditModel.codeEditModel, input: "input", instruction: "instruction");

      expect(request.model.getName(), EditModel.codeEditModel.getName());
      expect(request.input, 'input');
    });

    test('openai test edit request from json', () {
      final mJson = {
        "model":EditModel.codeEditModel.getName(),
        "input":"input",
        "instruction":"instruction",
        "n":1,
        "temperature":1,
        "top_p":1,
      };

      final json = EditRequest(model: EditModel.codeEditModel, input: "input", instruction: "instruction").toJson();

      expect(json,mJson);
      expect(json['input'], 'input');
    });
  });
}
import 'package:chat_gpt_sdk/src/utils/constants.dart';

enum EditModel { textEditModel, codeEditModel }

extension EditModelExtension on EditModel {
  String getName() {
    switch (this) {
      case EditModel.codeEditModel:
        return kEditsCoedModel;
      case EditModel.textEditModel:
        return kEditsTextModel;
      default:
        return '';
    }
  }
}

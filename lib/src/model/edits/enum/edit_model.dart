import 'package:chat_gpt_sdk/src/utils/constants.dart';

sealed class EditModel {
  String model;
  EditModel({required this.model});
}

class TextEditModel extends EditModel {
  TextEditModel() : super(model: kEditsTextModel);
}

class CodeEditModel extends EditModel {
  CodeEditModel() : super(model: kEditsCoedModel);
}

class EditModelFromValue extends EditModel {
  EditModelFromValue({required super.model});
}

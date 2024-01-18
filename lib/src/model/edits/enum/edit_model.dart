import 'package:chat_gpt_sdk/src/utils/constants.dart';

sealed class EditModel {
  String model;
  EditModel({required this.model});
}

class Gpt4 extends EditModel {
  Gpt4() : super(model: kChatGpt4);
}

class EditModelFromValue extends EditModel {
  EditModelFromValue({required super.model});
}

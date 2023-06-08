import 'package:chat_gpt_sdk/src/utils/constants.dart';

sealed class ModerationModel {
  String model;
  ModerationModel({required this.model});
}

class TextLastModerationModel extends ModerationModel {
  TextLastModerationModel() : super(model: kTextMLast);
}

class TextStableModerationModel extends ModerationModel {
  TextStableModerationModel() : super(model: kTextMStable);
}

class ModerationModelFromValue extends ModerationModel {
  ModerationModelFromValue({required super.model});
}

import 'package:chat_gpt_sdk/src/utils/constants.dart';

enum ModerationModel { textStable, textLast }

extension ModerationModelES on ModerationModel {
  String getName() {
    switch (this) {
      case ModerationModel.textLast:
        return kTextMLast;
      case ModerationModel.textStable:
        return kTextMStable;
      default:
        return '';
    }
  }
}
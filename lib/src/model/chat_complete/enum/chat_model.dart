import '../../../utils/constants.dart';

enum ChatModel {
  gptTurbo,

  ///DEPRECATION DATE
  ///June 1st, 2023
  gptTurbo0301,
  gpt_4,

  ///DEPRECATION DATE
  ///June 1st, 2023
  gpt_4_0314,
  gpt_4_32k,

  ///DEPRECATION DATE
  ///June 1st, 2023
  gpt_4_32k_0314
}

extension ChatModelExtension on ChatModel {
  String get name {
    switch (this) {
      case ChatModel.gptTurbo0301:
        return kChatGptTurbo0301Model;
      case ChatModel.gptTurbo:
        return kChatGptTurboModel;
      case ChatModel.gpt_4:
        return kChatGpt4;
      case ChatModel.gpt_4_0314:
        return kChatGpt40314;
      case ChatModel.gpt_4_32k:
        return kChatGpt432k;
      case ChatModel.gpt_4_32k_0314:
        return kChatGpt432k0314;
      default:
        return "";
    }
  }
}

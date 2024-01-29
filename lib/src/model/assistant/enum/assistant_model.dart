import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

sealed class AssistantModel {
  final String model;

  AssistantModel({required this.model});
}

class Gpt4AModel extends AssistantModel {
  Gpt4AModel() : super(model: kChatGpt4);
}

class GptTurbo0301AModel extends AssistantModel {
  GptTurbo0301AModel() : super(model: kChatGptTurbo0301Model);
}

class GptTurbo1106AModel extends AssistantModel {
  GptTurbo1106AModel() : super(model: kChatGptTurbo1106);
}

class Gpt41106PreviewAModel extends AssistantModel {
  Gpt41106PreviewAModel() : super(model: kGpt41106Preview);
}

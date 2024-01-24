import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

sealed class AssistantModel {
  final String model;

  AssistantModel({required this.model});
}

class GptTurbo0301Model extends AssistantModel {
  GptTurbo0301Model() : super(model: kChatGptTurbo0301Model);
}

class GptTurbo1106Model extends AssistantModel {
  GptTurbo1106Model() : super(model: kChatGptTurbo1106);
}

class Gpt41106PreviewModel extends AssistantModel {
  Gpt41106PreviewModel() : super(model: kGpt41106Preview);
}

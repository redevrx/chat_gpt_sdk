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

class GptTurboModel extends AssistantModel {
  GptTurboModel() : super(model: kChatGptTurboModel);
}

class Gpt41106PreviewAModel extends AssistantModel {
  Gpt41106PreviewAModel() : super(model: kGpt41106Preview);
}

class Gpt4OModel extends AssistantModel {
  Gpt4OModel() : super(model: kGpt4o);
}

class Gpt4O2024Model extends AssistantModel {
  Gpt4O2024Model() : super(model: kGpt4O2024);
}

class Gpt4oMiniModel extends AssistantModel {
  Gpt4oMiniModel() : super(model: kGpt4oMini);
}

class Gpt4oMini2024Model extends AssistantModel {
  Gpt4oMini2024Model() : super(model: kGpt4oMini2024);
}

class Gpt41Model extends AssistantModel {
  Gpt41Model() : super(model: kGpt41);
}

class Gpt41MiniModel extends AssistantModel {
  Gpt41MiniModel() : super(model: kGpt41Mini);
}

class Gpt41NanoModel extends AssistantModel {
  Gpt41NanoModel() : super(model: kGpt41Nano);
}

class AssistantModelFromValue extends AssistantModel {
  AssistantModelFromValue({required super.model});
}

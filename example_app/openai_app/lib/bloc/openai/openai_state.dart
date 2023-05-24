import 'package:openai_app/models/message/message.dart';

abstract class OpenAIState {}

class OpenAIInitialState extends OpenAIState {}

class OpenAITokenState extends OpenAIState {
  final bool isSuccess;
  final String? token;

  OpenAITokenState({this.token, required this.isSuccess});
}

class OpenSettingState extends OpenAIState {
  final bool isOpen;

  OpenSettingState({this.isOpen = false});
}

class ChatCompletionState extends OpenAIState {
  final List<Message>? messages;
  final bool isBot;
  final bool showStopButton;

  ChatCompletionState(
      {this.messages, required this.isBot, required this.showStopButton});
}

class AuthErrorState extends OpenAIState {}

class RateLimitErrorState extends OpenAIState {}

class OpenAIServerErrorState extends OpenAIState {}

class CloseOpenAIErrorUI extends OpenAIState {}

class ClearTextInput extends OpenAIState {}

class DownloadImageState extends OpenAIState {
  final bool isSuccess;

  DownloadImageState({required this.isSuccess});
}

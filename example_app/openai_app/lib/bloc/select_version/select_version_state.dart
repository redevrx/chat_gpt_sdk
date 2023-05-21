abstract class SelectVersionState {}

class OpenAIGptVersionState extends SelectVersionState {
  final bool isGPT4;

  OpenAIGptVersionState({required this.isGPT4});
}

class SelectVersionInitState extends SelectVersionState {}

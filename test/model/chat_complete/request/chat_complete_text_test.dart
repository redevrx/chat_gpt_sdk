import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('ChatCompleteText', () {
    test('toJson returns the correct map', () {
      final messages = [
        Messages(
          role: Role.user,
          content: "Hello",
          name: "name function",
        ),
      ];

      final chatCompleteText = ChatCompleteText(
        model: GptTurbo0631Model(),
        messages: messages,
        temperature: 0.5,
        topP: 0.9,
        n: 2,
        stream: true,
        stop: ["User:"],
        maxToken: 50,
        presencePenalty: -0.5,
        frequencyPenalty: 0.5,
        user: "user123",
      );

      final expectedMap = {
        'model': 'gpt-3.5-turbo-0613',
        'messages': [
          {
            'role': 'user',
            'content': 'Hello',
            'name': "name function",
            'function_call': null,
          },
        ],
        'functions': null,
        'function_call': null,
        'temperature': 0.5,
        'top_p': 0.9,
        'n': 2,
        'stream': true,
        'stop': ['User:'],
        'max_tokens': 50,
        'presence_penalty': -0.5,
        'frequency_penalty': 0.5,
        'user': 'user123',
      };
      expect(chatCompleteText.toJson(), expectedMap);
    });

    test('toJson() with default values', () {
      final chatCompleteText = ChatCompleteText(
        model: GptTurbo0631Model(),
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
            name: "name function",
          ),
          Messages(
            role: Role.assistant,
            content: "Hi, how can I assist you today?",
            name: "name function",
          ),
        ],
        functionCall: FunctionCall.auto,
        functions: [
          FunctionData(name: "name", description: "", parameters: Map.of({})),
        ],
      );

      final expectedJson = {
        'model': 'gpt-3.5-turbo-0613',
        'messages': [
          {
            'role': 'user',
            'content': 'Hello',
            'name': "name function",
            'function_call': null,
          },
          {
            'role': 'assistant',
            'content': 'Hi, how can I assist you today?',
            'name': "name function",
            'function_call': null,
          },
        ],
        'functions': [
          {'name': 'name', 'description': '', 'parameters': {}},
        ],
        'function_call': 'auto',
        'temperature': 0.3,
        'top_p': 1.0,
        'n': 1,
        'stream': false,
        'stop': null,
        'max_tokens': 100,
        'presence_penalty': 0.0,
        'frequency_penalty': 0.0,
        'user': '',
      };

      expect(chatCompleteText.toJson(), expectedJson);
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatCompleteText', () {
    test('toJson returns the correct map', () {
      final messages = [
        {"speaker": "User", "text": "Hello!"},
        {"speaker": "Bot", "text": "Hi there! How can I help you?"}
      ];
      final chatCompleteText = ChatCompleteText(
          model: ChatModel.ChatGptTurboModel,
          messages: messages,
          temperature: 0.5,
          topP: 0.9,
          n: 2,
          stream: true,
          stop: ["User:"],
          maxToken: 50,
          presencePenalty: -0.5,
          frequencyPenalty: 0.5,
          user: "user123");

      final expectedMap = {
        "model": kChatGptTurboModel,
        "messages": messages,
        "temperature": 0.5,
        "top_p": 0.9,
        "n": 2,
        "stream": true,
        "stop": ["User:"],
        "max_tokens": 50,
        "presence_penalty": -0.5,
        "frequency_penalty": 0.5,
        "user": "user123"
      };
      expect(chatCompleteText.toJson(), expectedMap);
    });

    test('toJson() with default values', () {
      final chatCompleteText = ChatCompleteText(
        model: ChatModel.ChatGptTurboModel,
        messages: [
          {'speaker': 'user', 'text': 'Hello!'},
          {'speaker': 'chatbot', 'text': 'Hi, how can I assist you today?'},
        ],
      );

      final expectedJson = {
        "model": kChatGptTurboModel,
        "messages": [
          {'speaker': 'user', 'text': 'Hello!'},
          {'speaker': 'chatbot', 'text': 'Hi, how can I assist you today?'},
        ],
        "temperature": .3,
        "top_p": 1.0,
        "n": 1,
        "stream": false,
        "stop": null,
        "max_tokens": 100,
        "presence_penalty": .0,
        "frequency_penalty": .0,
        "user": "",
      };

      expect(chatCompleteText.toJson(), expectedJson);
    });
  });
}

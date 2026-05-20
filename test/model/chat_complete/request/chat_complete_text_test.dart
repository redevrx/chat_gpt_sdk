import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('ChatCompleteText', () {
    test('toJson returns the correct map', () {
      final messages = [
        Messages(
          role: Role.user,
          content: 'Hello',
          name: 'function_name',
        ).toJsonFunctionStruct(),
      ];

      final chatCompleteText = ChatCompleteText(
        model: GptTurbo0631Model(),
        messages: messages,
        temperature: 0.5,
        topP: 0.9,
        n: 2,
        stream: true,
        stop: ['User:'],
        maxToken: 50,
        presencePenalty: -0.5,
        frequencyPenalty: 0.5,
        user: 'user123',
      );

      // The expected map should not have any `null` values.
      final expectedMap = {
        'model': 'gpt-3.5-turbo-0613',
        'messages': [
          {
            'role': 'user',
            'content': 'Hello',
            'name': 'function_name',
          },
        ],
        'temperature': 0.5,
        'top_p': 0.9,
        'n': 2,
        'stream': true,
        'stop': ['User:'],
        'max_tokens': 50,
        'presence_penalty': -0.5,
        'frequency_penalty': 0.5,
        'user': 'user123',
        'logprobs': false,
      };
      expect(chatCompleteText.toJson(), expectedMap);
    });

    test('toJson() with default values', () {
      final chatCompleteText = ChatCompleteText(
        model: GptTurbo0631Model(),
        messages: [
          Messages(
            role: Role.user,
            content: 'Hello',
            name: 'function_name',
          ).toJsonFunctionStruct(),
          Messages(
            role: Role.assistant,
            content: 'Hi, how can I assist you today?',
            name: 'function_name',
          ).toJsonFunctionStruct(),
        ],
        // functionCall: FunctionCall.auto,
        // functions: [
        //   FunctionData(
        //     name: 'function_name',
        //     description: '',
        //     parameters: Map.of({}),
        //   ),
        // ],
      );

      final expectedJson = {
        'model': 'gpt-3.5-turbo-0613',
        'messages': [
          {
            'role': 'user',
            'content': 'Hello',
            'name': 'function_name',
          },
          {
            'role': 'assistant',
            'content': 'Hi, how can I assist you today?',
            'name': 'function_name',
          },
        ],
        // 'functions': [
        //   {'name': 'function_name', 'description': '', 'parameters': {}},
        // ],
        // 'function_call': 'auto',
        'temperature': 0.3,
        'top_p': 1.0,
        'n': 1,
        'stream': false,
        'max_tokens': 100,
        'presence_penalty': 0.0,
        'frequency_penalty': 0.0,
        'user': '',
        'logprobs': false,
      };

      expect(chatCompleteText.toJson(), expectedJson);
    });

    test('toJson() with reasoning effort and max completion tokens', () {
      final chatCompleteText = ChatCompleteText(
        model: O3MiniChatModel(),
        messages: [
          Messages(
            role: Role.user,
            content: 'Write a quicksort algorithm in Dart',
          ).toJsonFunctionStruct(),
        ],
        temperature: 1.0,
        maxToken: null,
        reasoningEffort: 'medium',
        maxCompletionTokens: 2000,
      );

      final expectedJson = {
        'model': 'o3-mini',
        'messages': [
          {
            'role': 'user',
            'content': 'Write a quicksort algorithm in Dart',
          },
        ],
        'temperature': 1.0,
        'top_p': 1.0,
        'n': 1,
        'stream': false,
        'presence_penalty': 0.0,
        'frequency_penalty': 0.0,
        'user': '',
        'logprobs': false,
        'reasoning_effort': 'medium',
        'max_completion_tokens': 2000,
      };

      expect(chatCompleteText.toJson(), expectedJson);
    });

    test('toJson() with modern OpenAI features (developer/tool roles, store, metadata, parallelToolCalls, streamOptions)', () {
      final chatCompleteText = ChatCompleteText(
        model: Gpt4OChatModel(),
        messages: [
          Messages(
            role: Role.developer,
            content: 'You are a helpful assistant.',
          ).toJson(),
          Messages(
            role: Role.tool,
            content: 'Tool response content',
            name: 'get_weather_tool',
          ).toJsonFunctionStruct(),
        ],
        parallelToolCalls: false,
        store: true,
        maxToken: null,
        metadata: {
          'customer_id': '12345',
          'env': 'production',
        },
        stream: true,
        streamOptions: {
          'include_usage': true,
        },
      );

      final expectedJson = {
        'model': 'gpt-4o',
        'messages': [
          {
            'role': 'developer',
            'content': 'You are a helpful assistant.',
          },
          {
            'role': 'tool',
            'content': 'Tool response content',
            'name': 'get_weather_tool',
          },
        ],
        'temperature': 0.3,
        'top_p': 1.0,
        'n': 1,
        'stream': true,
        'presence_penalty': 0.0,
        'frequency_penalty': 0.0,
        'user': '',
        'logprobs': false,
        'parallel_tool_calls': false,
        'store': true,
        'metadata': {
          'customer_id': '12345',
          'env': 'production',
        },
        'stream_options': {
          'include_usage': true,
        },
      };

      expect(chatCompleteText.toJson(), expectedJson);
    });

    test('toJson() with audio modalities and ChatAudioConfig', () {
      final chatCompleteText = ChatCompleteText(
        model: Gpt4OChatModel(),
        messages: [
          Messages(
            role: Role.user,
            content: 'Hello, speak to me!',
          ).toJson(),
        ],
        modalities: ['text', 'audio'],
        audio: ChatAudioConfig(
          voice: 'alloy',
          format: 'wav',
        ),
      );

      final expectedJson = {
        'model': 'gpt-4o',
        'messages': [
          {
            'role': 'user',
            'content': 'Hello, speak to me!',
          },
        ],
        'temperature': 0.3,
        'top_p': 1.0,
        'n': 1,
        'stream': false,
        'max_tokens': 100,
        'presence_penalty': 0.0,
        'frequency_penalty': 0.0,
        'user': '',
        'logprobs': false,
        'modalities': ['text', 'audio'],
        'audio': {
          'voice': 'alloy',
          'format': 'wav',
        },
      };

      expect(chatCompleteText.toJson(), expectedJson);
    });
  });
}

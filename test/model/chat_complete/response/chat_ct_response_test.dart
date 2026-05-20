import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/message.dart';
import 'package:test/test.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';

void main() {
  test('ChatCTResponse can be instantiated', () {
    final ChatCTResponse chatCTResponse = ChatCTResponse(
      id: "id_test",
      object: "object_test",
      created: 1,
      choices: [
        ChatChoice(
          index: 0,
          message: Message(
            role: "role_test",
            content: "content_test",
          ),
          finishReason: "finish_reason_test",
        ),
      ],
      usage: Usage(10, 20, 30),
      systemFingerprint: '',
      model: '',
    );

    expect(chatCTResponse.id, "id_test");
    expect(chatCTResponse.object, "object_test");
    expect(chatCTResponse.created, 1);
    expect(chatCTResponse.choices.length, 1);
    expect(chatCTResponse.usage?.promptTokens, 10);
    expect(chatCTResponse.usage?.completionTokens, 20);
    expect(chatCTResponse.usage?.totalTokens, 30);
  });

  test('ChatCTResponse can be instantiated from json', () {
    final Map<String, dynamic> json = {
      "id": "id_test",
      "object": "object_test",
      "created": 1,
      "choices": [
        {
          "index": 0,
          "message": {"role": "role_test", "content": "content_test"},
          "finish_reason": "finish_reason_test",
        },
      ],
      "usage": {
        "prompt_tokens": 10,
        "completion_tokens": 20,
        "total_tokens": 30,
      },
    };

    final ChatCTResponse chatCTResponse = ChatCTResponse.fromJson(json);

    expect(chatCTResponse.id, "id_test");
    expect(chatCTResponse.object, "object_test");
    expect(chatCTResponse.created, 1);
    expect(chatCTResponse.choices.length, 1);
    expect(chatCTResponse.usage?.promptTokens, 10);
    expect(chatCTResponse.usage?.completionTokens, 20);
    expect(chatCTResponse.usage?.totalTokens, 30);
  });

  test('toJson should return a map with the same fields', () {
    final ChatCTResponse chatCTResponse = ChatCTResponse(
      id: "id_test",
      object: "object_test",
      created: 1,
      choices: [
        ChatChoice(
          index: 0,
          message: Message(
            role: "role_test",
            content: "content_test",
          ),
          finishReason: "finish_reason_test",
        ),
      ],
      usage: Usage(10, 20, 30),
      systemFingerprint: '',
      model: '',
    );

    final Map<String, dynamic> json = chatCTResponse.toJson();

    expect(json["id"], "id_test");
    expect(json["object"], "object_test");
    expect(json["created"], 1);
    expect(json["choices"].length, 1);
    expect(json["usage"]["prompt_tokens"], 10);
    expect(json["usage"]["completion_tokens"], 20);
    expect(json["usage"]["total_tokens"], 30);
  });

  test('ChatCTResponse can be instantiated from json with message audio response', () {
    final Map<String, dynamic> json = {
      "id": "chatcmpl-audio123",
      "object": "chat.completion",
      "created": 1715000000,
      "model": "gpt-4o",
      "choices": [
        {
          "index": 0,
          "message": {
            "role": "assistant",
            "content": "",
            "audio": {
              "id": "audio_abc123",
              "expires_at": 1715003600,
              "data": "base64_data_here",
              "transcript": "Hello, how can I help you?"
            }
          },
          "finish_reason": "stop"
        }
      ],
      "usage": {
        "prompt_tokens": 15,
        "completion_tokens": 25,
        "total_tokens": 40
      }
    };

    final ChatCTResponse chatCTResponse = ChatCTResponse.fromJson(json);

    expect(chatCTResponse.id, "chatcmpl-audio123");
    expect(chatCTResponse.choices.first.message?.role, "assistant");
    expect(chatCTResponse.choices.first.message?.audio?.id, "audio_abc123");
    expect(chatCTResponse.choices.first.message?.audio?.expiresAt, 1715003600);
    expect(chatCTResponse.choices.first.message?.audio?.data, "base64_data_here");
    expect(chatCTResponse.choices.first.message?.audio?.transcript, "Hello, how can I help you?");
  });

  test('toJson should return a map with message audio response', () {
    final ChatCTResponse chatCTResponse = ChatCTResponse(
      id: "chatcmpl-audio123",
      object: "chat.completion",
      created: 1715000000,
      choices: [
        ChatChoice(
          index: 0,
          message: Message(
            role: "assistant",
            content: "",
            audio: MessageAudio(
              id: "audio_abc123",
              expiresAt: 1715003600,
              data: "base64_data_here",
              transcript: "Hello, how can I help you?",
            ),
          ),
          finishReason: "stop",
        ),
      ],
      usage: Usage(15, 25, 40),
      systemFingerprint: '',
      model: 'gpt-4o',
    );

    final Map<String, dynamic> json = chatCTResponse.toJson();

    expect(json["choices"][0]["message"]["audio"]["id"], "audio_abc123");
    expect(json["choices"][0]["message"]["audio"]["expires_at"], 1715003600);
    expect(json["choices"][0]["message"]["audio"]["data"], "base64_data_here");
    expect(json["choices"][0]["message"]["audio"]["transcript"], "Hello, how can I help you?");
  });
}

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
}

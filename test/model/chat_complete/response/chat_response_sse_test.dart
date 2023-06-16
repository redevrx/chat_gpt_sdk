import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice_sse.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/message.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';
import 'package:test/test.dart';

void main() {
  test('ChatCTResponse can be instantiated', () {
    final ChatResponseSSE chatCTResponse = ChatResponseSSE(
      id: "id_test",
      object: "object_test",
      created: 1,
      choices: [
        ChatChoiceSSE(
          index: 0,
          message: Message(
            role: "role_test",
            content: "content_test",
          ),
          finishReason: "finish_reason_test",
        ),
      ],
      usage: Usage(10, 20, 30),
    );

    expect(chatCTResponse.id, "id_test");
    expect(chatCTResponse.object, "object_test");
    expect(chatCTResponse.created, 1);
    expect(chatCTResponse.choices?.length, 1);
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
          "delta": {"role": "role_test", "content": "content_test"},
          "finish_reason": "finish_reason_test",
        },
      ],
      "usage": {
        "prompt_tokens": 10,
        "completion_tokens": 20,
        "total_tokens": 30,
      },
    };

    final response = ChatResponseSSE.fromJson(json);

    expect(response.id, "id_test");
    expect(response.object, "object_test");
    expect(response.created, 1);
    expect(response.choices?.length, 1);
    expect(response.usage?.promptTokens, 10);
    expect(response.usage?.completionTokens, 20);
    expect(response.usage?.totalTokens, 30);
  });

  test('toJson should return a map with the same fields', () {
    final ChatResponseSSE chatCTResponse = ChatResponseSSE(
      id: "id_test",
      object: "object_test",
      created: 1,
      choices: [
        ChatChoiceSSE(
          index: 0,
          message: Message(
            role: "role_test",
            content: "content_test",
          ),
          finishReason: "finish_reason_test",
        ),
      ],
      usage: Usage(10, 20, 30),
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

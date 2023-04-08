import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/client/exception/openai_exception.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_gpt_test.mocks.dart';

@GenerateMocks([OpenAI, SharedPreferences])
void main() async {
  final openAI = MockOpenAI();

  group('chatGPT-3 text completion test', () {
    test('text completion use success case', () async {
      final request = CompleteText(prompt: 'snake', model: Model.TextDavinci3);
      final choice = [Choices('', 1, '', '')];

      when(openAI.onCompletion(request: request)).thenAnswer(
          (inv) async => CTResponse('id', 'object', 1, 'model', choice, null));
      openAI.onCompletion(request: request);

      verify(openAI.onCompletion(request: request));
    });

    test('text completion success case with return result', () async {
      final request = CompleteText(prompt: 'snake', model: Model.TextDavinci3);
      final choice = [Choices('', 1, '', '')];

      when(openAI.onCompletion(request: request)).thenAnswer(
          (inv) async => CTResponse('id', 'object', 1, 'model', choice, null));

      final response = await openAI.onCompletion(request: request);

      expect(response?.object, 'object');
      expect(response?.id, 'id');
      expect(response?.model, 'model');
      expect(response!, TypeMatcher<CTResponse>());
    });

    test('text completion error case with prompt empty', () async {
      final request = CompleteText(prompt: '', model: Model.TextDavinci3);
      when(openAI.onCompletion(request: request))
          .thenAnswer((_) => throw RequestError(message: 'error', code: 404));
      verifyNever(openAI.onCompletion(request: request));
    });
  });

  group('chatGPT-3 text completion with stream SSE test', () {
    test('text completion stream case success', () async {
      final request =
          CompleteText(prompt: 'snake is ?', model: Model.TextDavinci3);
      final choice = [Choices('', 1, '', '')];

      when(openAI.onCompletionSSE(request: request)).thenAnswer((_) =>
          Stream.value(CTResponse('id', 'object', 1, 'model', choice, null)));

      final response = await openAI.onCompletionSSE(request: request);

      verify(openAI.onCompletionSSE(request: request));
      expect(response, TypeMatcher<Stream<CTResponse>>());
    });

    test('text completion stream case error', () async {
      final request = CompleteText(prompt: '', model: Model.TextDavinci3);

      when(openAI.onCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError(message: 'message', code: 404));

      verifyNever(openAI.onCompletionSSE(request: request));
    });
  });

  group('chatGPT-3.5 turbo chat completion test', () {
    test('chat completion success case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.ChatGptTurbo0301Model);
      final choice = [ChatChoice(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletion(request: request)).thenAnswer((_) async =>
          ChatCTResponse(
              id: 'id',
              object: 'object',
              created: 1,
              choices: choice,
              usage: null));

      final response = await openAI.onChatCompletion(request: request);
      verify(openAI.onChatCompletion(request: request));
      expect(response?.object, 'object');
      expect(response?.id, 'id');
    });

    test('chat completion error case with content null return error test',
        () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": ''})
      ], maxToken: 200, model: ChatModel.ChatGptTurbo0301Model);

      when(openAI.onChatCompletion(request: request))
          .thenAnswer((_) => throw RequestError(message: '', code: 404));

      verifyNever(openAI.onChatCompletion(request: request));
    });
  });

  group('chatGPT-3.5 turbo chat completion with stream SSE test', () {
    test('openAI chat completion stream success case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.ChatGptTurbo0301Model);
      final choice = [ChatChoice(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletionSSE(request: request)).thenAnswer(
          (realInvocation) => Stream.value(ChatCTResponse(
              id: 'id',
              object: 'object',
              created: 1,
              choices: choice,
              usage: null)));

      final response = await openAI.onChatCompletionSSE(request: request).first;
      verify(await openAI.onChatCompletionSSE(request: request));
      expect(response.id, 'id');
      expect(response.object, 'object');
      expect(response, TypeMatcher<ChatCTResponse>());
    });

    test('openAI chat completion stream error case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.ChatGptTurbo0301Model);

      when(openAI.onChatCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError());
      verifyNever(openAI.onChatCompletionSSE(request: request));
    });
  });
}

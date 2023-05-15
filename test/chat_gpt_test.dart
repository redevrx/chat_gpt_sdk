import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice_sse.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_response_sse.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';
import 'package:chat_gpt_sdk/src/model/openai_engine/engine_data.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/openai_model_data.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_gpt_test.mocks.dart';

@GenerateNiceMocks([MockSpec<OpenAI>()])
void main() async {
  final openAI = MockOpenAI();

  group('chatGPT-3 text completion test', () {
    test('text completion use success case', () async {
      final request = CompleteText(prompt: 'snake', model: Model.textDavinci3);
      final choice = [Choices('', 1, '', '')];

      when(openAI.onCompletion(request: request)).thenAnswer(
          (inv) async => CTResponse('id', 'object', 1, 'model', choice, null));
      openAI.onCompletion(request: request);

      verify(openAI.onCompletion(request: request));
    });

    test('text completion success case with return result', () async {
      final request = CompleteText(prompt: 'snake', model: Model.textDavinci3);
      final choice = [Choices('', 1, '', '')];

      when(openAI.onCompletion(request: request)).thenAnswer(
          (inv) async => CTResponse('id', 'object', 1, 'model', choice, null));

      final response = await openAI.onCompletion(request: request);

      expect(response?.object, 'object');
      expect(response?.id, 'id');
      expect(response?.model, 'model');
      expect(response!, const TypeMatcher<CTResponse>());
    });

    test('text completion error case with prompt empty', () async {
      final request = CompleteText(prompt: '', model: Model.textDavinci3);
      when(openAI.onCompletion(request: request))
          .thenAnswer((_) => throw RequestError(message: 'error', code: 404));
      verifyNever(openAI.onCompletion(request: request));
    });
  });

  group('chatGPT-3 text completion with stream SSE test', () {
    test('text completion stream case success', () async {
      final request = CompleteText(prompt: 'snake is ?', model: Model.ada);
      final choice = [Choices('', 1, '', '')];

      when(openAI.onCompletionSSE(request: request)).thenAnswer((_) =>
          Stream.value(CTResponse('id', 'object', 1, 'model', choice, null)));

      final response = openAI.onCompletionSSE(request: request);

      verify(openAI.onCompletionSSE(request: request));
      expect(response, const TypeMatcher<Stream<CTResponse>>());
    });

    test('text completion stream case error', () async {
      final request = CompleteText(prompt: '', model: Model.ada);

      when(openAI.onCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError(message: 'message', code: 404));

      verifyNever(openAI.onCompletionSSE(request: request));
    });
  });

  group('chatGPT-3.5 turbo chat completion test', () {
    test('chat completion success case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.gptTurbo);
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
      ], maxToken: 200, model: ChatModel.gptTurbo0301);

      when(openAI.onChatCompletion(request: request))
          .thenAnswer((_) => throw RequestError(message: '', code: 404));

      verifyNever(openAI.onChatCompletion(request: request));
    });
  });

  group('chatGPT-4 chat completion test', () {
    test('chat completion success case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.gpt_4);
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
      ], maxToken: 200, model: ChatModel.gpt_4);

      when(openAI.onChatCompletion(request: request))
          .thenAnswer((_) => throw RequestError(message: '', code: 404));

      verifyNever(openAI.onChatCompletion(request: request));
    });
  });

  group('chatGPT-3.5 turbo chat completion with stream SSE test', () {
    test('openAI chat completion stream success case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.gptTurbo);
      final choice = [ChatChoiceSSE(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletionSSE(request: request)).thenAnswer(
          (realInvocation) => Stream.value(ChatCTResponseSSE(
              id: 'id',
              object: 'object',
              created: 1,
              choices: choice,
              usage: null)));

      final response = await openAI.onChatCompletionSSE(request: request).first;
      verify(openAI.onChatCompletionSSE(request: request));
      expect(response.id, 'id');
      expect(response.object, 'object');
      expect(response, const TypeMatcher<ChatCTResponseSSE>());
    });

    test('openAI chat completion stream error case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.gptTurbo0301);

      when(openAI.onChatCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError());
      verifyNever(openAI.onChatCompletionSSE(request: request));
    });
  });

  group('chatGPT-4 chat completion with stream SSE test', () {
    test('openAI chat completion stream success case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.gpt_4);
      final choice = [ChatChoiceSSE(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletionSSE(request: request)).thenAnswer(
          (realInvocation) => Stream.value(ChatCTResponseSSE(
              id: 'id',
              object: 'object',
              created: 1,
              choices: choice,
              usage: null)));

      final response = await openAI.onChatCompletionSSE(request: request).first;
      verify(openAI.onChatCompletionSSE(request: request));
      expect(response.id, 'id');
      expect(response.object, 'object');
      expect(response, const TypeMatcher<ChatCTResponseSSE>());
    });

    test('openAI chat completion stream error case test', () async {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], maxToken: 200, model: ChatModel.gpt_4);

      when(openAI.onChatCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError());
      verifyNever(openAI.onChatCompletionSSE(request: request));
    });
  });

  group('chatGPT Image Generate With Prompt test case', () {
    test('chatGPT Image Generate With Prompt success case  test', () async {
      final request = GenerateImage('snake red eating cat.', 2);

      when(openAI.generateImage(request))
          .thenAnswer((_) async => GenImgResponse());

      final response = await openAI.generateImage(request);

      verify(await openAI.generateImage(request));
      expect(response, const TypeMatcher<GenImgResponse>());
    });

    test('chatGPT Image Generate With Prompt success case return value test',
        () async {
      final request = GenerateImage('snake red eating cat.', 2);

      when(openAI.generateImage(request))
          .thenAnswer((_) async => GenImgResponse(created: 1221120));

      final response = await openAI.generateImage(request);

      verify(await openAI.generateImage(request));
      expect(response, const TypeMatcher<GenImgResponse>());
      expect(response?.created, 1221120);
    });

    test('chatGPT Image Generate With Prompt error case with n is 0 test',
        () async {
      final request = GenerateImage('snake red eating cat.', 1);

      when(openAI.generateImage(request))
          .thenAnswer((_) async => GenImgResponse(created: 1221120));

      final response = await openAI.generateImage(request);

      verify(await openAI.generateImage(request));
      expect(response, const TypeMatcher<GenImgResponse>());
      expect(response?.created, 1221120);
      expect(response?.data, null);
      expect(() => GenerateImage('snake red eating cat.', 0),
          throwsAssertionError);
    });
  });

  group('chatGPT Models & Engine test', () {
    test('chatGPT Models success case test', () async {
      when(openAI.listModel()).thenAnswer((_) async => AiModel([
            ModelData('id', '', 'ownerBy', [
              Permission('id', 'object', 12, false, false, false, false, false,
                  false, 'organization', 'group', false)
            ])
          ], '12'));

      final response = await openAI.listModel();
      expect(response, const TypeMatcher<AiModel>());
      verify(await openAI.listModel());
      expect(response.object, '12');
    });

    test('chatGPT Engine success case test', () async {
      when(openAI.listEngine()).thenAnswer((_) async =>
          EngineModel([EngineData('id', 'object', 'owner', false)], 'object'));

      final response = await openAI.listEngine();

      verify(openAI.listEngine());
      expect(response.object, 'object');
    });
  });
}

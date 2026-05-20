import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/responses/request/openai_response_request.dart';
import 'package:test/test.dart';

void main() {
  group('OpenAI Instance Integration Tests', () {
    late HttpServer server;
    late String localUrl;
    StreamSubscription? serverSubscription;

    setUpAll(() async {
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      localUrl = 'http://localhost:${server.port}/';

      serverSubscription = server.listen((HttpRequest request) async {
        final path = request.uri.path;
        request.response.headers.contentType = ContentType.json;

        if (path.endsWith('/models')) {
          request.response.write(
            jsonEncode({
              'object': 'list',
              'data': [
                {
                  'id': 'model-1',
                  'object': 'model',
                  'owned_by': 'owner',
                  'permission': null,
                },
              ],
            }),
          );
        } else if (path.endsWith('/engines')) {
          request.response.write(
            jsonEncode({
              'object': 'list',
              'data': [
                {
                  'id': 'engine-1',
                  'object': 'engine',
                  'owner': 'owner',
                  'ready': true,
                },
              ],
            }),
          );
        } else if (path.endsWith('/chat/completions')) {
          if (request.method == 'POST') {
            final bodyBytes = await request.fold<List<int>>(
              [],
              (p, e) => p..addAll(e),
            );
            final bodyStr = utf8.decode(bodyBytes);
            if (bodyStr.contains('"stream":true')) {
              request.response.headers.contentType = ContentType(
                'text',
                'event-stream',
              );
              request.response.write(
                'data: {"id": "chat-1", "object": "chat.completion.chunk", "created": 123, "choices": [{"index": 0, "delta": {"role": "assistant", "content": "hi"}}]}\n\n',
              );
              request.response.write('data: [DONE]\n\n');
            } else {
              request.response.write(
                jsonEncode({
                  'id': 'chat-1',
                  'object': 'chat.completion',
                  'created': 123,
                  'choices': [
                    {
                      'index': 0,
                      'message': {'role': 'assistant', 'content': 'hi'},
                    },
                  ],
                }),
              );
            }
          }
        } else if (path.endsWith('/completions')) {
          if (request.method == 'POST') {
            // Check if SSE stream request
            final bodyBytes = await request.fold<List<int>>(
              [],
              (p, e) => p..addAll(e),
            );
            final bodyStr = utf8.decode(bodyBytes);
            if (bodyStr.contains('"stream":true')) {
              request.response.headers.contentType = ContentType(
                'text',
                'event-stream',
              );
              request.response.write(
                'data: {"id": "comp-1", "object": "text_completion", "created": 123, "model": "m", "choices": [{"text": "hello", "index": 0, "finish_reason": "stop"}]}\n\n',
              );
              request.response.write('data: [DONE]\n\n');
            } else {
              request.response.write(
                jsonEncode({
                  'id': 'comp-1',
                  'object': 'text_completion',
                  'created': 123,
                  'model': 'm',
                  'choices': [
                    {'text': 'hello', 'index': 0, 'finish_reason': 'stop'},
                  ],
                }),
              );
            }
          }
        } else if (path.endsWith('/images/generations')) {
          request.response.write(
            jsonEncode({
              'created': 1234,
              'data': [
                {'url': 'http://img'},
              ],
            }),
          );
        } else if (path.endsWith('/responses')) {
          request.response.write(
            jsonEncode({'id': 'resp-1', 'object': 'response', 'choices': []}),
          );
        } else {
          request.response.statusCode = 404;
          request.response.write(jsonEncode({'error': 'not found'}));
        }

        await request.response.close();
      });
    });

    tearDownAll(() async {
      await serverSubscription?.cancel();
      await server.close(force: true);
    });

    test('OpenAI build and token getters/setters', () {
      // Missing token throws
      expect(
        () => OpenAI.instance.build(token: ''),
        throwsA(isA<MissingTokenException>()),
      );
      expect(
        () => OpenAI.instance.build(token: null),
        throwsA(isA<MissingTokenException>()),
      );

      // Successful build
      final ai = OpenAI.instance.build(
        token: 'initial-token',
        orgId: 'initial-org',
        apiUrl: localUrl,
        enableLog: true,
      );

      expect(ai.token, 'initial-token');
      expect(ai.orgId, 'initial-org');

      // Setters
      ai.setToken('new-token');
      expect(ai.token, 'new-token');

      ai.setOrgId('new-org');
      expect(ai.orgId, 'new-org');
    });

    test('OpenAI build with HttpSetup options', () {
      // Custom http setup
      final ai = OpenAI.instance.build(
        token: 'token',
        apiUrl: localUrl,
        baseOption: HttpSetup(
          connectTimeout: const Duration(seconds: 1),
          sendTimeout: const Duration(seconds: 1),
          receiveTimeout: const Duration(seconds: 1),
          proxy: 'localhost:8080',
        ),
      );
      expect(ai.token, 'token');
    });

    test('OpenAI instance sub-component getters', () {
      final ai = OpenAI.instance;
      expect(ai.editor, isNotNull);
      expect(ai.embed, isNotNull);
      expect(ai.audio, isNotNull);
      expect(ai.file, isNotNull);
      expect(ai.fineTune, isNotNull);
      expect(ai.moderation, isNotNull);
      expect(ai.assistant, isNotNull);
      expect(ai.threads, isNotNull);
      expect(ai.projectAndOrg, isNotNull);
    });

    test('OpenAI instance API calls', () async {
      final ai = OpenAI.instance.build(token: 'fake-token', apiUrl: localUrl);

      // listModel
      final models = await ai.listModel();
      expect(models.data.first.id, 'model-1');

      // listEngine
      final engines = await ai.listEngine();
      expect(engines.data.first.id, 'engine-1');

      // onCompletion
      final completion = await ai.onCompletion(
        request: CompleteText(prompt: 'hello', model: Gpt3TurboInstruct()),
      );
      expect(completion?.choices.first.text, 'hello');

      // onChatCompletion
      final chatComp = await ai.onChatCompletion(
        request: ChatCompleteText(
          messages: [Messages(role: Role.user, content: 'hi').toJson()],
          model: Gpt4oMiniChatModel(),
        ),
      );
      expect(chatComp?.choices.first.message?.content, 'hi');

      // generateImage
      final img = await ai.generateImage(
        GenerateImage('cat', 1, model: DallE2()),
      );
      expect(img?.data?.first?.url, 'http://img');

      // onResponse
      final resp = await ai.onResponse(
        request: OpenAiResponseRequest(model: 'gpt-4', input: 'hello'),
      );
      expect(resp?.id, 'resp-1');

      // onChatCompletionSSE
      final chatStream = ai.onChatCompletionSSE(
        request: ChatCompleteText(messages: [], model: Gpt4oMiniChatModel()),
      );
      final chatList = await chatStream.toList();
      expect(chatList.first.choices?.first.message?.content, 'hi');

      // onCompletionSSE
      final compStream = ai.onCompletionSSE(
        request: CompleteText(prompt: 'hello', model: Gpt3TurboInstruct()),
      );
      final compList = await compStream.toList();
      expect(compList.first.choices.first.text, 'hello');
    });
  });
}

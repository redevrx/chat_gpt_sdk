import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/audio.dart';
import 'package:chat_gpt_sdk/src/embedding.dart';
import 'package:chat_gpt_sdk/src/fine_tuned.dart';
import 'package:chat_gpt_sdk/src/moderation.dart';
import 'package:chat_gpt_sdk/src/openai_file.dart';
import 'package:chat_gpt_sdk/src/assistants.dart';
import 'package:chat_gpt_sdk/src/threads.dart';
import 'package:chat_gpt_sdk/src/runs.dart';
import 'package:chat_gpt_sdk/src/messages.dart' as api_msg;
import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/enum/fine_model.dart';
import 'package:chat_gpt_sdk/src/model/assistant/enum/assistant_model.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

// A mock HTTP client adapter to intercept and fake requests
class MockHttpClientAdapter implements HttpClientAdapter {
  late Future<ResponseBody> Function(
    RequestOptions options,
    Stream<Uint8List>? requestBody,
    Future<void>? cancelFuture,
  )
  handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestBody,
    Future<void>? cancelFuture,
  ) {
    return handler(options, requestBody, cancelFuture);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('Coverage Enhancement Tests', () {
    late OpenAI openAI;
    late OpenAIClient openAIClient;
    late MockHttpClientAdapter mockAdapter;
    late Dio dio;

    setUp(() {
      mockAdapter = MockHttpClientAdapter();
      dio = Dio();
      dio.httpClientAdapter = mockAdapter;
      // Initialize OpenAIClient directly using our custom dio, ensuring trailing slash!
      openAIClient = OpenAIClient(
        dio: dio,
        apiUrl: 'https://api.openai.com/v1/',
        isLogging: false,
      );
      // Initialize the global OpenAI instance or use our client directly
      openAI = OpenAI.instance.build(
        token: 'mock-token',
        orgId: 'mock-org',
        apiUrl: 'https://api.openai.com/v1/',
        enableLog: false,
      );
    });

    ResponseBody mockJSON(Map<String, dynamic> data, [int statusCode = 200]) {
      return ResponseBody(
        Stream.value(Uint8List.fromList(utf8.encode(jsonEncode(data)))),
        statusCode,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }

    ResponseBody mockRaw(String content, [int statusCode = 200]) {
      return ResponseBody(
        Stream.value(Uint8List.fromList(utf8.encode(content))),
        statusCode,
        headers: {
          Headers.contentTypeHeader: ['text/plain'],
        },
      );
    }

    ResponseBody mockBytes(List<int> bytes, [int statusCode = 200]) {
      return ResponseBody(
        Stream.value(Uint8List.fromList(bytes)),
        statusCode,
        headers: {
          Headers.contentTypeHeader: ['application/octet-stream'],
        },
      );
    }

    test('OpenAIClient get - success', () async {
      mockAdapter.handler = (options, _, __) async {
        expect(options.method, 'GET');
        return mockJSON({'status': 'success'});
      };

      final res = await openAIClient.get<Map<String, dynamic>>(
        'https://api.openai.com/v1/test',
        onCancel: (_) {},
        onSuccess: (data) => data,
      );
      expect(res['status'], 'success');
    });

    test('OpenAIClient get - raw data', () async {
      mockAdapter.handler = (options, _, __) async {
        return mockJSON({'raw': 'data'});
      };

      final res = await openAIClient.get<Map<String, dynamic>>(
        'https://api.openai.com/v1/test',
        returnRawData: true,
        onCancel: (_) {},
        onSuccess: (data) => data,
      );
      expect(res['raw'], 'data');
    });

    test('OpenAIClient delete - success', () async {
      mockAdapter.handler = (options, _, __) async {
        expect(options.method, 'DELETE');
        return mockJSON({'deleted': true});
      };

      final res = await openAIClient.delete<Map<String, dynamic>>(
        'https://api.openai.com/v1/test',
        onCancel: (_) {},
        onSuccess: (data) => data,
      );
      expect(res['deleted'], true);
    });

    test('OpenAIClient post - success', () async {
      mockAdapter.handler = (options, _, __) async {
        expect(options.method, 'POST');
        return mockJSON({'id': '123'});
      };

      final res = await openAIClient.post<Map<String, dynamic>>(
        'https://api.openai.com/v1/test',
        {'input': 'hello'},
        onCancel: (_) {},
        onSuccess: (data) => data,
      );
      expect(res['id'], '123');
    });

    test('OpenAIClient postRawBody - success', () async {
      mockAdapter.handler = (options, _, __) async {
        expect(options.method, 'POST');
        return mockBytes([1, 2, 3]);
      };

      final res = await openAIClient.postRawBody<List<int>>(
        'https://api.openai.com/v1/test',
        {'response_format': 'mp3'},
        onSuccess: (bytes, format) async {
          expect(format, 'mp3');
          return bytes;
        },
        onCancel: (_) {},
      );
      expect(res, [1, 2, 3]);
    });

    test('OpenAIClient postStream - success', () async {
      mockAdapter.handler = (options, _, __) async {
        return mockJSON({'stream': true});
      };

      final stream = openAIClient.postStream(
        'https://api.openai.com/v1/test',
        {},
        onCancel: (_) {},
      );
      final res = await stream.first;
      expect(res.statusCode, 200);
    });

    test('OpenAIClient postFormData - success', () async {
      mockAdapter.handler = (options, _, __) async {
        expect(options.method, 'POST');
        return mockJSON({'file': 'uploaded'});
      };

      final res = await openAIClient.postFormData<Map<String, dynamic>>(
        'https://api.openai.com/v1/test',
        FormData(),
        complete: (data) => data,
        onCancel: (_) {},
      );
      expect(res['file'], 'uploaded');
    });

    test('OpenAIClient getStream - success', () async {
      mockAdapter.handler = (options, _, __) async {
        final data = 'data: {"value": 1}\n';
        return ResponseBody(
          Stream.value(Uint8List.fromList(utf8.encode(data))),
          200,
          headers: {
            Headers.contentTypeHeader: ['text/event-stream'],
          },
        );
      };

      final stream = openAIClient.getStream<Map<String, dynamic>>(
        'https://api.openai.com/v1/test',
        onCancel: (_) {},
        onSuccess: (data) => data,
      );
      final list = await stream.toList();
      expect(list.length, 1);
      expect(list[0]['value'], 1);
    });

    test('OpenAIClient sse - success and error handling', () async {
      mockAdapter.handler = (options, _, __) async {
        final data = 'data: {"value": "sse-ok"}\ndata: [DONE]\n';
        return ResponseBody(
          Stream.value(Uint8List.fromList(utf8.encode(data))),
          200,
          headers: {
            Headers.contentTypeHeader: ['text/event-stream'],
          },
        );
      };

      final stream = openAIClient.sse<Map<String, dynamic>>(
        'https://api.openai.com/v1/test',
        {},
        onCancel: (_) {},
        complete: (data) => data,
      );
      final res = await stream.first;
      expect(res['value'], 'sse-ok');
    });

    test('OpenAIClient handleError wrapping codes', () {
      final authErr = openAIClient.handleError(
        code: 401,
        message: 'Unauthorized',
        data: {
          'error': {'message': 'Key invalid'},
        },
      );
      expect(authErr, isA<OpenAIAuthError>());

      final rateErr = openAIClient.handleError(
        code: 429,
        message: 'Too Many Requests',
      );
      expect(rateErr, isA<OpenAIRateLimitError>());

      final rateErr2 = openAIClient.handleError(
        code: 400,
        message: 'Bad request',
        data: {
          'error': {'message': 'Billing hard limit has been reached'},
        },
      );
      expect(rateErr2, isA<OpenAIRateLimitError>());

      final serverErr = openAIClient.handleError(
        code: 500,
        message: 'Server down',
      );
      expect(serverErr, isA<OpenAIServerError>());
    });

    // Test Embedding API
    test('Embedding API - success', () async {
      mockAdapter.handler = (options, _, __) async {
        return mockJSON({
          'object': 'list',
          'data': [
            {
              'object': 'embedding',
              'embedding': [0.1, 0.2],
              'index': 0,
            },
          ],
          'model': 'text-embedding-ada-002',
          'usage': {'prompt_tokens': 8, 'total_tokens': 8},
        });
      };

      final embeddingWrapper = Embedding(openAIClient);
      final res = await embeddingWrapper.embedding(
        EmbedRequest(model: TextEmbeddingAda002EmbedModel(), input: 'hello'),
      );
      expect(res.model, 'text-embedding-ada-002');
      expect(res.data.first.embedding.length, 2);
    });

    // Test Audio API
    test('Audio API - transcribes, translate and speech', () async {
      mockAdapter.handler = (options, _, __) async {
        if (options.path.endsWith('/speech')) {
          return mockBytes([1, 2, 3]);
        }
        return mockJSON({'text': 'Hello World'});
      };

      final audioWrapper = Audio(openAIClient);
      final transcribeRes = await audioWrapper.transcribes(
        AudioRequest(file: FileInfo('path/to/file.mp3', 'file.mp3')),
      );
      expect(transcribeRes.text, 'Hello World');

      final translateRes = await audioWrapper.translate(
        AudioRequest(file: FileInfo('path/to/file.mp3', 'file.mp3')),
      );
      expect(translateRes.text, 'Hello World');

      final speechRes = await audioWrapper.createSpeech(
        request: SpeechRequest(model: 'tts-1', input: 'hello', voice: 'alloy'),
      );
      expect(speechRes, [1, 2, 3]);
    });

    // Test Assistants API
    test('Assistants API - operations', () async {
      mockAdapter.handler = (options, _, __) async {
        if (options.method == 'DELETE') {
          return mockJSON({
            'id': 'asst_123',
            'object': 'assistant.deleted',
            'deleted': true,
          });
        }
        if (options.method == 'GET' && options.path.endsWith('/assistants')) {
          return mockJSON({
            'data': [
              {'id': 'asst_123', 'object': 'assistant'},
            ],
          });
        }
        return mockJSON({
          'id': 'asst_123',
          'object': 'assistant',
          'name': 'My Assistant',
        });
      };

      final assistantsWrapper = Assistants(openAIClient);
      final createRes = await assistantsWrapper.create(
        assistant: Assistant(model: Gpt4AModel()),
      );
      expect(createRes.id, 'asst_123');

      final listRes = await assistantsWrapper.list();
      expect(listRes.first.id, 'asst_123');

      final retrieveRes = await assistantsWrapper.retrieves(
        assistantId: 'asst_123',
      );
      expect(retrieveRes.name, 'My Assistant');

      final modifyRes = await assistantsWrapper.modifies(
        assistantId: 'asst_123',
        assistant: Assistant(model: Gpt4AModel(), name: 'New Name'),
      );
      expect(modifyRes.id, 'asst_123');

      final deleteRes = await assistantsWrapper.delete(assistantId: 'asst_123');
      expect(deleteRes.deleted, true);
    });

    // Test Threads API
    test('Threads API - operations', () async {
      mockAdapter.handler = (options, _, __) async {
        if (options.method == 'DELETE') {
          return mockJSON({
            'id': 'thread_123',
            'object': 'thread.deleted',
            'deleted': true,
          });
        }
        return mockJSON({'id': 'thread_123', 'object': 'thread'});
      };

      final threadsWrapper = Threads(client: openAIClient);
      final createRes = await threadsWrapper.createThread(
        request: ThreadRequest(),
      );
      expect(createRes.id, 'thread_123');

      final retrieveRes = await threadsWrapper.retrieveThread(
        threadId: 'thread_123',
      );
      expect(retrieveRes.id, 'thread_123');

      final modifyRes = await threadsWrapper.modifyThread(
        threadId: 'thread_123',
        data: {'metadata': {}},
      );
      expect(modifyRes.id, 'thread_123');

      final deleteRes = await threadsWrapper.deleteThread(
        threadId: 'thread_123',
      );
      expect(deleteRes.deleted, true);
    });

    // Test Runs API
    test('Runs API - operations', () async {
      mockAdapter.handler = (options, _, __) async {
        if (options.method == 'GET' &&
            options.path.contains('/runs') &&
            options.path.contains('limit=')) {
          return mockJSON({
            'first_id': 'run_123',
            'last_id': 'run_123',
            'has_more': false,
            'object': 'list',
            'data': [
              {'id': 'run_123', 'object': 'thread.run'},
            ],
          });
        }
        return mockJSON({'id': 'run_123', 'object': 'thread.run'});
      };

      final runsWrapper = Runs(client: openAIClient, headers: {});
      final createRes = await runsWrapper.createRun(
        threadId: 'thread_123',
        request: CreateRun(assistantId: 'asst_123'),
      );
      expect(createRes.id, 'run_123');

      final createThreadRunRes = await runsWrapper.createThreadAndRun(
        request: CreateThreadAndRun(assistantId: 'asst_123'),
      );
      expect(createThreadRunRes.id, 'run_123');

      final listRes = await runsWrapper.listRuns(threadId: 'thread_123');
      expect(listRes.data.first.id, 'run_123');

      final listStepsRes = await runsWrapper.listRunSteps(
        threadId: 'thread_123',
        runId: 'run_123',
      );
      expect(listStepsRes.data.first.id, 'run_123');

      final retrieveRes = await runsWrapper.retrieveRun(
        threadId: 'thread_123',
        runId: 'run_123',
      );
      expect(retrieveRes.id, 'run_123');

      final retrieveStepRes = await runsWrapper.retrieveRunStep(
        threadId: 'thread_123',
        runId: 'run_123',
        stepId: 'step_123',
      );
      expect(retrieveStepRes.id, 'run_123');

      final modifyRes = await runsWrapper.modifyRun(
        threadId: 'thread_123',
        runId: 'run_123',
        metadata: {},
      );
      expect(modifyRes.id, 'run_123');

      final submitRes = await runsWrapper.submitToolOutputsToRun(
        threadId: 'thread_123',
        runId: 'run_123',
        toolOutputs: [],
      );
      expect(submitRes.id, 'run_123');

      final cancelRes = await runsWrapper.cancelRun(
        threadId: 'thread_123',
        runId: 'run_123',
      );
      expect(cancelRes.id, 'run_123');
    });

    // Test Messages API
    test('Messages API - operations', () async {
      mockAdapter.handler = (options, _, __) async {
        if (options.method == 'DELETE') {
          return mockJSON({
            'id': 'msg_123',
            'object': 'thread.message.deleted',
            'deleted': true,
          });
        }
        if (options.method == 'GET' && options.path.contains('/messages?')) {
          return mockJSON({
            'data': [
              {'id': 'msg_123', 'object': 'thread.message'},
            ],
          });
        }
        return mockJSON({'id': 'msg_123', 'object': 'thread.message'});
      };

      final messagesWrapper = api_msg.Messages(
        client: openAIClient,
        headers: {},
      );
      final createRes = await messagesWrapper.createMessage(
        threadId: 'thread_123',
        request: CreateMessage(role: 'user', content: 'hello'),
      );
      expect(createRes.id, 'msg_123');

      final listRes = await messagesWrapper.listMessage(threadId: 'thread_123');
      expect(listRes.data.first.id, 'msg_123');

      final retrieveRes = await messagesWrapper.retrieveMessage(
        threadId: 'thread_123',
        messageId: 'msg_123',
      );
      expect(retrieveRes.id, 'msg_123');

      final modifyRes = await messagesWrapper.modifyMessage(
        threadId: 'thread_123',
        messageId: 'msg_123',
        metadata: {},
      );
      expect(modifyRes.id, 'msg_123');

      final deleteRes = await messagesWrapper.deleteMessage(
        threadId: 'thread_123',
        messageId: 'msg_123',
      );
      expect(deleteRes.id, 'msg_123');
    });

    // Test OpenAIFile API
    test('OpenAIFile API - operations', () async {
      mockAdapter.handler = (options, _, __) async {
        if (options.method == 'DELETE') {
          return mockJSON({
            'id': 'file_123',
            'object': 'file',
            'deleted': true,
          });
        }
        if (options.path.endsWith('/content')) {
          return mockRaw('file content text');
        }
        if (options.method == 'GET' && options.path.endsWith('/files')) {
          return mockJSON({
            'object': 'list',
            'data': [
              {
                'id': 'file_123',
                'object': 'file',
                'bytes': 100,
                'created_at': 123456,
                'filename': 'test.json',
                'purpose': 'fine-tune',
              },
            ],
          });
        }
        return mockJSON({
          'id': 'file_123',
          'object': 'file',
          'bytes': 100,
          'created_at': 123456,
          'filename': 'test.json',
          'purpose': 'fine-tune',
        });
      };

      final fileWrapper = OpenAIFile(openAIClient);
      final listRes = await fileWrapper.get();
      expect(listRes.data.first.id, 'file_123');

      final uploadRes = await fileWrapper.uploadFile(
        UploadFile(
          file: FileInfo('path/to/file.json', 'file.json'),
          purpose: 'fine-tune',
        ),
      );
      expect(uploadRes.id, 'file_123');

      final retrieveRes = await fileWrapper.retrieve('file_123');
      expect(retrieveRes.filename, 'test.json');

      final contentRes = await fileWrapper.retrieveContent('file_123');
      expect(contentRes, 'file content text');

      final deleteRes = await fileWrapper.delete('file_123');
      expect(deleteRes.deleted, true);
    });

    // Test FineTuned API
    test('FineTuned API - operations', () async {
      mockAdapter.handler = (options, _, __) async {
        if (options.path.endsWith('/events')) {
          final sseData =
              'data: {"data": [{"training_file": "file_123", "result_files": [], "finished_at": 123456, "fine_tuned_model": "babbage-002", "created_at": 123456, "organization_id": "org_123", "hyperparameters": {"n_epochs": 3}, "model": "babbage-002", "id": "ft-job-123", "trained_tokens": 100, "object": "fine_tuning.job", "status": "pending"}]}\ndata: [DONE]\n';
          return ResponseBody(
            Stream.value(Uint8List.fromList(utf8.encode(sseData))),
            200,
            headers: {
              Headers.contentTypeHeader: ['text/event-stream'],
            },
          );
        }
        if (options.method == 'GET' && options.path.endsWith('/fine-tunes')) {
          return mockJSON({
            'data': [
              {
                'training_file': 'file_123',
                'result_files': [],
                'finished_at': 123456,
                'fine_tuned_model': 'babbage-002',
                'created_at': 123456,
                'organization_id': 'org_123',
                'hyperparameters': {'n_epochs': 3},
                'model': 'babbage-002',
                'id': 'ft-job-123',
                'trained_tokens': 100,
                'object': 'fine_tuning.job',
                'status': 'pending',
              },
            ],
          });
        }
        if (options.method == 'POST' &&
            (options.path.endsWith('/jobs') ||
                options.path.endsWith('/jobs/'))) {
          // FineTuneModelJob
          return mockJSON({
            'training_file': 'file_123',
            'result_files': [],
            'organization_id': 'org_123',
            'created_at': 123456,
            'model': 'babbage-002',
            'id': 'ft-job-123',
            'object': 'fine_tuning.job',
            'status': 'pending',
          });
        }
        // FineTuneList
        return mockJSON({
          'training_file': 'file_123',
          'result_files': [],
          'finished_at': 123456,
          'fine_tuned_model': 'babbage-002',
          'created_at': 123456,
          'organization_id': 'org_123',
          'hyperparameters': {'n_epochs': 3},
          'model': 'babbage-002',
          'id': 'ft-job-123',
          'trained_tokens': 100,
          'object': 'fine_tuning.job',
          'status': 'pending',
        });
      };

      final fineTuneWrapper = FineTuned(openAIClient);
      final createRes = await fineTuneWrapper.createFineTuneJob(
        CreateFineTuneJob(
          model: Babbage002FineModel(),
          trainingFile: 'file_123',
        ),
      );
      expect(createRes.id, 'ft-job-123');

      final retrieveRes = await fineTuneWrapper.retrieveFineTuneJob(
        'ft-job-123',
      );
      expect(retrieveRes.id, 'ft-job-123');

      final listRes = await fineTuneWrapper.listFineTuneJob();
      expect(listRes.first.id, 'ft-job-123');

      final cancelRes = await fineTuneWrapper.cancelFineTuneJob('ft-job-123');
      expect(cancelRes.id, 'ft-job-123');

      final stream = fineTuneWrapper.listFineTuneJobStream('ft-job-123');
      final streamList = await stream.toList();
      expect(streamList.length, 1);
      expect(streamList.first.first.id, 'ft-job-123');
    });
  });
}

import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/audio.dart';
import 'package:chat_gpt_sdk/src/edit.dart';
import 'package:chat_gpt_sdk/src/embedding.dart';
import 'package:chat_gpt_sdk/src/fine_tuned.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_choice_sse.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/usage.dart';
import 'package:chat_gpt_sdk/src/model/edits/enum/edit_model.dart';
import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/enum/fine_model.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/request/create_fine_tune_job.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/response/image_data.dart';
import 'package:chat_gpt_sdk/src/model/moderation/enum/moderation_model.dart';
import 'package:chat_gpt_sdk/src/model/openai_engine/engine_data.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/model_data.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/permission.dart';
import 'package:chat_gpt_sdk/src/moderation.dart';
import 'package:chat_gpt_sdk/src/openai_file.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'openai_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<OpenAI>(),
  MockSpec<Audio>(),
  MockSpec<Edit>(),
  MockSpec<Embedding>(),
  MockSpec<FineTuned>(),
  MockSpec<Moderation>(),
  MockSpec<OpenAIFile>(),
])
void main() async {
  final openAI = MockOpenAI();
  final audio = MockAudio();
  final edit = MockEdit();
  final embedding = MockEmbedding();
  // final fineTurned = MockFineTuned();

  test('description', () {
    final ai = OpenAI.instance.build(token: 'token');

    final request = ChatCompleteText(
      messages: [
        Messages(
          role: Role.user,
          content: "Hello",
        ).toJson(),
      ],
      maxToken: 200,
      model: Gpt4ChatModel(),
    );

    ai.setToken('token');

    expect(ai.token, isA<String>());
    expect(() => ai.onChatCompletion(request: request), throwsException);
    expect(
      () => ai.onCompletion(
        request: CompleteText(
          prompt: "",
          maxTokens: 200,
          model: Gpt3TurboInstruct(),
        ),
      ),
      throwsException,
    );
    expect(
      () => ai.generateImage(GenerateImage(
        'prompt',
        model: DallE3(),
        1,
        size: ImageSize.size256,
        responseFormat: Format.url,
      )),
      throwsException,
    );
    expect(
      () => ai.editor.prompt(EditRequest(
        model: Gpt4(),
        input: 'input',
        instruction: 'instruction',
      )),
      throwsException,
    );
    expect(
      () => ai.editor.editImage(EditImageRequest(
        image: FileInfo('path', 'name'),
        prompt: 'prompt',
      )),
      throwsException,
    );
    expect(
      () => ai.editor.variation(
        Variation(image: FileInfo('path', 'name'), user: 'prompt'),
      ),
      throwsException,
    );
    expect(
      () => ai.moderation
          .create(input: 'input', model: TextLastModerationModel()),
      throwsException,
    );
    expect(
      () => ai.fineTune.createFineTuneJob(CreateFineTuneJob(
        trainingFile: 'trainingFile',
        model: Babbage002FineModel(),
      )),
      throwsException,
    );
    expect(() => ai.fineTune.cancelFineTuneJob('id'), throwsException);
    // expect(() => ai.fineTune.delete('id'), throwsException);
    expect(() => ai.fineTune.retrieveFineTuneJob('id'), throwsException);
    expect(() => ai.fineTune.listFineTuneJob(), throwsException);
    ai.fineTune.listFineTuneJobStream('fineTuneId').transform(
      StreamTransformer.fromHandlers(handleError: (error, stackTrace, sink) {
        expect(error, throwsException);
      }),
    );
    ai.fineTune
        .listFineTuneJobStream(
      'fineTuneId',
      limit: 10,
    )
        .transform(
      StreamTransformer.fromHandlers(handleError: (error, stackTrace, sink) {
        expect(error, throwsException);
      }),
    );
    expect(() => ai.file.get(), throwsException);
    expect(() => ai.file.retrieve('fileId'), throwsException);
    expect(() => ai.file.delete('fileId'), throwsException);
    expect(() => ai.file.retrieveContent('fileId'), throwsException);
    expect(
      () => ai.file.uploadFile(UploadFile(file: FileInfo('path', 'name'))),
      throwsException,
    );
    expect(
      () => ai.audio.translate(AudioRequest(file: FileInfo('path', 'name'))),
      throwsException,
    );
    expect(
      () => ai.audio.transcribes(AudioRequest(file: FileInfo('path', 'name'))),
      throwsException,
    );
    expect(
      () => ai.embed.embedding(EmbedRequest(
        model: TextEmbeddingAda002EmbedModel(),
        input: 'input',
      )),
      throwsException,
    );
    expect(() => ai.listEngine(), throwsException);
    expect(() => ai.listModel(), throwsException);
    ai.onChatCompletionSSE(request: request).transform(
      StreamTransformer.fromHandlers(handleError: (error, stackTrace, sink) {
        expect(error, throwsException);
      }),
    );
    ai
        .onCompletionSSE(
      request: CompleteText(
        prompt: "",
        maxTokens: 200,
        model: Gpt3TurboInstruct(),
      ),
    )
        .transform(StreamTransformer.fromHandlers(
      handleError: (error, stackTrace, sink) {
        expect(error, throwsException);
      },
    ));
  });

  group('chatGPT-3 text completion test', () {
    test('text completion use success case', () {
      final request = CompleteText(prompt: 'snake', model: Gpt3TurboInstruct());
      final choice = [
        Choices(
          '',
          1,
          '',
        ),
      ];

      when(openAI.onCompletion(request: request)).thenAnswer(
        (inv) async =>
            CompleteResponse('id', 'object', 1, 'model', choice, null),
      );
      openAI.onCompletion(request: request);

      verify(openAI.onCompletion(request: request));
    });
    test('text completion use cancel success case', () {
      final request = CompleteText(prompt: 'snake', model: Gpt3TurboInstruct());
      final choice = [
        Choices(
          '',
          1,
          '',
        ),
      ];

      when(openAI.onCompletion(request: request)).thenAnswer(
        (inv) async =>
            CompleteResponse('id', 'object', 1, 'model', choice, null),
      );

      openAI.onCompletion(
        request: request,
        onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        },
      );
    });

    test('text completion success case with return result', () async {
      final request = CompleteText(prompt: 'snake', model: Gpt3TurboInstruct());
      final choice = [
        Choices(
          '',
          1,
          '',
        ),
      ];

      when(openAI.onCompletion(request: request)).thenAnswer(
        (inv) async =>
            CompleteResponse('id', 'object', 1, 'model', choice, null),
      );

      final response = await openAI.onCompletion(request: request);

      expect(response?.object, 'object');
      expect(response?.id, 'id');
      expect(response?.model, 'model');
      expect(response!, const TypeMatcher<CompleteResponse>());
    });

    test('text completion error case with prompt empty', () async {
      final request = CompleteText(prompt: '', model: Gpt3TurboInstruct());
      when(openAI.onCompletion(request: request))
          .thenAnswer((_) => throw RequestError(data: null, code: 404));
      verifyNever(openAI.onCompletion(request: request));
    });
  });

  group('chatGPT-3 text completion with stream SSE test', () {
    test('text completion stream case success', () {
      final request =
          CompleteText(prompt: 'snake is ?', model: Babbage002Model());
      final choice = [
        Choices(
          '',
          1,
          '',
        ),
      ];

      when(openAI.onCompletionSSE(request: request))
          .thenAnswer((_) => Stream.value(
                CompleteResponse('id', 'object', 1, 'model', choice, null),
              ));

      final response = openAI.onCompletionSSE(request: request);

      verify(openAI.onCompletionSSE(request: request));
      expect(response, const TypeMatcher<Stream<CompleteResponse>>());
    });
    test('text completion stream case cancel success', () {
      final request =
          CompleteText(prompt: 'snake is ?', model: Babbage002Model());
      final choice = [
        Choices(
          '',
          1,
          '',
        ),
      ];

      when(openAI.onCompletionSSE(request: request))
          .thenAnswer((_) => Stream.value(
                CompleteResponse('id', 'object', 1, 'model', choice, null),
              ));

      openAI.onCompletionSSE(
        request: request,
        onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        },
      );
    });

    test('text completion stream case error', () async {
      final request = CompleteText(prompt: '', model: Babbage002Model());

      when(openAI.onCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError(data: null, code: 404));

      verifyNever(openAI.onCompletionSSE(request: request));
    });
  });

  group('chatGPT-3.5 turbo chat completion test', () {
    test('chat completion success case test', () async {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: GptTurboChatModel(),
      );
      final choice = [ChatChoice(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletion(request: request))
          .thenAnswer((_) async => ChatCTResponse(
                id: 'id',
                object: 'object',
                created: 1,
                choices: choice,
                usage: null,
                systemFingerprint: '',
                model: '',
              ));

      final response = await openAI.onChatCompletion(request: request);
      verify(openAI.onChatCompletion(request: request));
      expect(response?.object, 'object');
      expect(response?.id, 'id');
    });
    test('chat completion cancel success case test', () {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: GptTurboChatModel(),
      );
      final choice = [ChatChoice(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletion(request: request))
          .thenAnswer((_) async => ChatCTResponse(
                id: 'id',
                object: 'object',
                created: 1,
                choices: choice,
                usage: null,
                systemFingerprint: '',
                model: '',
              ));

      openAI.onChatCompletion(
        request: request,
        onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        },
      );
    });

    test(
      'chat completion error case with content null return error test',
      () {
        final request = ChatCompleteText(
          messages: [
            Messages(
              role: Role.user,
              content: "Hello",
            ).toJson(),
          ],
          maxToken: 200,
          model: GptTurbo0301ChatModel(),
        );

        when(openAI.onChatCompletion(request: request))
            .thenAnswer((_) => throw RequestError(data: null, code: 404));

        verifyNever(openAI.onChatCompletion(request: request));
      },
    );
  });

  group('chatGPT-4 chat completion test', () {
    test('chat completion success case test', () async {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: Gpt4ChatModel(),
      );
      final choice = [ChatChoice(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletion(request: request))
          .thenAnswer((_) async => ChatCTResponse(
                id: 'id',
                object: 'object',
                created: 1,
                choices: choice,
                usage: null,
                systemFingerprint: '',
                model: '',
              ));

      final response = await openAI.onChatCompletion(request: request);
      verify(openAI.onChatCompletion(request: request));
      expect(response?.object, 'object');
      expect(response?.id, 'id');
    });
    test('chat completion cancel success case test', () {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: Gpt4ChatModel(),
      );
      final choice = [ChatChoice(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletion(request: request))
          .thenAnswer((_) async => ChatCTResponse(
                id: 'id',
                object: 'object',
                created: 1,
                choices: choice,
                usage: null,
                systemFingerprint: '',
                model: '',
              ));

      openAI.onChatCompletion(
        request: request,
        onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        },
      );
    });

    test(
      'chat completion error case with content null return error test',
      () {
        final request = ChatCompleteText(
          messages: [
            Messages(
              role: Role.user,
              content: "Hello",
            ).toJson(),
          ],
          maxToken: 200,
          model: Gpt4ChatModel(),
        );

        when(openAI.onChatCompletion(request: request))
            .thenAnswer((_) => throw RequestError(data: null, code: 404));

        verifyNever(openAI.onChatCompletion(request: request));
      },
    );
  });

  group('chatGPT-3.5 turbo chat completion with stream SSE test', () {
    test('openAI chat completion stream success case test', () async {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: GptTurboChatModel(),
      );
      final choice = [ChatChoiceSSE(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletionSSE(request: request)).thenAnswer(
        (realInvocation) => Stream.value(ChatResponseSSE(
          id: 'id',
          object: 'object',
          created: 1,
          choices: choice,
          usage: null,
        )),
      );

      final response = await openAI.onChatCompletionSSE(request: request).first;
      verify(openAI.onChatCompletionSSE(request: request));
      expect(response.id, 'id');
      expect(response.object, 'object');
      expect(response, const TypeMatcher<ChatResponseSSE>());
    });
    test('openAI chat completion stream cancel success case test', () {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: GptTurboChatModel(),
      );
      final choice = [ChatChoiceSSE(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletionSSE(request: request)).thenAnswer(
        (realInvocation) => Stream.value(ChatResponseSSE(
          id: 'id',
          object: 'object',
          created: 1,
          choices: choice,
          usage: null,
        )),
      );

      openAI.onChatCompletionSSE(
        request: request,
        onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        },
      );
    });

    test('openAI chat completion stream error case test', () async {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: GptTurbo0301ChatModel(),
      );

      when(openAI.onChatCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError());
      verifyNever(openAI.onChatCompletionSSE(request: request));
    });
  });

  group('chatGPT-4 chat completion with stream SSE test', () {
    test('openAI chat completion stream success case test', () async {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: Gpt4ChatModel(),
      );
      final choice = [ChatChoiceSSE(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletionSSE(request: request)).thenAnswer(
        (realInvocation) => Stream.value(ChatResponseSSE(
          id: 'id',
          object: 'object',
          created: 1,
          choices: choice,
          usage: null,
        )),
      );

      final response = await openAI.onChatCompletionSSE(request: request).first;
      verify(openAI.onChatCompletionSSE(request: request));
      expect(response.id, 'id');
      expect(response.object, 'object');
      expect(response, const TypeMatcher<ChatResponseSSE>());
    });
    test('openAI chat completion stream cancel success case test', () {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: Gpt4ChatModel(),
      );
      final choice = [ChatChoiceSSE(message: null, index: 1, finishReason: '')];

      when(openAI.onChatCompletionSSE(request: request)).thenAnswer(
        (realInvocation) => Stream.value(ChatResponseSSE(
          id: 'id',
          object: 'object',
          created: 1,
          choices: choice,
          usage: null,
        )),
      );

      openAI.onChatCompletionSSE(
        request: request,
        onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        },
      );
    });

    test('openAI chat completion stream error case test', () async {
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: "Hello",
          ).toJson(),
        ],
        maxToken: 200,
        model: Gpt4ChatModel(),
      );

      when(openAI.onChatCompletionSSE(request: request))
          .thenAnswer((_) => throw RequestError());
      verifyNever(openAI.onChatCompletionSSE(request: request));
    });
  });

  group('chatGPT Image Generate With Prompt test case', () {
    test('chatGPT Image Generate With Prompt success case  test', () async {
      final request =
          GenerateImage('snake red eating cat.', model: DallE3(), 2);

      when(openAI.generateImage(request))
          .thenAnswer((_) async => GenImgResponse());

      final response = await openAI.generateImage(request);

      verify(await openAI.generateImage(request));
      expect(response, const TypeMatcher<GenImgResponse>());
    });

    test(
      'chatGPT Image Generate With Prompt success case return value test',
      () async {
        final request =
            GenerateImage('snake red eating cat.', model: DallE3(), 2);

        when(openAI.generateImage(request))
            .thenAnswer((_) async => GenImgResponse(created: 1221120));

        final response = await openAI.generateImage(request);

        verify(await openAI.generateImage(request));
        expect(response, const TypeMatcher<GenImgResponse>());
        expect(response?.created, 1221120);
      },
    );

    test(
      'chatGPT Image Generate With Prompt error case with n is 0 test',
      () async {
        final request =
            GenerateImage('snake red eating cat.', model: DallE3(), 1);

        when(openAI.generateImage(request))
            .thenAnswer((_) async => GenImgResponse(created: 1221120));

        final response = await openAI.generateImage(request);

        verify(await openAI.generateImage(request));
        expect(response, const TypeMatcher<GenImgResponse>());
        expect(response?.created, 1221120);
        expect(response?.data, null);
        expect(
          () => GenerateImage('snake red eating cat.', model: DallE3(), 0),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });

  group('chatGPT Models & Engine test', () {
    test('chatGPT Models success case test', () async {
      when(openAI.listModel()).thenAnswer((_) async => OpenAiModel(
            [
              ModelData('id', '', 'ownerBy', [
                Permission(
                  'id',
                  'object',
                  12,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  'organization',
                  false,
                ),
              ]),
            ],
            '12',
          ));

      final response = await openAI.listModel();
      expect(response, const TypeMatcher<OpenAiModel>());
      verify(await openAI.listModel());
      expect(response.object, '12');
    });
    test('chatGPT Models cancel success case test', () {
      when(openAI.listModel()).thenAnswer((_) async => OpenAiModel(
            [
              ModelData('id', '', 'ownerBy', [
                Permission(
                  'id',
                  'object',
                  12,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  'organization',
                  false,
                ),
              ]),
            ],
            '12',
          ));

      openAI.listModel(onCancel: (c) {
        c.cancelToken.cancel();
        expect(c.cancelToken.isCancelled, true);
      });
    });

    test('chatGPT Engine success case test', () async {
      when(openAI.listEngine()).thenAnswer((_) async =>
          EngineModel([EngineData('id', 'object', 'owner', false)], 'object'));

      final response = await openAI.listEngine();

      verify(openAI.listEngine());
      expect(response.object, 'object');
    });
    test('chatGPT Engine camcel success case test', () {
      when(openAI.listEngine()).thenAnswer((_) async =>
          EngineModel([EngineData('id', 'object', 'owner', false)], 'object'));

      openAI.listEngine(onCancel: (c) {
        c.cancelToken.cancel();
        expect(c.cancelToken.isCancelled, true);
      });
    });
  });

  group('chatGPT Image Generate test', () {
    test(
      'chatGPT Image Generate with success case',
      () async {
        final request = GenerateImage('cat eating snake', model: DallE3(), 1);

        when(openAI.generateImage(request))
            .thenAnswer((realInvocation) async => GenImgResponse(
                  created: 912312,
                  data: [ImageData(url: "image_url")],
                ));

        final mResponse = await openAI.generateImage(request);

        verify(await openAI.generateImage(request));
        expect(mResponse?.created, 912312);
        expect(mResponse?.data?.length, 1);
        expect(mResponse?.data?.last?.url, "image_url");
      },
    );
    test(
      'chatGPT Image Generate with cancel gen success case',
      () {
        final request = GenerateImage('cat eating snake', model: DallE3(), 1);

        when(openAI.generateImage(request))
            .thenAnswer((realInvocation) async => GenImgResponse(
                  created: 912312,
                  data: [ImageData(url: "image_url")],
                ));

        openAI.generateImage(request, onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        });
      },
    );
    test(
      'chatGPT Image Generate with return two image success case',
      () async {
        final request = GenerateImage('cat eating snake', model: DallE3(), 2);

        when(openAI.generateImage(request)).thenAnswer(
          (realInvocation) async => GenImgResponse(created: 912312, data: [
            ImageData(url: "image_url1"),
            ImageData(url: "image_url2"),
          ]),
        );

        final mResponse = await openAI.generateImage(request);

        verify(await openAI.generateImage(request));
        expect(mResponse?.created, 912312);
        expect(mResponse?.data?.length, 2);
        expect(mResponse?.data?.last?.url, "image_url2");
      },
    );
    test(
      'chatGPT Image Generate with error case',
      () async {
        final request = GenerateImage('', model: DallE3(), 1);

        when(openAI.generateImage(request))
            .thenAnswer((realInvocation) async => GenImgResponse(
                  created: 912312,
                ));

        final mResponse = await openAI.generateImage(request);

        verify(await openAI.generateImage(request));
        expect(mResponse?.created, 912312);
        expect(mResponse?.data, null);
      },
    );
    test(
      'chatGPT Image Generate with openai auth error case',
      () async {
        final request = GenerateImage('snake', model: DallE3(), 1);

        when(openAI.generateImage(request))
            .thenThrow(OpenAIAuthError(code: 404));

        verifyNever(await openAI.generateImage(request));
        expect(
          () => openAI.generateImage(request),
          throwsA(isA<OpenAIAuthError>()),
        );
        expect(
          () => openAI.generateImage(request),
          throwsA(
            predicate((err) => err is OpenAIAuthError && err.code == 404),
          ),
        );
      },
    );
  });

  group('chatGPT audio test', () {
    test('ChatGPT audio transcribes test with success case', () {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.transcribes(request))
          .thenAnswer((realInvocation) async => AudioResponse("text"));

      audio.transcribes(request).then((it) {
        expect(it, isA<AudioResponse>());
        expect(it.text, "text");
      });
    });
    test('ChatGPT audio transcribes test cancel with success case', () {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.transcribes(request))
          .thenAnswer((realInvocation) async => AudioResponse("text"));

      audio.transcribes(request, onCancel: (c) {
        c.cancelToken.cancel();
        expect(c.cancelToken.isCancelled, true);
      });
    });
    test(
      'ChatGPT audio transcribes test with unauthenticated error case',
      () async {
        final request = AudioRequest(file: FileInfo("path", "name"));
        when(audio.transcribes(request)).thenThrow(OpenAIAuthError());

        verifyNever(await audio.transcribes(request));
        expect(
          () => audio.transcribes(request),
          throwsA(isA<OpenAIAuthError>()),
        );
      },
    );
    test('ChatGPT audio transcribes test with rate limit error case', () async {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.transcribes(request)).thenThrow(OpenAIRateLimitError());

      verifyNever(await audio.transcribes(request));
      expect(
        () => audio.transcribes(request),
        throwsA(isA<OpenAIRateLimitError>()),
      );
    });
    test('ChatGPT audio transcribes test with rate limit error case', () async {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.transcribes(request)).thenThrow(OpenAIServerError());

      verifyNever(await audio.transcribes(request));
      expect(
        () => audio.transcribes(request),
        throwsA(isA<OpenAIServerError>()),
      );
    });

    test('ChatGPT audio translate test cancel with success case', () {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.translate(request))
          .thenAnswer((realInvocation) async => AudioResponse("text"));

      audio.translate(request, onCancel: (c) {
        c.cancelToken.cancel();
        expect(c.cancelToken.isCancelled, true);
      });
    });
    test('ChatGPT audio translate test with success case', () {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.translate(request))
          .thenAnswer((realInvocation) async => AudioResponse("text"));

      audio.translate(request).then((it) {
        expect(it, isA<AudioResponse>());
        expect(it.text, "text");
      });
    });
    test(
      'ChatGPT audio translate test with unauthenticated error case',
      () async {
        final request = AudioRequest(file: FileInfo("path", "name"));
        when(audio.translate(request)).thenThrow(OpenAIAuthError());

        verifyNever(await audio.translate(request));
        expect(() => audio.translate(request), throwsA(isA<OpenAIAuthError>()));
      },
    );
    test('ChatGPT audio translate test with rate limit error case', () async {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.translate(request)).thenThrow(OpenAIRateLimitError());

      verifyNever(await audio.translate(request));
      expect(
        () => audio.translate(request),
        throwsA(isA<OpenAIRateLimitError>()),
      );
    });
    test('ChatGPT audio translate test with rate limit error case', () async {
      final request = AudioRequest(file: FileInfo("path", "name"));
      when(audio.translate(request)).thenThrow(OpenAIServerError());

      verifyNever(await audio.translate(request));
      expect(() => audio.translate(request), throwsA(isA<OpenAIServerError>()));
    });
  });

  group('chatGPT edit test', () {
    test('chatGPT Edit image test with success case', () {
      final request = EditImageRequest(
        image: FileInfo("path", "name"),
        prompt: "fix color",
      );
      when(edit.editImage(request)).thenAnswer((realInvocation) async =>
          GenImgResponse(created: 123, data: [ImageData(url: "url")]));

      edit.editImage(request).then((it) {
        expect(it.data?.length, 1);
        expect(it.data?.last?.url, 'url');
      });
    });
    test('chatGPT Edit image test cancel with success case', () {
      final request = EditImageRequest(
        image: FileInfo("path", "name"),
        prompt: "fix color",
      );
      when(edit.editImage(request)).thenAnswer((realInvocation) async =>
          GenImgResponse(created: 123, data: [ImageData(url: "url")]));

      edit.editImage(request, onCancel: (c) {
        c.cancelToken.cancel();
        expect(c.cancelToken.isCancelled, true);
      });
    });
    test('ChatGPT Edit image test with unauthenticated error case', () async {
      final request =
          EditImageRequest(image: FileInfo("path", "name"), prompt: "fix body");
      when(edit.editImage(request)).thenThrow(OpenAIAuthError());

      verifyNever(await edit.editImage(request));
      expect(() => edit.editImage(request), throwsA(isA<OpenAIAuthError>()));
    });
    test('ChatGPT Edit image test with rate limit error case', () async {
      final request = EditImageRequest(
        image: FileInfo("path", "name"),
        prompt: "fix color body",
      );
      when(edit.editImage(request)).thenThrow(OpenAIRateLimitError());

      verifyNever(await edit.editImage(request));
      expect(
        () => edit.editImage(request),
        throwsA(isA<OpenAIRateLimitError>()),
      );
    });
    test('ChatGPT Edit image test with rate limit error case', () async {
      final request =
          EditImageRequest(image: FileInfo("path", "name"), prompt: "fix");
      when(edit.editImage(request)).thenThrow(OpenAIServerError());

      verifyNever(await edit.editImage(request));
      expect(() => edit.editImage(request), throwsA(isA<OpenAIServerError>()));
    });

    test('chatGPT Edit prompt test with success case', () {
      final request = EditRequest(
        input: "snake",
        instruction: "",
        model: Gpt4(),
      );
      final choice = [
        Choice(index: 1, text: "text"),
      ];
      final usage = Usage(1, 2, 3);

      when(edit.prompt(request))
          .thenAnswer((realInvocation) async => EditResponse(
                object: 'object',
                created: 1,
                choices: choice,
                usage: usage,
              ));

      edit.prompt(request).then((it) {
        expect(it.choices.length, 1);
        expect(it.object, 'object');
      });
    });
    test('chatGPT Edit prompt test cancel with success case', () {
      final request = EditRequest(
        input: "snake",
        instruction: "",
        model: Gpt4(),
      );
      final choice = [
        Choice(index: 1, text: "text"),
      ];
      final usage = Usage(1, 2, 3);

      when(edit.prompt(request))
          .thenAnswer((realInvocation) async => EditResponse(
                object: 'object',
                created: 1,
                choices: choice,
                usage: usage,
              ));

      edit.prompt(
        request,
        onCancel: (c) {
          c.cancelToken.cancel();
          expect(c.cancelToken.isCancelled, true);
        },
      );
    });
    test('ChatGPT Edit prompt test with unauthenticated error case', () async {
      final request = EditRequest(
        input: "snake",
        instruction: "",
        model: Gpt4(),
      );
      when(edit.prompt(request)).thenThrow(OpenAIAuthError());

      verifyNever(await edit.prompt(request));
      expect(() => edit.prompt(request), throwsA(isA<OpenAIAuthError>()));
    });
    test('ChatGPT Edit prompt test with rate limit error case', () async {
      final request = EditRequest(
        input: "snake",
        instruction: "",
        model: Gpt4(),
      );
      when(edit.prompt(request)).thenThrow(OpenAIRateLimitError());

      verifyNever(await edit.prompt(request));
      expect(() => edit.prompt(request), throwsA(isA<OpenAIRateLimitError>()));
    });
    test('ChatGPT Edit prompt test with rate limit error case', () async {
      final request = EditRequest(
        input: "snake",
        instruction: "",
        model: Gpt4(),
      );
      when(edit.prompt(request)).thenThrow(OpenAIServerError());

      verifyNever(await edit.prompt(request));
      expect(() => edit.prompt(request), throwsA(isA<OpenAIServerError>()));
    });

    test('chatGPT edit variation test with success case', () {
      final request = Variation(image: FileInfo("path file", 'file name'));
      when(edit.variation(request)).thenAnswer((realInvocation) async =>
          GenImgResponse(created: 1, data: [ImageData(url: "image url")]));

      edit.variation(request).then((it) {
        expect(it.data?.length, 1);
        expect(it.created, 1);
      });
    });
    test('chatGPT edit variation test cancel with success case', () {
      final request = Variation(image: FileInfo("path file", 'file name'));
      when(edit.variation(request)).thenAnswer((realInvocation) async =>
          GenImgResponse(created: 1, data: [ImageData(url: "image url")]));

      edit.variation(
        request,
        onCancel: (c) {
          c.cancelToken.cancel();

          expect(c.cancelToken.isCancelled, true);
        },
      );
    });
    test('ChatGPT Edit prompt test with unauthenticated error case', () async {
      final request = Variation(image: FileInfo("path file", 'file name'));
      when(edit.variation(request)).thenThrow(OpenAIAuthError());

      verifyNever(await edit.variation(request));
      expect(() => edit.variation(request), throwsA(isA<OpenAIAuthError>()));
    });
    test('ChatGPT Edit prompt test with rate limit error case', () async {
      final request = Variation(image: FileInfo("path file", 'file name'));
      when(edit.variation(request)).thenThrow(OpenAIRateLimitError());

      verifyNever(await edit.variation(request));
      expect(
        () => edit.variation(request),
        throwsA(isA<OpenAIRateLimitError>()),
      );
    });
    test('ChatGPT Edit prompt test with rate limit error case', () async {
      final request = Variation(image: FileInfo("path file", 'file name'));
      when(edit.variation(request)).thenThrow(OpenAIServerError());

      verifyNever(await edit.variation(request));
      expect(() => edit.variation(request), throwsA(isA<OpenAIServerError>()));
    });
  });

  group('chatGPT embedding test', () {
    test('chatGPT embedding test with success case', () async {
      final request =
          EmbedRequest(model: TextEmbeddingAda002EmbedModel(), input: 'input');
      final usage = Usage(1, 2, 3);

      when(embedding.embedding(request))
          .thenAnswer((realInvocation) async => EmbedResponse(
                object: 'object',
                data: [],
                model: 'model',
                usage: usage,
              ));

      final response = await embedding.embedding(request);
      verify(embedding.embedding(request));

      expect(response, isA<EmbedResponse>());
      expect(response.object, 'object');
      expect(response.data.isEmpty, true);
      expect(response.model, 'model');
    });
    test('chatGPT embedding test with cancel success case', () {
      final request =
          EmbedRequest(model: TextEmbeddingAda002EmbedModel(), input: 'input');
      final usage = Usage(1, 2, 3);

      when(embedding.embedding(request))
          .thenAnswer((realInvocation) async => EmbedResponse(
                object: 'object',
                data: [],
                model: 'model',
                usage: usage,
              ));

      embedding.embedding(request, onCancel: (c) {
        c.cancelToken.cancel();
        expect(c.cancelToken.isCancelled, true);
      });
    });

    test('ChatGPT Edit prompt test with unauthenticated error case', () {
      final request =
          EmbedRequest(model: TextEmbeddingAda002EmbedModel(), input: 'input');
      when(embedding.embedding(request)).thenThrow(OpenAIAuthError());

      verifyNever(embedding.embedding(request));
      expect(
        () => embedding.embedding(request),
        throwsA(isA<OpenAIAuthError>()),
      );
    });
    test('ChatGPT Edit prompt test with rate limit error case', () {
      final request =
          EmbedRequest(model: TextEmbeddingAda002EmbedModel(), input: 'input');
      when(embedding.embedding(request)).thenThrow(OpenAIRateLimitError());

      verifyNever(embedding.embedding(request));
      expect(
        () => embedding.embedding(request),
        throwsA(isA<OpenAIRateLimitError>()),
      );
    });
    test('ChatGPT Edit prompt test with rate limit error case', () {
      final request =
          EmbedRequest(model: TextEmbeddingAda002EmbedModel(), input: 'input');
      when(embedding.embedding(request)).thenThrow(OpenAIServerError());

      verifyNever(embedding.embedding(request));
      expect(
        () => embedding.embedding(request),
        throwsA(isA<OpenAIServerError>()),
      );
    });
  });
}

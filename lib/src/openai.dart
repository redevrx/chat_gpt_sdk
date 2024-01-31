import 'dart:async';
import 'dart:io';
import 'package:chat_gpt_sdk/src/assistants.dart';
import 'package:chat_gpt_sdk/src/audio.dart';
import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:chat_gpt_sdk/src/client/exception/missing_token_exception.dart';
import 'package:chat_gpt_sdk/src/embedding.dart';
import 'package:chat_gpt_sdk/src/openai_file.dart';
import 'package:chat_gpt_sdk/src/fine_tuned.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/chat_complete_text.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_ct_response.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/chat_response_sse.dart';
import 'package:chat_gpt_sdk/src/model/client/http_setup.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/request/complete_text.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/complete_response.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/generate_image.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/response/gen_img_response.dart';
import 'package:chat_gpt_sdk/src/model/openai_engine/engine_model.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/openai_model.dart';
import 'package:chat_gpt_sdk/src/moderation.dart';
import 'package:chat_gpt_sdk/src/threads.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:chat_gpt_sdk/src/utils/token_builder.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'client/interceptor/interceptor_wrapper.dart';
import 'edit.dart';
import 'i_openai.dart';
import 'model/cancel/cancel_data.dart';

//const msgDeprecate = "not support in version 2.0.6";

class OpenAI implements IOpenAI {
  OpenAI._();

  ///instance of openai [instance]
  static OpenAI instance = OpenAI._();

  late OpenAIClient _client;

  /// set new token
  void setToken(String token) {
    TokenBuilder.build.setToken(token);
  }

  String get token => "${TokenBuilder.build.token}";

  /// set organization id
  void setOrgId(String orgId) {
    TokenBuilder.build.setOrgId(orgId);
  }

  String get orgId => "${TokenBuilder.build.orgId}";

  ///build environment for openai [build]
  ///setup http client
  ///setup logger
  @override
  OpenAI build({
    String? token,
    String? orgId,
    String? apiUrl,
    HttpSetup? baseOption,
    bool enableLog = false,
  }) {
    if ("$token".isEmpty || token == null) throw MissingTokenException();
    final setup = baseOption ?? HttpSetup();
    setToken(token);

    if (orgId != null) {
      setOrgId(orgId);
    }

    final dio = Dio(BaseOptions(
      sendTimeout: setup.sendTimeout,
      connectTimeout: setup.connectTimeout,
      receiveTimeout: setup.receiveTimeout,
    ));
    if (setup.proxy.isNotEmpty) {
      dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
        final client = HttpClient();
        client.findProxy = (uri) {
          /// "PROXY localhost:7890"
          return setup.proxy;
        };

        return client;
      });
    }
    dio.interceptors.add(InterceptorWrapper());

    final _apiUrl = (apiUrl?.isNotEmpty ?? false) ? apiUrl! : kURL;
    _client = OpenAIClient(dio: dio, apiUrl: _apiUrl, isLogging: enableLog);

    return instance;
  }

  ///find all list model ai [listModel]
  @override
  Future<OpenAiModel> listModel({
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.get<OpenAiModel>(
      "${_client.apiUrl}$kModelList",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => OpenAiModel.fromJson(it),
    );
  }

  /// find all list engine ai [listEngine]
  @override
  Future<EngineModel> listEngine({
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.get<EngineModel>(
      "${_client.apiUrl}$kEngineList",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) {
        return EngineModel.fromJson(it);
      },
    );
  }

  ///### About Method [onCompleteText]
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples
  @override
  Future<CompleteResponse?> onCompletion({
    required CompleteText request,
    void Function(CancelData cancelData)? onCancel,
  }) =>
      _client.post(
        "${_client.apiUrl}$kCompletion",
        request.toJson(),
        onCancel: (it) => onCancel != null ? onCancel(it) : null,
        onSuccess: (it) {
          return CompleteResponse.fromJson(it);
        },
      );

  ///Given a chat conversation,
  /// the model will return a chat completion response.[onChatCompletion]
  @override
  Future<ChatCTResponse?> onChatCompletion({
    required ChatCompleteText request,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      "${_client.apiUrl}$kChatGptTurbo",
      request.toJson(),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) {
        return ChatCTResponse.fromJson(it);
      },
    );
  }

  ///generate image with prompt
  @override
  Future<GenImgResponse?> generateImage(
    GenerateImage request, {
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.post(
      "${_client.apiUrl}$kGenerateImage",
      request.toJson(),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) {
        return GenImgResponse.fromJson(it);
      },
    );
  }

  ///## Support Server Sent Event
  ///Given a chat conversation,
  /// the model will return a chat completion response. [onChatCompletionSSE]
  @override
  Stream<ChatResponseSSE> onChatCompletionSSE({
    required ChatCompleteText request,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.sse(
      "${_client.apiUrl}$kChatGptTurbo",
      request.toJson()..addAll({"stream": true}),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) {
        return ChatResponseSSE.fromJson(it);
      },
    );
  }

  ///## Support Server Sent Event
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples .[onChatCompletion]
  @override
  Stream<CompleteResponse> onCompletionSSE({
    required CompleteText request,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.sse(
      '${_client.apiUrl}$kCompletion',
      request.toJson()..addAll({"stream": true}),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) {
        return CompleteResponse.fromJson(it);
      },
    );
  }

  ///edit prompt
  Edit get editor => Edit(_client);

  ///embedding
  Embedding get embed => Embedding(_client);

  ///audio
  Audio get audio => Audio(_client);

  ///files
  OpenAIFile get file => OpenAIFile(_client);

  ///fine-tune
  FineTuned get fineTune => FineTuned(_client);

  ///moderation's
  Moderation get moderation => Moderation(_client);

  ///Assistants
  Assistants get assistant => Assistants(_client);

  ///Threads
  Threads get threads => Threads(client: _client);
}

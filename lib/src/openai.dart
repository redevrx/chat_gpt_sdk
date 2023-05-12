import 'dart:async';
import 'package:chat_gpt_sdk/src/audio.dart';
import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:chat_gpt_sdk/src/embedding.dart';
import 'package:chat_gpt_sdk/src/file.dart';
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
import 'package:chat_gpt_sdk/src/model/openai_model/openai_models.dart';
import 'package:chat_gpt_sdk/src/moderations.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:chat_gpt_sdk/src/utils/keep_token.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'client/exception/openai_exception.dart';
import 'client/interceptor/interceptor_wrapper.dart';
import 'edit.dart';

abstract class IOpenAI {
  OpenAI build({String? token, HttpSetup? baseOption, bool isLog = false});
  listModel();
  listEngine();
  Future<CTResponse?> onCompletion({required CompleteText request});
  Stream<CTResponse> onCompletionSSE({required CompleteText request});
  Future<ChatCTResponse?> onChatCompletion({
    required ChatCompleteText request,
  });
  Stream<ChatCTResponseSSE> onChatCompletionSSE(
      {required ChatCompleteText request});
  Future<GenImgResponse?> generateImage(GenerateImage request);
  void cancelAIGenerate();
}

//const msgDeprecate = "not support in version 2.0.6";

class OpenAI implements IOpenAI {
  OpenAI._();

  ///instance of openai [instance]
  static OpenAI instance = OpenAI._();

  late OpenAIClient _client;

  ///cancel request
  final _cancel = CancelToken();

  /// set new token
  void setToken(String token) async {
    TokenBuilder.build.setToken(token);
  }

  String get token => "${TokenBuilder.build.token}";

  ///build environment for openai [build]
  ///setup http client
  ///setup logger
  @override
  OpenAI build({String? token, HttpSetup? baseOption, bool isLog = false}) {
    if ("$token".isEmpty) throw MissionTokenException();
    final setup = baseOption ?? HttpSetup();
    setToken(token!);

    final dio = Dio(BaseOptions(
        sendTimeout: setup.sendTimeout,
        connectTimeout: setup.connectTimeout,
        receiveTimeout: setup.receiveTimeout));
    if (setup.proxy.isNotEmpty) {
      dio.httpClientAdapter = IOHttpClientAdapter()
        ..onHttpClientCreate = (client) {
          client.findProxy = (uri) {
            /// "PROXY localhost:7890"
            return setup.proxy;
          };
          return client;
        };
    }
    dio.interceptors.add(InterceptorWrapper());

    _client = OpenAIClient(dio: dio, isLogging: isLog);
    return instance;
  }

  ///find all list model ai [listModel]
  @override
  Future<AiModel> listModel() async {
    return _client.get<AiModel>(
      "$kURL$kModelList",
      _cancel,
      onSuccess: (it) {
        return AiModel.fromJson(it);
      },
    );
  }

  /// find all list engine ai [listEngine]
  @override
  Future<EngineModel> listEngine() async {
    return _client.get<EngineModel>("$kURL$kEngineList", _cancel,
        onSuccess: (it) {
      return EngineModel.fromJson(it);
    });
  }

  ///### About Method [onCompleteText]
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples
  @override
  Future<CTResponse?> onCompletion({required CompleteText request}) async {
    return _client.post("$kURL$kCompletion", _cancel, request.toJson(),
        onSuccess: (it) {
      return CTResponse.fromJson(it);
    });
  }

  ///Given a chat conversation,
  /// the model will return a chat completion response.[onChatCompletion]
  @override
  Future<ChatCTResponse?> onChatCompletion(
      {required ChatCompleteText request}) {
    return _client.post("$kURL$kChatGptTurbo", _cancel, request.toJson(),
        onSuccess: (it) {
      return ChatCTResponse.fromJson(it);
    });
  }

  ///generate image with prompt
  @override
  Future<GenImgResponse?> generateImage(GenerateImage request) async {
    return _client.post("$kURL$kGenerateImage", _cancel, request.toJson(),
        onSuccess: (it) {
      return GenImgResponse.fromJson(it);
    });
  }

  ///## Support Server Sent Event
  ///Given a chat conversation,
  /// the model will return a chat completion response. [onChatCompletionSSE]
  @override
  Stream<ChatCTResponseSSE> onChatCompletionSSE(
      {required ChatCompleteText request}) {
    return _client.sse("$kURL$kChatGptTurbo", _cancel,
        request.toJson()..addAll({"stream": true}), complete: (it) {
      return ChatCTResponseSSE.fromJson(it);
    });
  }

  ///## Support Server Sent Event
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples .[onChatCompletion]
  @override
  Stream<CTResponse> onCompletionSSE({required CompleteText request}) {
    return _client.sse('$kURL$kCompletion', _cancel,
        request.toJson()..addAll({"stream": true}), complete: (it) {
      return CTResponse.fromJson(it);
    });
  }

  @override
  void cancelAIGenerate() {
    _client.log.log('stop openAI');
    _cancel.cancel();
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
  FineTune get fineTune => FineTune(_client);

  ///moderations
  Moderation get moderation => Moderation(_client);
}

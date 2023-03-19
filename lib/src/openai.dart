import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/ChatCompleteText.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/response/ChatCTResponse.dart';
import 'package:chat_gpt_sdk/src/model/client/http_setup.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/request/complete_text.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/complete_response.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/generate_image.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/response/GenImgResponse.dart';
import 'package:chat_gpt_sdk/src/model/openai_engine/engine_model.dart';
import 'package:chat_gpt_sdk/src/model/openai_model/openai_models.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'client/exception/openai_exception.dart';
import 'client/interceptor/interceptor_wrapper.dart';

abstract class IOpenAI {
  OpenAI build({String? token, HttpSetup? baseOption, bool isLog = false});
  listModel();
  listEngine();
  Future<CTResponse?> onCompletion({required CompleteText request});
  void onCompletionSSE(
      {required CompleteText request,
      required Function(Stream<List<int>> value) complete});
  Future<ChatCTResponse?> onChatCompletion({
    required ChatCompleteText request,
  });
  void onChatCompletionSSE(
      {required ChatCompleteText request,
      required Function(Stream<List<int>> value) complete});
  Stream<GenImgResponse> generateImageStream(GenerateImage request);
  Future<GenImgResponse?> generateImage(GenerateImage request);
}

const msgDeprecate = "not support in version 2.0.6";

class OpenAI implements IOpenAI {
  OpenAI._();

  ///instance of openai [instance]
  static OpenAI instance = OpenAI._();

  late OpenAIClient _client;

  /// openai token
  /// use for access for chat gpt [_token]
  static String? _token;

  static SharedPreferences? _prefs;

  ///new instance prefs for keep my data
  void _buildShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// set new token
  void setToken(String token) async {
    _token = token;
    await _prefs?.setString(kTokenKey, token);
  }

  String getToken() => "$_token";

  ///build environment for openai [build]
  ///setup http client
  ///setup logger\
  @override
  OpenAI build({String? token, HttpSetup? baseOption, bool isLog = false}) {
    _buildShared();

    if ("$token".isEmpty) throw MissionTokenException();
    final setup = baseOption == null ? HttpSetup() : baseOption;

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
    dio.interceptors.add(InterceptorWrapper(_prefs, token!));

    _client = OpenAIClient(dio: dio, isLogging: isLog);
    setToken(token);

    return instance;
  }

  ///find all list model ai [listModel]
  @override
  Future<AiModel> listModel() async {
    return _client.get<AiModel>(
      "$kURL$kModelList",
      onSuccess: (it) {
        return AiModel.fromJson(it);
      },
    );
  }

  /// find all list engine ai [listEngine]
  @override
  Future<EngineModel> listEngine() async {
    return _client.get<EngineModel>("$kURL$kEngineList", onSuccess: (it) {
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
    return _client.post("$kURL$kCompletion", request.toJson(), onSuccess: (it) {
      return CTResponse.fromJson(it);
    });
  }

  ///### About Method [onCompleteText]
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples
  @Deprecated(msgDeprecate)
  Stream<CTResponse?> onCompletionStream({required CompleteText request}) {
    _completeText(request: request);
    return _completeControl!.stream;
  }

  StreamController<CTResponse>? _completeControl =
      StreamController<CTResponse>.broadcast();
  void _completeText({required CompleteText request}) {
    _client.postStream("$kURL$kCompletion", request.toJson()).listen((rawData) {
      if (rawData.statusCode != HttpStatus.ok) {
        _client.log.errorLog(code: rawData.statusCode, error: rawData.data);
        _completeControl
          ?..sink
          ..addError(
              "complete error: ${rawData.statusMessage} code: ${rawData.statusCode} data: ${rawData.data}");
      } else {
        _client.log.debugString(
            "============= success ==================\nresponse body :${rawData.data}");
        _completeControl
          ?..sink
          ..add(CTResponse.fromJson(rawData.data));
      }
    }).onError((err) {
      if (err is DioError) {
        _completeControl
          ?..sink
          ..addError(
              "complete error: message :${err.message}\n error body :${err.response?.data}, code: ${err.response?.statusCode}");
      }
    });
  }

  ///Given a chat conversation, the model will return a chat completion response.
  @override
  Future<ChatCTResponse?> onChatCompletion(
      {required ChatCompleteText request}) {
    return _client.post("$kURL$kChatGptTurbo", request.toJson(),
        onSuccess: (it) {
      return ChatCTResponse.fromJson(it);
    });
  }

  ///Given a chat conversation, the model will return a chat completion response.
  @Deprecated(msgDeprecate)
  Stream<ChatCTResponse?> onChatCompletionStream(
      {required ChatCompleteText request}) {
    _chatCompleteText(request: request);
    return _chatCompleteControl!.stream;
  }

  StreamController<ChatCTResponse>? _chatCompleteControl =
      StreamController<ChatCTResponse>.broadcast();
  void _chatCompleteText({required ChatCompleteText request}) {
    _client
        .postStream("$kURL$kChatGptTurbo", request.toJson())
        .listen((rawData) {
      if (rawData.statusCode != HttpStatus.ok) {
        _client.log.errorLog(code: rawData.statusCode, error: rawData.data);
        _chatCompleteControl
          ?..sink
          ..addError(
              "chat complete error: ${rawData.statusMessage} code: ${rawData.statusCode} data: ${rawData.data}");
      } else {
        _client.log.debugString(
            "============= success ==================\nresponse body :${rawData.data}");
        _chatCompleteControl
          ?..sink
          ..add(ChatCTResponse.fromJson(rawData.data));
      }
    }).onError((err) {
      if (err is DioError) {
        _chatCompleteControl
          ?..sink
          ..addError(
              "chat complete error message :${err.message}\n error body :${err.response?.data}, code: ${err.response?.statusCode}");
      }
    });
  }

  ///### close complete stream
  ///free memory [close]
  @Deprecated(msgDeprecate)
  void close() {
    _completeControl?.close();
    _chatCompleteControl?.close();
  }

  ///generate image with prompt [generateImageStream]
  @override
  Stream<GenImgResponse> generateImageStream(GenerateImage request) {
    _generateImage(request);
    return _genImgController.stream;
  }

  final _genImgController = StreamController<GenImgResponse>.broadcast();
  void _generateImage(GenerateImage request) {
    _client
        .postStream("$kURL$kGenerateImage", request.toJson())
        .listen((rawData) {
      if (rawData.statusCode != HttpStatus.ok) {
        _client.log.errorLog(code: rawData.statusCode, error: rawData.data);
        _genImgController
          ..sink
          ..addError(
              "generate image error: ${rawData.statusMessage} code: ${rawData.statusCode} data: ${rawData.data}");
      } else {
        _client.log.debugString(
            "============= success ==================\nresponse body :${rawData.data}");
        _genImgController
          ..sink
          ..add(GenImgResponse.fromJson(rawData.data));
      }
    }).onError((err) => {
              if (err is DioError)
                {
                  _genImgController
                    ..sink
                    ..addError(
                        "generate image error: message :${err.message}\nerror body :${err.response?.data}, code: ${err.response?.statusCode}")
                }
            });
  }

  /// close generate image stream[genImgClose]
  /// free memory
  void genImgClose() {
    _genImgController.close();
  }

  ///generate image with prompt
  @override
  Future<GenImgResponse?> generateImage(GenerateImage request) async {
    return _client.post("$kURL$kGenerateImage", request.toJson(),
        onSuccess: (it) {
      return GenImgResponse.fromJson(it);
    });
  }

  @override
  void onChatCompletionSSE(
      {required ChatCompleteText request,
      required Function(Stream<List<int>> value) complete}) {
    return _client.sse(
        "$kURL$kChatGptTurbo", request.toJson()..addAll({"stream": true}),
        complete: (it) => complete(it));
  }

  @override
  void onCompletionSSE(
      {required CompleteText request,
      required Function(Stream<List<int>> value) complete}) {
    return _client.sse(
        '$kURL$kCompletion', request.toJson()..addAll({"stream": true}),
        complete: (it) => complete(it));
  }
}

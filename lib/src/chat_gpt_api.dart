import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt_sdk/src/api/endpint.dart';
import 'package:chat_gpt_sdk/src/constants.dart';
import 'package:chat_gpt_sdk/src/model/ai_model.dart';
import 'package:chat_gpt_sdk/src/model/complete_req.dart';
import 'package:chat_gpt_sdk/src/model/complete_res.dart';
import 'package:chat_gpt_sdk/src/model/engine_model.dart';
import 'package:chat_gpt_sdk/src/model/generate_image_req.dart';
import 'package:chat_gpt_sdk/src/model/generate_img_res.dart';
import 'package:chat_gpt_sdk/src/model/http_setup.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/intercepter.dart';

class ChatGPT {
  ChatGPT._();

  static ChatGPT? _instance;
  static String? _token;
  static Dio? _dio;
  static SharedPreferences? _prefs;

  static ChatGPT get instance => _instance ?? ChatGPT._();

  ///token access OpenAI
  static get token => _token;


  /// ### Build API Token
  /// @param [token]  token access OpenAI
  /// generate here https://beta.openai.com/account/api-keys
  ChatGPT builder(String token, {HttpSetup? baseOption}) {
    _buildShared();
    Timer(const Duration(seconds: 1), () {
      _buildApi(baseOption ?? HttpSetup().getHttpSetup());
      setToken(token);
    });
    return instance;
  }

  ///new instance prefs for keep my data
  void _buildShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///build base api
  void _buildApi(HttpSetup setup) {
    _dio = Dio(BaseOptions(
        sendTimeout: setup.sendTimeout,
        connectTimeout: setup.connectTimeout,
        receiveTimeout: setup.receiveTimeout));
    _dio?.interceptors.add(InterceptorWrapper(_prefs));
  }

  /// set new token
  void setToken(String token) async {
    _token = token;
    await _prefs?.setString(kTokenKey, token);
  }

  ///### About Method
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples
  Future<CompleteRes?> onCompleteText({required CompleteReq request}) async {
    final res = await _dio?.post("$kURL$kCompletion",
        data: json.encode(request.toJson()));
    if (res?.statusCode != HttpStatus.ok) {
      // print(
      //     "complete error: ${res?.statusMessage} code: ${res?.statusCode} data: ${res?.data}");
    }
    return res?.data == null ? null : CompleteRes.fromJson(res?.data);
  }

  ///### About Method
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples
  Stream<CompleteRes?> onCompleteStream({required CompleteReq request}) {
    _completeText(request: request);
    return _completeControl.stream;
  }

  final _completeControl = StreamController<CompleteRes>.broadcast();
  void _completeText({required CompleteReq request}) {
    _dio
        ?.post("$kURL$kCompletion",
            data: json.encode(request.toJson()))
        .asStream()
        .listen((response) {
      if (response.statusCode != HttpStatus.ok) {
        _completeControl
          ..sink
          ..addError(
              "complete error: ${response.statusMessage} code: ${response.statusCode} data: ${response.data}");
      } else {
        _completeControl
          ..sink
          ..add(CompleteRes.fromJson(response.data));
      }
    });
  }

  ///### close complete stream
  void close() {
    _completeControl.close();
  }

  ///find all list model ai
  Future<AiModel> listModel() async {
    final res = await _dio?.get("$kURL$kModelList");
    if (res?.statusCode != HttpStatus.ok) {}
    return AiModel.fromJson(res?.data);
  }

  /// find all list engine ai
  Future<EngineModel> listEngine() async {
    final res = await _dio?.get("$kURL$kEngineList");
    if (res?.statusCode != HttpStatus.ok) {
      if (kDebugMode) {
        print(
            "error: ${res?.statusMessage} code: ${res?.statusCode} data: ${res?.data}");
      }
    }
    return EngineModel.fromJson(res?.data);
  }

  ///generate image with prompt
  Stream<GenerateImgRes> generateImageStream(GenerateImage request) {
    _generateImage(request);
    return _genImgController.stream;
  }

  final _genImgController = StreamController<GenerateImgRes>.broadcast();
  void _generateImage(GenerateImage request) {
    _dio?.post("$kURL$kGenerateImage",
        data: json.encode(request.toJson()))
    .asStream()
    .listen((response) {
      if (response.statusCode != HttpStatus.ok) {
        _genImgController
          ..sink
          ..addError(
              "generate image error: ${response.statusMessage} code: ${response.statusCode} data: ${response.data}");
      } else {
        _genImgController
          ..sink
          ..add(GenerateImgRes.fromJson(response.data));
      }
    });
  }

  void genImgClose() {
    _genImgController.close();
  }

  ///generate image with prompt
  Future<GenerateImgRes?> generateImage(GenerateImage request) async {
    final response = await _dio?.post("$kURL$kGenerateImage",
    data: json.encode(request.toJson()),);

    return response?.data != null ? GenerateImgRes.fromJson(response?.data): null;
  }
}

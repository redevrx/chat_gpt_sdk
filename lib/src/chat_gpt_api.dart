import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt/src/api/endpint.dart';
import 'package:chat_gpt/src/constants.dart';
import 'package:chat_gpt/src/model/ai_model.dart';
import 'package:chat_gpt/src/model/complete_req.dart';
import 'package:chat_gpt/src/model/complete_res.dart';
import 'package:chat_gpt/src/model/engine_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/intercepter.dart';

class ChatGPT {
  ChatGPT._();

  static ChatGPT? _instance;
  static String? _token;
  static String? _orgID;
  static Dio? _dio;
  static SharedPreferences? _prefs;

  static ChatGPT get instance => _instance ?? ChatGPT._();

  ///token access OpenAI
  static get token => _token;

  ///organization ID
  ///https://beta.openai.com/account/org-settings
  static get orgID => _orgID;

  /// ### Build API Token
  /// @param [token]  token access OpenAI
  /// generate here https://beta.openai.com/account/api-keys
  ChatGPT builder(String token, {String orgID = ""}) {
    _buildShared();
    Timer(const Duration(seconds: 1), () {
      _buildApi();
      setToken(token);
      setOrgId(orgID);
    });
    return instance;
  }

  ///new instance prefs for keep my data
  void _buildShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///build base api
  void _buildApi() {
    _dio = Dio(BaseOptions(sendTimeout: 5000,connectTimeout: 5000));
    _dio?.interceptors.add(InterceptorWrapper(_prefs));
  }

  /// set new token
  void setToken(String token) async {
    _token = token;
    await _prefs?.setString(kTokenKey, token);
  }

  ///set new orgId
  void setOrgId(String orgId) async {
    _orgID = orgId;
    await _prefs?.setString(kOrgIdKey, orgId);
  }

  ///### About Method
  /// - Answer questions based on existing knowledge.
  /// - Create code to call the Stripe API using natural language.
  /// - Classify items into categories via example.
  /// - look more
  /// https://beta.openai.com/examples
  Future<CompleteRes?> onCompleteText({required CompleteReq request}) async {
    final res = await _dio?.post("$kURL$kCompletion",
        data: json.encode(request.toJson()),
        options: Options(headers: kHeader(token)));
    if (res?.statusCode != HttpStatus.ok) {
      print(
          "complete error: ${res?.statusMessage} code: ${res?.statusCode} data: ${res?.data}");
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

  final  _completeControl = StreamController<CompleteRes>();
  void _completeText({required CompleteReq request}) {
    _dio
        ?.post("$kURL$kCompletion",
            data: json.encode(request.toJson()),
    options: Options(headers: kHeader(token)))
        .asStream()
        .listen((response) {
      if (response?.statusCode != HttpStatus.ok) {
        print(
            "complete error: ${response?.statusMessage} code: ${response?.statusCode} data: ${response?.data}");
        _completeControl
          ..sink
          ..addError(
              "complete error: ${response?.statusMessage} code: ${response?.statusCode} data: ${response?.data}");
      } else {
        _completeControl
          ..sink
          ..add(CompleteRes.fromJson(response?.data));
      }
    });
  }

  ///
  Future<AiModel> listModel() async{
    final res = await _dio?.get("$kURL$kModelList");
    if (res?.statusCode != HttpStatus.ok) {
      print(
          " error: ${res?.statusMessage} code: ${res?.statusCode} data: ${res?.data}");
    }
  return AiModel.fromJson(res?.data);
  }

  ///
  Future<EngineModel> listEngine() async{
    final res = await _dio?.get("$kURL$kEngineList");
    if (res?.statusCode != HttpStatus.ok) {
      print(
          "error: ${res?.statusMessage} code: ${res?.statusCode} data: ${res?.data}");
    }
    print("MyDATA: ${res?.data}");
    return EngineModel.fromJson(res?.data);
  }
}


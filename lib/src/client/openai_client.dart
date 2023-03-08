import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt_sdk/src/client/base_client.dart';
import 'package:chat_gpt_sdk/src/client/exception/request_error.dart';
import 'package:chat_gpt_sdk/src/logger/logger.dart';
import 'package:dio/dio.dart';

class OpenAIClient extends OpenAIWrapper {
  OpenAIClient({required Dio dio, bool isLogging = false}) {
    _dio = dio;
    log = Logger.instance.builder(isLogging: isLogging);
  }

  ///[_dio]
  late Dio _dio;

  ///[log]
  late Logger log;

  Future<T> get<T>(String url,
      {required T Function(Map<String, dynamic>) onSuccess}) async {
  try {
    final rawData = await _dio.get(url);

    if (rawData.statusCode == HttpStatus.ok) {
      log.debugString(
          "============= success ==================\nresponse body :${rawData.data}");
      return onSuccess(rawData.data);
    } else {
      log.errorLog(code: rawData.statusCode, error: "${rawData.data}");
      throw RequestError(message: "${rawData.data}", code: rawData.statusCode);
    }
  } on DioError catch (err) {
    throw RequestError(message: "${err.message}", code: err.response?.statusCode);
  }
  }

  Future<T> post<T>(String url,Map<String,dynamic> request,
      {required T Function(Map<String, dynamic>) onSuccess}) async {
    try {
      log.debugString("request body :$request");

      final rawData = await _dio.post(url,
          data: json.encode(request));
      if (rawData.statusCode == HttpStatus.ok) {
        log.debugString("status code :${rawData.statusCode}");
        log.debugString(
            "============= success ==================\nresponse body :${rawData.data}");
        return onSuccess(rawData.data);
      } else {
        log.errorLog(code: rawData.statusCode, error: "${rawData.data}");
        throw RequestError(message: "${rawData.data}", code: rawData.statusCode);
      }
    } on DioError catch (err){
      throw RequestError(message: "${err.message} \ndata:${err.response?.data}", code: err.response?.statusCode);
    }
  }

  Stream<Response> postStream(String url,Map<String,dynamic> request)  {
    log.debugString("request body :$request");
    return  _dio.post(url,
        data: json.encode(request)).asStream();
  }
}

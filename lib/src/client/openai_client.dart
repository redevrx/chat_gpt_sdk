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

  Future<T> get<T>(String url, CancelToken cancelToken,
      {required T Function(Map<String, dynamic>) onSuccess}) async {
    try {
      final rawData = await _dio.get(url, cancelToken: cancelToken);

      if (rawData.statusCode == HttpStatus.ok) {
        log.debugString(
            "============= success ==================\nresponse body :${rawData.data}");
        return onSuccess(rawData.data);
      } else {
        log.errorLog(code: rawData.statusCode, error: "${rawData.data}");
        throw RequestError(
            message: "${rawData.data}", code: rawData.statusCode);
      }
    } on DioError catch (err) {
      throw RequestError(
          message: "${err.message}", code: err.response?.statusCode);
    }
  }

  Future<T> post<T>(
      String url, CancelToken cancelToken, Map<String, dynamic> request,
      {required T Function(Map<String, dynamic>) onSuccess}) async {
    try {
      log.debugString("request body :$request");

      final rawData = await _dio.post(url,
          data: json.encode(request), cancelToken: cancelToken);
      if (rawData.statusCode == HttpStatus.ok) {
        log.debugString("status code :${rawData.statusCode}");
        log.debugString(
            "============= success ==================\nresponse body :${rawData.data}");
        return onSuccess(rawData.data);
      } else {
        log.errorLog(code: rawData.statusCode, error: "${rawData.data}");
        throw RequestError(
            message: "${rawData.data}", code: rawData.statusCode);
      }
    } on DioError catch (err) {
      throw RequestError(
          message: "${err.message} \ndata:${err.response?.data}",
          code: err.response?.statusCode);
    }
  }

  Stream<Response> postStream(
      String url, CancelToken cancelToken, Map<String, dynamic> request) {
    log.debugString("request body :$request");
    return _dio
        .post(url, data: json.encode(request), cancelToken: cancelToken)
        .asStream();
  }

  Stream<T> sse<T>(
      String url, CancelToken cancelToken, Map<String, dynamic> request,
      {required T Function(Map<String, dynamic> value) complete}) {
    log.debugString("request body :$request");
    final controller = StreamController<T>.broadcast();

    _dio
        .post(url,
            cancelToken: cancelToken,
            data: json.encode(request),
            options: Options(responseType: ResponseType.stream))
        .then((it) {
      it.data.stream.listen((it) {
        final raw = utf8.decode(it);
        final dataList =
            raw.split("\n").where((element) => element.isNotEmpty).toList();

        for (final data in dataList) {
          if (data.startsWith("data: ")) {
            ///remove data:
            final mData = data.substring(6);
            if (mData.startsWith("[DONE]")) {
              log.debugString("stream response is done");
              return;
            }
            print(mData);

            ///decode data
            controller
              ..sink
              ..add(complete(jsonDecode(mData)));
          }
        }
      }, onDone: () {
        controller.close();
      }, onError: (err, t) {
        controller
          ..sink
          ..addError(err, t);
      });
    }, onError: (err, t) {
      controller
        ..sink
        ..addError(err, t);
    });
    return controller.stream;
  }

  Future<T> postFormData<T>(
      String url, CancelToken cancelToken, FormData request,
      {required T Function(Map<String, dynamic> value) complete}) async{
    try {
      final response = await _dio.post(url,data:request);

      if (response.statusCode == HttpStatus.ok) {
        log.debugString("status code :${response.statusCode}");
        log.debugString(
            "============= success ==================\nresponse body :${response.data}");
        return complete(response.data);
      } else {
        log.errorLog(code: response.statusCode, error: "${response.data}");
        throw RequestError(
            message: "${response.data}", code: response.statusCode);
      }

    }on DioError catch(err){
      throw RequestError(
          message: "${err.message} \ndata:${err.response?.data}",
          code: err.response?.statusCode);
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_gpt_sdk/src/client/exception/base_error_wrapper.dart';
import 'package:chat_gpt_sdk/src/client/exception/request_error.dart';
import 'package:chat_gpt_sdk/src/client/openai_wrapper.dart';
import 'package:chat_gpt_sdk/src/logger/logger.dart';
import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/model/error/openai_error.dart';
import 'package:dio/dio.dart';

class OpenAIClient extends OpenAIWrapper {
  OpenAIClient({
    required Dio dio,
    required String apiUrl,
    bool isLogging = false,
  }) {
    _dio = dio;
    _apiUrl = apiUrl;
    log = Logger.instance.builder(isLogging: isLogging);
  }

  ///[_dio]
  late Dio _dio;

  ///[log]
  late Logger log;

  late String _apiUrl;

  String get apiUrl => _apiUrl;

  Future<T> get<T>(
    String url, {
    required T Function(Map<String, dynamic>) onSuccess,
    required void Function(CancelData cancelData) onCancel,
    bool returnRawData = false,
    Map<String, String>? headers,
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request");
      final rawData = await _dio.get(
        url,
        cancelToken: cancelData.cancelToken,
        options: Options(headers: headers ?? {}),
      );

      if (rawData.statusCode == HttpStatus.ok) {
        log.log("============= success ==================");

        if (returnRawData) {
          return rawData.data as T;
        }

        return onSuccess(rawData.data);
      } else {
        log.log("code: ${rawData.statusCode}, message :${rawData.data}");
        throw handleError(
          code: rawData.statusCode ?? HttpStatus.internalServerError,
          message: "",
          data: rawData.data,
        );
      }
    } on DioException catch (err) {
      log.log(
        "code: ${err.response?.statusCode}, message :${err.message} + ${err.response?.data}",
      );
      throw handleError(
        code: err.response?.statusCode ?? HttpStatus.internalServerError,
        message: '${err.message}',
        data: err.response?.extra,
      );
    }
  }

  Stream<T> getStream<T>(
    String url, {
    Map<String, dynamic>? queryParameters = null,
    required T Function(Map<String, dynamic>) onSuccess,
    required void Function(CancelData cancelData) onCancel,
  }) {
    final controller = StreamController<T>.broadcast();
    final cancelData = CancelData(cancelToken: CancelToken());
    final List<int> chunks = [];
    onCancel(cancelData);

    log.log("starting request");
    _dio
        .get(
      url,
      queryParameters: queryParameters,
      cancelToken: cancelData.cancelToken,
      options: Options(responseType: ResponseType.stream),
    )
        .then(
      (it) {
        (it.data.stream as Stream).listen(
          (it) {
            chunks.addAll(it);
          },
          onDone: () {
            final rawData = utf8.decode(chunks);

            final dataList = rawData
                .split("\n")
                .where((element) => element.isNotEmpty)
                .toList();

            for (final line in dataList) {
              if (line.startsWith("data: ")) {
                final data = line.substring(6);
                if (data.startsWith("[DONE]")) {
                  log.log("stream response is done");

                  return;
                }

                controller
                  ..sink
                  ..add(onSuccess(json.decode(data)));

                controller.close();
              }
            }
          },
          onError: (err, t) {
            log.error(err, t);
            controller
              ..sink
              ..addError(err, t);
          },
        );
      },
      onError: (err, t) {
        log.error(err, t);
        controller
          ..sink
          ..addError(err, t);
      },
    );

    return controller.stream;
  }

  Future<T> delete<T>(
    String url, {
    required T Function(Map<String, dynamic>) onSuccess,
    required void Function(CancelData cancelData) onCancel,
    Map<String, String>? headers,
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request");
      final rawData = await _dio.delete(
        url,
        cancelToken: cancelData.cancelToken,
        options: Options(
          headers: headers ?? {},
        ),
      );

      if (rawData.statusCode == HttpStatus.ok) {
        log.log("============= success ==================");

        return onSuccess(rawData.data);
      } else {
        log.log("error code: ${rawData.statusCode}, message :${rawData.data}");
        throw handleError(
          code: rawData.statusCode ?? HttpStatus.internalServerError,
          message: "${rawData.statusCode}",
          data: rawData.data,
        );
      }
    } on DioException catch (err) {
      log.log(
        "code: ${err.response?.statusCode}, message :${err.message} data: ${err.response?.data}",
      );
      throw handleError(
        code: err.response?.statusCode ?? HttpStatus.internalServerError,
        message: "${err.message}",
        data: err.response?.data,
      );
    }
  }

  Future<T> post<T>(
    String url,
    Map<String, dynamic> request, {
    required T Function(Map<String, dynamic>) onSuccess,
    required void Function(CancelData cancelData) onCancel,
    Map<String, String>? headers,
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request $url");
      log.log("request body :$request");

      final response = await _dio.post(
        url,
        data: json.encode(request),
        cancelToken: cancelData.cancelToken,
        options: Options(headers: headers ?? {}),
      );

      if (response.statusCode == HttpStatus.ok) {
        log.log("============= success ==================");

        return onSuccess(response.data);
      } else {
        log.log("code: ${response.statusCode}, message :${response.data}");
        throw handleError(
          code: response.statusCode ?? HttpStatus.internalServerError,
          message: "${response.statusCode}",
          data: response.data,
        );
      }
    } on DioException catch (err) {
      log.log(
        "error code: ${err.response?.statusCode}, message :${err.message} data:${err.response?.data}",
      );
      throw handleError(
        code: err.response?.statusCode ?? HttpStatus.internalServerError,
        message: "${err.response?.statusCode}",
        data: err.response?.extra,
      );
    }
  }

  ///return response bytes
  Future<T> postRawBody<T>(
    String url,
    Map<String, dynamic> request, {
    required Future<T> Function(List<int> bytes, String responseType) onSuccess,
    required void Function(CancelData cancelData) onCancel,
    Map<String, String>? headers,
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request $url");
      log.log("request body :$request");

      final response = await _dio.post(
        url,
        data: json.encode(request),
        cancelToken: cancelData.cancelToken,
        options: Options(
          headers: headers ?? {},
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        log.log("============= success ==================");
        final String fileResponseFormat = request["response_format"] ?? "mp3";

        return onSuccess(response.data, fileResponseFormat);
      } else {
        log.log("code: ${response.statusCode}, message :${response.data}");
        throw handleError(
          code: response.statusCode ?? HttpStatus.internalServerError,
          message: "${response.statusCode}",
          data: response.data,
        );
      }
    } on DioException catch (err) {
      log.log(
        "error code: ${err.response?.statusCode}, message :${err.message} data:${err.response?.data}",
      );
      throw handleError(
        code: err.response?.statusCode ?? HttpStatus.internalServerError,
        message: "${err.response?.statusCode}",
        data: err.response?.extra,
      );
    }
  }

  Stream<Response> postStream(
    String url,
    Map<String, dynamic> request, {
    required void Function(CancelData cancelData) onCancel,
  }) {
    final cancelData = CancelData(cancelToken: CancelToken());
    onCancel(cancelData);

    log.log("starting request $url");
    log.log("request body :$request");
    final response = _dio
        .post(
          url,
          data: json.encode(request),
          cancelToken: cancelData.cancelToken,
        )
        .asStream();

    return response;
  }

  Stream<T> sse<T>(
    String url,
    Map<String, dynamic> request, {
    required T Function(Map<String, dynamic> value) complete,
    required void Function(CancelData cancelData) onCancel,
  }) {
    log.log("starting request $url");
    log.log("request body :$request");
    final controller = StreamController<T>.broadcast();
    final cancelData = CancelData(cancelToken: CancelToken());

    try {
      onCancel(cancelData);
      _dio
          .post(
        url,
        cancelToken: cancelData.cancelToken,
        data: json.encode(request),
        options: Options(responseType: ResponseType.stream),
      )
          .then(
        (it) {
          // Sometimes, the information in a response may be truncated, in which
          // case it needs to be concatenated with the next one.
          String tmpData = '';
          it.data.stream.listen(
            (it) {
              final rawData = utf8.decode(it);
              final dataList = rawData
                  .split("\n")
                  .where((element) => element.isNotEmpty)
                  .toList();

              for (final line in dataList) {
                if (line.startsWith("data: ")) {
                  final data = line.substring(6);
                  if (data.startsWith("[DONE]")) {
                    log.log("stream response is done");

                    return;
                  }

                  try {
                    controller
                      ..sink
                      ..add(complete(json.decode(data)));
                    tmpData = '';
                  } on FormatException catch (_) {
                    // Sometimes, the information in a response may be truncated,
                    // in which case it needs to be concatenated with the next one.
                    tmpData = data;
                  }
                } else {
                  // If the response does not start with 'data： ', it is considered
                  // to be truncated, and at this time it needs to be concatenated
                  // together with 'tmpData'.
                  try {
                    //add this
                    tmpData = tmpData + line;

                    final decodeData = json.decode(tmpData);

                    // the decodeDate can be a error message like
                    // {error: {message: This model's maximum context length is 4097 tokens.
                    // However, you requested 4376 tokens (376 in the messages, 4000 in the completion).
                    // Please reduce the length of the messages or completion.,
                    // type: invalid_request_error, param: messages, code: context_length_exceeded}}
                    if (decodeData['error'] != null) {
                      controller
                        ..sink
                        ..addError(
                          handleError(
                            code: HttpStatus.internalServerError,
                            message: '',
                            data: decodeData,
                          ),
                        );

                      return;
                    }

                    controller
                      ..sink
                      ..add(complete(decodeData));
                    //when success
                    tmpData = '';
                  } catch (e) {
                    // skip
                    log.log('$e');
                  }
                  // tmpData = '';
                }
              }
            },
            onDone: () {
              controller.close();
            },
            onError: (err, t) {
              log.error(err, t);
              if (err is DioException) {
                controller
                  ..sink
                  ..addError(
                    handleError(
                      code: err.response?.statusCode ??
                          HttpStatus.internalServerError,
                      message: '${err.message}',
                      data: err.response?.extra,
                    ),
                    t,
                  );
              }
            },
          );
        },
        onError: (err, t) {
          log.error(err, t);
          if (err is DioException) {
            final error = err;
            controller
              ..sink
              ..addError(
                handleError(
                  code: error.response?.statusCode ??
                      HttpStatus.internalServerError,
                  message: '${error.message}',
                  data: error.response?.extra,
                ),
                t,
              );
          }
        },
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        log.log("cancel request");
      }
    }

    return controller.stream;
  }

  Future<T> postFormData<T>(
    String url,
    FormData request, {
    required T Function(Map<String, dynamic> value) complete,
    required void Function(CancelData cancelData) onCancel,
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request $url");
      log.log("request body :${request}");
      final response = await _dio.post(
        url,
        data: request,
        cancelToken: cancelData.cancelToken,
      );

      if (response.statusCode == HttpStatus.ok) {
        log.log("============= success ==================\n");

        return complete(response.data);
      } else {
        log.log("code: ${response.statusCode}, error: ${response.data}");
        throw handleError(
          code: response.statusCode ?? HttpStatus.internalServerError,
          message: "${response.statusCode}",
          data: response.data,
        );
      }
    } on DioException catch (err) {
      log.log(
        "code: ${err.response?.statusCode}, error: ${err.message} ${err.response?.data}",
      );
      throw handleError(
        code: err.response?.statusCode ?? HttpStatus.internalServerError,
        message: "${err.response?.statusCode}",
        data: err.response?.data,
      );
    }
  }

  BaseErrorWrapper handleError({
    required int code,
    required String message,
    Map<String, dynamic>? data,
  }) {
    if (code == HttpStatus.unauthorized) {
      return OpenAIAuthError(
        code: code,
        data: OpenAIError.fromJson(data, message),
      );
    } else if (code == HttpStatus.tooManyRequests) {
      return OpenAIRateLimitError(
        code: code,
        data: OpenAIError.fromJson(data, message),
      );
    } else {
      return OpenAIServerError(
        code: code,
        data: OpenAIError.fromJson(data, message),
      );
    }
  }
}

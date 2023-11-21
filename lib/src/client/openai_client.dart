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
  OpenAIClient({required Dio dio, bool isLogging = false}) {
    _dio = dio;
    log = Logger.instance.builder(isLogging: isLogging);
  }

  ///[_dio]
  late Dio _dio;

  ///[log]
  late Logger log;

  Future<T> get<T>(
    String url, {
    required T Function(Map<String, dynamic>) onSuccess,
    required void Function(CancelData cancelData) onCancel,
    bool returnRawData = false,
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request");
      final rawData = await _dio.get(url, cancelToken: cancelData.cancelToken);

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
        data: err.response?.data,
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
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request");
      final rawData =
          await _dio.delete(url, cancelToken: cancelData.cancelToken);

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
  }) async {
    try {
      final cancelData = CancelData(cancelToken: CancelToken());
      onCancel(cancelData);

      log.log("starting request");
      log.log("request body :$request");

      final response = await _dio.post(
        url,
        data: json.encode(request),
        cancelToken: cancelData.cancelToken,
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
        data: err.response?.data,
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

    log.log("starting request");
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
    log.log("starting request");
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

                  controller
                    ..sink
                    ..add(complete(json.decode(data)));
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

      log.log("starting request");
      log.log("request body :$request");
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

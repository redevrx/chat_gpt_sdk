import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'dart:developer' as dev;

class Logger {
  Logger._();

  ///[instance]
  ///return instance of Logger
  static Logger instance = Logger._();

  /// [isLogging]
  /// use for enable log
  bool isLogging = false;

  Logger builder({required bool isLogging}) {
    this.isLogging = isLogging;

    return instance;
  }

  void log(String message) {
    if (isLogging) dev.log(message, name: kOpenAI);
  }

  void error(Object? err, StackTrace? t, {String? message = 'error'}) {
    if (isLogging) dev.log('$message', error: err, stackTrace: t);
  }
}

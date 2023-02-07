import 'package:flutter/cupertino.dart';

abstract class ILogger {
  void errorLog({int? code, String? error});
  void debugString(String? error);
  Logger builder({required bool isLogging});
}

class Logger extends ILogger {
  Logger._();

  ///[instance]
  ///return instance of Logger
  static Logger instance = Logger._();

  /// [isLogging]
  /// use for enable log
  bool isLogging = false;

  @override
  Logger builder({required bool isLogging}) {
    this.isLogging = isLogging;
    return instance;
  }

  @override
  void errorLog({int? code, String? error}) {
   if(isLogging) debugPrint("status code :$code\nerror message :$error");
  }

  @override
  void debugString(String? error) {
    if(isLogging) debugPrint("$error");
  }

}

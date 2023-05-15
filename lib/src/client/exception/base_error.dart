abstract class BaseErrorWrapper implements Exception {
  final String? message;
  final int? code;

  BaseErrorWrapper({this.message, this.code});

  @override
  String toString() => "status code :$code  message :$message\n";
}

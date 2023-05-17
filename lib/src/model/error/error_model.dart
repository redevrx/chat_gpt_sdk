class OpenAIError {
  final String? message;
  final ErrorData? error;

  OpenAIError({this.message, this.error});

  factory OpenAIError.fromJson(Map<String, dynamic>? json, String message) =>
      OpenAIError(
          message: message,
          error: (json == null || json['error'] == null)
              ? null
              : ErrorData.fromJson(json['error']));
}

class ErrorData {
  final String? message;
  final String? type;
  final dynamic param;
  final String? code;

  ErrorData({this.message, this.type, this.param, this.code});

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(
        message: json['message'],
        code: json['code'],
        type: json['type'],
        param: json['param']);
  }

  Map<String, dynamic> toMap() =>
      Map.of({'message': message, 'code': code, 'type': type, 'param': param});
}

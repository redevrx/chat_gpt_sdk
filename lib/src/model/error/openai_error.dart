class OpenAIError {
  final String message;
  final ErrorData error;

  OpenAIError({required this.message, required this.error});

  factory OpenAIError.fromJson(Map<String, dynamic>? json, String message) =>
      OpenAIError(
        message: message,
        error: ErrorData.fromJson(json?['error']),
      );
}

class ErrorData {
  final String? message;
  final String? type;
  final String? code;

  ErrorData({this.message, this.type, this.code});

  factory ErrorData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ErrorData();
    }

    return ErrorData(
      message: json['message'],
      code: json['code'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toMap() =>
      Map.of({'message': message, 'code': code, 'type': type});
}

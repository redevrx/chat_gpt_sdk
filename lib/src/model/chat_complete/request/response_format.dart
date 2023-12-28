class ResponseFormat {
  final String type;

  ResponseFormat({required this.type});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;

    return data;
  }

  static final jsonObject = ResponseFormat(type: "json_object");
}

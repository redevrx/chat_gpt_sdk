class TextData {
  TextData({
    required this.annotations,
    required this.value,
  });

  List<dynamic> annotations;
  String value;

  factory TextData.fromJson(Map<dynamic, dynamic> json) => TextData(
        annotations: json["annotations"] == null
            ? []
            : List<dynamic>.from(json["annotations"].map((x) => x)),
        value: json["value"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "annotations": List<dynamic>.from(annotations.map((x) => x)),
        "value": value,
      };
}

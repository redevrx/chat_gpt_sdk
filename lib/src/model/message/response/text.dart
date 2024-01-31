class Text {
  Text({
    required this.annotations,
    required this.value,
  });

  List<dynamic> annotations;
  String value;

  factory Text.fromJson(Map<dynamic, dynamic> json) => Text(
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

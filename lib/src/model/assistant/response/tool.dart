class Tool {
  Tool({required this.type});

  String type;

  factory Tool.fromJson(Map<dynamic, dynamic> json) =>
      Tool(type: json["type"] as String? ?? '');

  Map<dynamic, dynamic> toJson() => {"type": type};
}

class JsonSchema {
  final String name;
  final Map<String, dynamic> schema;
  final bool strict = true;

  JsonSchema({required this.name, required this.schema});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['schema'] = schema;
    data['strict'] = strict;

    return data;
  }
}

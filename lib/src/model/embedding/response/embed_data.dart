class EmbedData {
  EmbedData({
    required this.object,
    required this.embedding,
    required this.index,
  });

  String object;
  List<double> embedding;
  int index;

  factory EmbedData.fromJson(Map<String, dynamic> json) => EmbedData(
        object: json["object"] as String? ?? '',
        embedding: json["embedding"] == null
            ? []
            : List<double>.from(
                (json["embedding"] as List? ?? []).map((x) => (x as num?)?.toDouble() ?? 0.0),
              ),
        index: json["index"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "object": object,
    "embedding": embedding,
    "index": index,
  };
}

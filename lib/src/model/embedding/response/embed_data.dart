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
        object: json["object"],
        embedding:
            List<double>.from(json["embedding"].map((x) => x?.toDouble())),
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "embedding": embedding,
        "index": index,
      };
}

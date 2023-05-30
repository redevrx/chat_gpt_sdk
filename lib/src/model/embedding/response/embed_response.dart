import '../../complete_text/response/usage.dart';
import 'embed_data.dart';

class EmbedResponse {
  EmbedResponse({
    required this.object,
    required this.data,
    required this.model,
    required this.usage,
  });

  String object;
  List<EmbedData> data;
  String model;
  Usage usage;

  factory EmbedResponse.fromJson(Map<String, dynamic> json) => EmbedResponse(
        object: json["object"],
        data: List<EmbedData>.from(
          json["data"].map((x) => EmbedData.fromJson(x)),
        ),
        model: json["model"],
        usage: Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": List<Map>.from(data.map((x) => x.toJson())),
        "model": model,
        "usage": usage.toJson(),
      };
}

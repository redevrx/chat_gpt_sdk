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
        object: json["object"] as String? ?? '',
        data: json["data"] == null
            ? []
            : List<EmbedData>.from(
                (json["data"] as List? ?? [])
                    .map((x) => EmbedData.fromJson(Map<String, dynamic>.from(x))),
              ),
        model: json["model"] as String? ?? '',
        usage: json["usage"] == null
            ? Usage(0, 0, 0)
            : Usage.fromJson(Map<String, dynamic>.from(json["usage"])),
      );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": List<Map>.from(data.map((x) => x.toJson())),
    "model": model,
    "usage": usage.toJson(),
  };
}

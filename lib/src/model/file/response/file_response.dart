import 'file_data.dart';

class FileResponse {
  FileResponse({required this.data, required this.object});

  List<FileData> data;
  String object;

  factory FileResponse.fromJson(Map<String, dynamic> json) => FileResponse(
        data: json["data"] == null
            ? []
            : (json["data"] as List? ?? [])
                .map((e) => FileData.fromJson(Map<String, dynamic>.from(e)))
                .toList(),
        object: json["object"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {"data": data, "object": object};
}

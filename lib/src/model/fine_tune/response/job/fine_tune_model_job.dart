class FineTuneModelJob {
  FineTuneModelJob({
    required this.trainingFile,
    required this.resultFiles,
    required this.organizationId,
    required this.createdAt,
    required this.model,
    required this.id,
    required this.object,
    required this.status,
  });

  String trainingFile;
  List<Object> resultFiles;
  String organizationId;
  int createdAt;
  String model;
  String id;
  String object;
  String status;

  factory FineTuneModelJob.fromJson(Map<dynamic, dynamic> json) =>
      FineTuneModelJob(
        trainingFile: json["training_file"] as String? ?? '',
        resultFiles: json["result_files"] == null
            ? []
            : List<Object>.from(
                (json["result_files"] as List? ?? []).map((x) => x as Object),
              ),
        organizationId: json["organization_id"] as String? ?? '',
        createdAt: json["created_at"] as int? ?? 0,
        model: json["model"] as String? ?? '',
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
        status: json["status"] as String? ?? '',
      );

  Map<dynamic, dynamic> toJson() => {
    "training_file": trainingFile,
    "result_files": resultFiles.map((x) => x).toList(),
    "organization_id": organizationId,
    "created_at": createdAt,
    "model": model,
    "id": id,
    "object": object,
    "status": status,
  };
}

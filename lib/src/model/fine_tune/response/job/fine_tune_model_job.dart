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
        trainingFile: json["training_file"],
        resultFiles: json["result_files"],
        organizationId: json["organization_id"],
        createdAt: json["created_at"],
        model: json["model"],
        id: json["id"],
        object: json["object"],
        status: json["status"],
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

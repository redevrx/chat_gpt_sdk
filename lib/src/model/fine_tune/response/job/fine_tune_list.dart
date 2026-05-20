import 'package:chat_gpt_sdk/src/model/fine_tune/request/hyper_parameter.dart';

class FineTuneList {
  FineTuneList({
    required this.trainingFile,
    required this.resultFiles,
    required this.finishedAt,
    this.fineTunedModel,
    required this.createdAt,
    required this.organizationId,
    required this.hyperparameters,
    required this.model,
    required this.id,
    required this.trainedTokens,
    required this.object,
    required this.status,
  });

  String trainingFile;
  List<String> resultFiles;
  int finishedAt;
  String? fineTunedModel;
  int createdAt;
  String organizationId;
  Hyperparameter hyperparameters;
  String model;
  String id;
  int trainedTokens;
  String object;
  String status;

  factory FineTuneList.fromJson(Map<dynamic, dynamic> json) => FineTuneList(
        trainingFile: json["training_file"] as String? ?? '',
        resultFiles: json["result_files"] == null
            ? []
            : List<String>.from(
                (json["result_files"] as List? ?? []).map((x) => x.toString()),
              ),
        finishedAt: json["finished_at"] as int? ?? 0,
        fineTunedModel: json["fine_tuned_model"] as String?,
        createdAt: json["created_at"] as int? ?? 0,
        organizationId: json["organization_id"] as String? ?? '',
        hyperparameters: json["hyperparameters"] == null
            ? Hyperparameter(nEpochs: 0)
            : Hyperparameter.fromJson(
                Map<dynamic, dynamic>.from(json["hyperparameters"]),
              ),
        model: json["model"] as String? ?? '',
        id: json["id"] as String? ?? '',
        trainedTokens: json["trained_tokens"] as int? ?? 0,
        object: json["object"] as String? ?? '',
        status: json["status"] as String? ?? '',
      );

  Map<dynamic, dynamic> toJson() => {
    "training_file": trainingFile,
    "result_files": resultFiles.map((x) => x).toList(),
    "finished_at": finishedAt,
    "fine_tuned_model": fineTunedModel,
    "created_at": createdAt,
    "organization_id": organizationId,
    "hyperparameters": hyperparameters.toJson(),
    "model": model,
    "id": id,
    "trained_tokens": trainedTokens,
    "object": object,
    "status": status,
  };
}

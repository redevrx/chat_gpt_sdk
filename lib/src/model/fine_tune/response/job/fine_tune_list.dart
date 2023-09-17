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
        trainingFile: json["training_file"],
        resultFiles: json["result_files"],
        finishedAt: json["finished_at"],
        fineTunedModel: json["fine_tuned_model"],
        createdAt: json["created_at"],
        organizationId: json["organization_id"],
        hyperparameters: Hyperparameter.fromJson(json["hyperparameters"]),
        model: json["model"],
        id: json["id"],
        trainedTokens: json["trained_tokens"],
        object: json["object"],
        status: json["status"],
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

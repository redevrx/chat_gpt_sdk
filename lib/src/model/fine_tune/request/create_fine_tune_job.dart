import '../enum/fine_model.dart';
import 'hyper_parameter.dart';

class CreateFineTuneJob {
  ///he ID of an uploaded file that contains training data.
  ///
  /// See upload file for how to upload a file.
  ///
  /// Your dataset must be formatted as a JSONL file. Additionally, you must
  /// upload your file with the purpose fine-tune.
  ///
  /// See the fine-tuning guide for more details.
  /// ### Url
  /// - fine-tuning guide https://platform.openai.com/docs/guides/fine-tuning
  /// - upload file https://platform.openai.com/docs/api-reference/files/upload
  final String trainingFile;

  ///The ID of an uploaded file that contains validation data.
  ///If you provide this file, the data is used to generate
  /// validation metrics periodically during fine-tuning.
  /// These metrics can be viewed in the fine-tuning results file.
  /// Your train and validation data should be mutually exclusive.
  /// Your dataset must be formatted as a JSONL file,
  /// where each validation example is a JSON object with
  /// the keys "prompt" and "completion". Additionally,
  /// you must upload your file with the purpose fine-tune. [validationFile]
  /// url https://platform.openai.com/docs/guides/fine-tuning/analyzing-your-fine-tuned-model
  final String? validationFile;

  ///The name of the base model to fine-tune.
  /// You can select one of "ada", "babbage",
  /// "curie", "davinci", or a fine-tuned model
  /// created after 2022-04-21.
  /// To learn more about these models,
  /// see the Models documentation. [model]
  /// ## Fine models
  /// - GptTurbo0631Model();
  /// - BabbageFineModel();
  /// - DavinciFineModel();
  /// - FineModelFromValue(model:'your-model-name');
  ///
  final FineModel model;

  ///The hyperparameters used for the fine-tuning job.
  final Hyperparameter? hyperparameters;

  ///A string of up to 18 characters that will be added to your
  /// fine-tuned model name.
  /// For example, a suffix of "custom-model-name" would produce a model name
  /// like ft:gpt-3.5-turbo:openai:custom-model-name:7p4lURel.
  /// [suffix]
  final String? suffix;

  CreateFineTuneJob({
    required this.trainingFile,
    this.validationFile,
    required this.model,
    this.hyperparameters,
    this.suffix,
  });

  Map<String, dynamic> toJson() => Map.of({
        'training_file': trainingFile,
        'validation_file': validationFile,
        'hyperparameters': hyperparameters,
        'model': model.model,
        'suffix': suffix,
      })
        ..removeWhere((_, value) => value == null);
}

class Hyperparameter {
  ///string or integer Optional Defaults to auto [nEpochs]
  ///The number of epochs to train the model for.
  /// An epoch refers to one full cycle through the training dataset.
  final Object nEpochs;

  ///A string of up to 18 characters that will be added to your
  /// fine-tuned model name.
  /// For example, a suffix of "custom-model-name" would produce a model
  /// name like ft:gpt-3.5-turbo:openai:custom-model-name:7p4lURel.
  final String? suffix;

  Hyperparameter({required this.nEpochs, this.suffix});

  factory Hyperparameter.fromJson(Map<dynamic, dynamic> json) => Hyperparameter(
        nEpochs: json["n_epochs"],
      );

  Map<String, dynamic> toJson() => Map.of({
        "n_epochs": nEpochs,
        "suffix": suffix,
      });
}

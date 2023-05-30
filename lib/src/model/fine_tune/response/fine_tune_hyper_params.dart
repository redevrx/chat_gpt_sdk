class FineTuneHyperParams {
  /// The batch size used for fine-tuning.
  final int? batchSize;

  /// The learning rate multiplier used for fine-tuning.
  final double? learningRateMultiplier;

  /// The number of epochs used for fine-tuning.
  final int? nEpochs;

  /// The prompt loss weight used for fine-tuning.
  final double? promptLossWeight;

  const FineTuneHyperParams({
    required this.batchSize,
    required this.learningRateMultiplier,
    required this.nEpochs,
    required this.promptLossWeight,
  });

  factory FineTuneHyperParams.fromJson(Map<String, dynamic> json) {
    return FineTuneHyperParams(
      batchSize: json['batch_size'],
      learningRateMultiplier: json['learning_rate_multiplier'],
      nEpochs: json['n_epochs'],
      promptLossWeight: json['prompt_loss_weight'],
    );
  }
}

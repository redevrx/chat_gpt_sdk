class CompletionTokensDetails {
  final int? reasoningTokens;
  final int? acceptedPredictionTokens;
  final int? rejectedPredictionTokens;

  CompletionTokensDetails({
    this.reasoningTokens,
    this.acceptedPredictionTokens,
    this.rejectedPredictionTokens,
  });

  factory CompletionTokensDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CompletionTokensDetails();
    return CompletionTokensDetails(
      reasoningTokens: json['reasoning_tokens'],
      acceptedPredictionTokens: json['accepted_prediction_tokens'],
      rejectedPredictionTokens: json['rejected_prediction_tokens'],
    );
  }

  Map<String, dynamic> toJson() => {
        'reasoning_tokens': reasoningTokens,
        'accepted_prediction_tokens': acceptedPredictionTokens,
        'rejected_prediction_tokens': rejectedPredictionTokens,
      };
}

class PromptTokensDetails {
  final int? cachedTokens;

  PromptTokensDetails({this.cachedTokens});

  factory PromptTokensDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PromptTokensDetails();
    return PromptTokensDetails(
      cachedTokens: json['cached_tokens'],
    );
  }

  Map<String, dynamic> toJson() => {
        'cached_tokens': cachedTokens,
      };
}

class Usage {
  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;
  final CompletionTokensDetails? completionTokensDetails;
  final PromptTokensDetails? promptTokensDetails;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  Usage(
    this.promptTokens,
    this.completionTokens,
    this.totalTokens, {
    this.completionTokensDetails,
    this.promptTokensDetails,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        json['prompt_tokens'],
        json['completion_tokens'],
        json['total_tokens'],
        completionTokensDetails: json['completion_tokens_details'] == null
            ? null
            : CompletionTokensDetails.fromJson(
                json['completion_tokens_details'] as Map<String, dynamic>),
        promptTokensDetails: json['prompt_tokens_details'] == null
            ? null
            : PromptTokensDetails.fromJson(
                json['prompt_tokens_details'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => usageToJson(this);

  Map<String, dynamic> usageToJson(Usage instance) => <String, dynamic>{
        'prompt_tokens': instance.promptTokens,
        'completion_tokens': instance.completionTokens,
        'total_tokens': instance.totalTokens,
        'completion_tokens_details': instance.completionTokensDetails?.toJson(),
        'prompt_tokens_details': instance.promptTokensDetails?.toJson(),
      }..removeWhere((key, value) => value == null);
}

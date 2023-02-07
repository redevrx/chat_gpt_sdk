class Usage {
  final int promptTokens;
  final int? completionTokens;
  final int totalTokens;

  Usage(this.promptTokens, this.completionTokens, this.totalTokens);

  factory Usage.fromJson(Map<String,dynamic> json) => Usage(
    json['prompt_tokens'] as int,
    json['completion_tokens'] == null ? 0 : json['completion_tokens'] as int,
    json['total_tokens'] as int,
  );
  Map<String,dynamic> toJson() => _UsageToJson(this);

  Map<String, dynamic> _UsageToJson(Usage instance) => <String, dynamic>{
    'prompt_tokens': instance.promptTokens,
    'completion_tokens': instance.completionTokens,
    'total_tokens': instance.totalTokens,
  };
}
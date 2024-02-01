
class Usage {
  Usage({
    required this.completionTokens,
    required this.promptTokens,
    required this.totalTokens,
  });

  int completionTokens;
  int promptTokens;
  int totalTokens;

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    completionTokens: json["completion_tokens"] ?? 0,
    promptTokens: json["prompt_tokens"] ?? 0,
    totalTokens: json["total_tokens"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "completion_tokens": completionTokens,
    "prompt_tokens": promptTokens,
    "total_tokens": totalTokens,
  };
}
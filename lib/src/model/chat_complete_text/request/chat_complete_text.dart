class ChatCompleteText {
  final List<dynamic> messages;
  final String model;
  final double temperature;
  final int n;
  final int maxTokens;
  final double topP;
  final double frequencyPenalty;
  final double presencePenalty;

  /// ### example use it
  /// - ["You:"]
  ///Q: Who is Batman?
  ///A: Batman is a fictional comic book character.
  /// - Chat bot
  /// [" Human:", " AI:"]
  final List<String>? stop;

  ChatCompleteText(
      {required this.messages,
      required this.model,
      this.temperature = .3,
      this.n = 1,
      this.maxTokens = 100,
      this.topP = 1.0,
      this.frequencyPenalty = .0,
      this.presencePenalty = .0,
      this.stop});

  factory ChatCompleteText.fromJson(Map<String, dynamic> json) =>
      ChatCompleteText(
        messages: json['messages'] as List<dynamic>,
        model: json['model'] as String,
        temperature: (json['temperature'] as num?)?.toDouble() ?? .3,
        n: json['n'] as int? ?? 1,
        maxTokens: json['max_tokens'] as int? ?? 100,
        topP: (json['top_p'] as num?)?.toDouble() ?? 1.0,
        frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble() ?? .0,
        presencePenalty: (json['presence_penalty'] as num?)?.toDouble() ?? .0,
      );
  Map<String, dynamic> toJson() => _CompleteReqToJson(this);

  Map<String, dynamic> _CompleteReqToJson(ChatCompleteText instance) =>
      <String, dynamic>{
        'messages': instance.messages,
        'model': instance.model,
        'temperature': instance.temperature,
        'n': instance.n,
        'max_tokens': instance.maxTokens,
        'top_p': instance.topP,
        'frequency_penalty': instance.frequencyPenalty,
        'presence_penalty': instance.presencePenalty,
        "stop": instance.stop
      };
}

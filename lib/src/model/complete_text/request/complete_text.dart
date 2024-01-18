import 'package:chat_gpt_sdk/src/model/complete_text/enum/model.dart';

class CompleteText {
  final String prompt;

  /// ## completion models
  /// - ModelFromValue(model: 'your-model-name');
  final Model model;
  final double temperature;
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

  CompleteText({
    required this.prompt,
    required this.model,
    this.temperature = .3,
    this.maxTokens = 100,
    this.topP = 1.0,
    this.frequencyPenalty = .0,
    this.presencePenalty = .0,
    this.stop,
  });

  factory CompleteText.fromJson(Map<String, dynamic> json) => CompleteText(
        prompt: json['prompt'] as String,
        model: ModelFromValue(
          model: json['model'].toString(),
        ), //json['model'] as String,
        temperature: (json['temperature'] as num?)?.toDouble() ?? .3,
        maxTokens: json['max_tokens'] as int? ?? 100,
        topP: (json['top_p'] as num?)?.toDouble() ?? 1.0,
        frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble() ?? .0,
        presencePenalty: (json['presence_penalty'] as num?)?.toDouble() ?? .0,
        stop: (json['stop'] as List<String>?),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'prompt': prompt,
        'model': model.model,
        'temperature': temperature,
        'max_tokens': maxTokens,
        'top_p': topP,
        'frequency_penalty': frequencyPenalty,
        'presence_penalty': presencePenalty,
        "stop": stop,
      };
}

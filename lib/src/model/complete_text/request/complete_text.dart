import 'package:chat_gpt_sdk/src/utils/constants.dart';

enum Model {
  textDavinci3,
  textDavinci2,
  codeDavinci2,
  textCurie001,
  textBabbage001,
  textAda001,
  davinci,
  curie,
  babbage,
  ada
}

extension ModelExtension on Model {
  String getName() {
    switch (this) {
      case Model.textDavinci3:
        return kTextDavinci3;
      case Model.textDavinci2:
        return kTextDavinci2;
      case Model.codeDavinci2:
        return kCodeDavinci2;
      case Model.textCurie001:
        return kCodeDavinci2;
      case Model.textBabbage001:
        return kTextBabbage001;
      case Model.textAda001:
        return kTextAda001;
      case Model.davinci:
        return kDavinciModel;
      case Model.curie:
        return kCurieModel;
      case Model.babbage:
        return kBabbageModel;
      case Model.ada:
        return kAdaModel;
      default:
        return "";
    }
  }
}

Model _fromName(String name) {
  for (var value in Model.values) {
    if (value.getName() == name) return value;
  }
  throw ArgumentError.value(name, "name", "No enum value with that name");
}

class CompleteText {
  final String prompt;
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

  CompleteText(
      {required this.prompt,
      required this.model,
      this.temperature = .3,
      this.maxTokens = 100,
      this.topP = 1.0,
      this.frequencyPenalty = .0,
      this.presencePenalty = .0,
      this.stop});

  factory CompleteText.fromJson(Map<String, dynamic> json) => CompleteText(
        prompt: json['prompt'] as String,
        model: _fromName(json['model'].toString()), //json['model'] as String,
        temperature: (json['temperature'] as num?)?.toDouble() ?? .3,
        maxTokens: json['max_tokens'] as int? ?? 100,
        topP: (json['top_p'] as num?)?.toDouble() ?? 1.0,
        frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble() ?? .0,
        presencePenalty: (json['presence_penalty'] as num?)?.toDouble() ?? .0,
        stop: (json['stop'] as List<String>?),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'prompt': prompt,
        'model': model.getName(),
        'temperature': temperature,
        'max_tokens': maxTokens,
        'top_p': topP,
        'frequency_penalty': frequencyPenalty,
        'presence_penalty': presencePenalty,
        "stop": stop
      };
}

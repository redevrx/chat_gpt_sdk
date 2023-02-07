class Choices {
  final String text;
  final int index;
  final dynamic logprobs;
  final String finish_reason;

  Choices(this.text, this.index, this.logprobs, this.finish_reason);

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        json['text'] as String,
        json['index'] as int,
        json['logprobs'],
        json['finish_reason'] as String,
      );

  Map<String, dynamic> toJson() => _ChoicesToJson(this);

  Map<String, dynamic> _ChoicesToJson(Choices instance) => <String, dynamic>{
        'text': instance.text,
        'index': instance.index,
        'logprobs': instance.logprobs,
        'finish_reason': instance.finish_reason,
      };
}

class Choices {
  final String text;
  final int index;
  final dynamic logprobs;
  final String? finishReason;

  Choices(this.text, this.index, this.logprobs, this.finishReason);

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        json['text'],
        json['index'] ,
        json['logprobs'],
        json['finish_reason'],
      );

  Map<String, dynamic> toJson() => choicesToJson(this);

  Map<String, dynamic> choicesToJson(Choices instance) => <String, dynamic>{
        'text': instance.text,
        'index': instance.index,
        'logprobs': instance.logprobs,
        'finish_reason': instance.finishReason,
      };
}

import 'package:chat_gpt_sdk/src/model/chat_complete_text/response/message.dart';

class Choices {
  final Message message;
  final int index;
  final String finish_reason;

  Choices(this.message, this.index, this.finish_reason);

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        Message.fromJson(json['message'] as Map<String, dynamic>),
        json['index'] as int,
        (json['finish_reason'] ?? '') as String,
      );

  Map<String, dynamic> toJson() => _ChoicesToJson(this);

  Map<String, dynamic> _ChoicesToJson(Choices instance) => <String, dynamic>{
        'message': instance.message,
        'index': instance.index,
        'finish_reason': instance.finish_reason,
      };
}

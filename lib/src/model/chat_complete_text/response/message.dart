class Message {
  final String role;
  final String content;

  Message(this.role, this.content);

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        json['role'] as String,
        json['content'] as String,
      );

  Map<String, dynamic> toJson() => _MessageToJson(this);

  Map<String, dynamic> _MessageToJson(Message instance) => <String, dynamic>{
        'role': instance.role,
        'content': instance.content,
      };
}

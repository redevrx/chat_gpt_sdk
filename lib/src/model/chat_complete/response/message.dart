class Message {
  final String role;
  final String content;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";
  final Map<String, dynamic>? functionCall;

  Message({required this.role, required this.content, this.functionCall});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"] ?? "",
        content: json["content"] ?? "",
        functionCall: json["function_call"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
        "function_call": functionCall,
      };
}

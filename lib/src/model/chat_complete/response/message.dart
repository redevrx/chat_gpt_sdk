class Message {
  final String role;
  final String content;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";
  final Map<String, dynamic>? functionCall;
  final Map<String, dynamic>? toolCalls;

  Message({required this.role, required this.content, this.functionCall, this.toolCalls});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"] ?? "",
        content: json["content"] ?? "",
        functionCall: json["function_call"],
        toolCalls: json["tools_call"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
        "function_call": functionCall,
        "tools_call": toolCalls,
      };
}

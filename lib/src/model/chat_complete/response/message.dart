class Message {
  final String role;
  final String content;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";
  final Map<String, dynamic>? functionCall;
  final List<Map<String, dynamic>>? toolCalls;

  Message({
    required this.role,
    required this.content,
    this.functionCall,
    this.toolCalls,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"] ?? "",
        content: json["content"] ?? "",
        functionCall: json["function_call"],
        toolCalls: json['tool_calls'] == null
            ? null
            : List<Map<String, dynamic>>.from(
                json["tool_calls"].map((x) => Map<String, dynamic>.from(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
        "function_call": functionCall,
        "tool_calls": toolCalls,
      };
}

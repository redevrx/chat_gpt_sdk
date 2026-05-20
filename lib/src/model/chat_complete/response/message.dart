import 'package:chat_gpt_sdk/src/model/chat_complete/response/message_audio.dart';

class Message {
  final String role;
  final String content;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";
  final Map<String, dynamic>? functionCall;
  final List<Map<String, dynamic>>? toolCalls;
  final MessageAudio? audio;

  Message({
    required this.role,
    required this.content,
    this.functionCall,
    this.toolCalls,
    this.audio,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"] as String? ?? "",
        content: json["content"] as String? ?? "",
        functionCall: json["function_call"] == null
            ? null
            : Map<String, dynamic>.from(json["function_call"]),
        toolCalls: json['tool_calls'] == null
            ? null
            : List<Map<String, dynamic>>.from(
                (json["tool_calls"] as List? ?? [])
                    .map((x) => Map<String, dynamic>.from(x)),
              ),
        audio: json['audio'] == null
            ? null
            : MessageAudio.fromJson(Map<String, dynamic>.from(json['audio'])),
      );

  Map<String, dynamic> toJson() => {
    "role": role,
    "content": content,
    "function_call": functionCall,
    "tool_calls": toolCalls,
    "audio": audio?.toJson(),
  };
}

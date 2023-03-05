import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class PageChat extends StatefulWidget {
  const PageChat({Key? key}) : super(key: key);

  @override
  _PageChatState createState() => _PageChatState();
}

class _PageChatState extends State<PageChat> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  List<dynamic> listMessage = [];
  late OpenAI openAI;

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: "Your Token",
        baseOption: HttpSetup(receiveTimeout: 6000),
        isLogger: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xf4f4f4f4),
      appBar: AppBar(
        title: const Text("GPT 3.5 Turbo"),
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        const Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }

  void _callOpenApi() async {
    _textController.clear();
    // or messages: listMessage - only if you want to have a fluent conversation
    // or messages: [listMessage.last] - Only if you want to send a message as a question
    final request = ChatCompleteText(
        messages: listMessage,
        model: kGPT35Turbo,
        maxTokens: 200,
        temperature: 0.5);

    dynamic data = await openAI.onChatCompleteText(request: request);
    Message message = data!.choices[0].message;
    ChatMessage chatMessage = ChatMessage(
      message: message,
    );
    setState(() {
      _messages.insert(0, chatMessage);
      listMessage.add(message.toJson());
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    Message message = Message("user", text);
    ChatMessage chatMessage = ChatMessage(
      message: message,
    );
    setState(() {
      _messages.insert(0, chatMessage);
      listMessage.add(message.toJson());
    });
    _callOpenApi();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.message});

  final Message message;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg/120px-ChatGPT_logo.svg.png"),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  message.content,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  message.content,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(child: Text(message.role[0])),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: message.role != 'assistant'
            ? myMessage(context)
            : otherMessage(context),
      ),
    );
  }
}

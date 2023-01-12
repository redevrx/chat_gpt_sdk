import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

class GenImgScreen extends StatefulWidget {
  const GenImgScreen({Key? key}) : super(key: key);

  @override
  State<GenImgScreen> createState() => _GenImgScreenState();
}

class _GenImgScreenState extends State<GenImgScreen> {
  String img = "";
  late ChatGPT openAI;
  StreamSubscription? subscription;

  @override
  void initState() {
    openAI = ChatGPT
    .instance
    .builder("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",
        baseOption: HttpSetup(receiveTimeout: 7000));
    super.initState();
  }

  @override
  void dispose() {
    openAI.genImgClose();
    subscription?.cancel();
    super.dispose();
  }

  void _generateImage() {
    const prompt = "cat eating snake blue red.";

    final request = GenerateImage(prompt,2);
    subscription = openAI.generateImageStream(request)
    .asBroadcastStream()
    .listen((it) {
      setState(() {
        img = "${it.data?.last?.url}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () => _generateImage(),
                  child: const Text("Generate Image"))),
          img == ""
              ? const SizedBox()
              : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(img),
                )
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class GenImgScreen extends StatefulWidget {
  const GenImgScreen({Key? key}) : super(key: key);

  @override
  State<GenImgScreen> createState() => _GenImgScreenState();
}

class _GenImgScreenState extends State<GenImgScreen> {
  String img = "";
  late OpenAI openAI;
  StreamSubscription? subscription;

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: token,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 6)),
        isLog: true);
    super.initState();
  }

  @override
  void dispose() {
    openAI.genImgClose();
    subscription?.cancel();
    super.dispose();
  }

  void _generateImage() async {
    const prompt = "King Snake.";

    final request = GenerateImage(prompt, 1,size: ImageSize.size256,responseFormat: Format.url);
    subscription =
        openAI.generateImageStream(request).asBroadcastStream().listen((it) {
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
              ? const Text("Loading...")
              : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(img),
                )
        ],
      ),
    );
  }
}

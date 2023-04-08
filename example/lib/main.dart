import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:example/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_buttonx/materialButtonX.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TranslateScreen(),
    );
  }
}

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);
  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  /// text controller
  final _txtWord = TextEditingController();

  late OpenAI openAI;

  ///t => translate
  final tController = StreamController<CTResponse?>.broadcast();

  Future<CTResponse?>? _translateFuture;
  void _translateEngToThai() async {
    final request = CompleteText(
        prompt: translateEngToThai(word: _txtWord.text.toString()),
        maxTokens: 200,
        model: Model.TextDavinci3);

    _translateFuture = openAI.onCompletion(request: request);
  }

  /// ### can stop generate prompt
  void cancelAIGenerate() {
    openAI.cancelAIGenerate();
  }

  void getFile() async {
    final response = await openAI.file.get();
    print(response.data);
  }
  
  void uploadFile() async {
    final request = UploadFile(file: EditFile('file-path', 'file-name'),purpose: 'fine-tune');
    final response = await openAI.file.uploadFile(request);
    print(response);
  }

  void delete() async {
    final response = await openAI.file.delete("file-Id");
    print(response);
  }

  void retrieve() async {
    final response = await openAI.file.retrieve("file-Id");
    print(response);
  }

  void retrieveContent() async {
    final response = await openAI.file.retrieveContent("file-Id");
    print(response);
  }

  void audioTranslate() async {
    final mAudio = File('mp3-path');
    final request =
        AudioRequest(file: EditFile(mAudio.path, 'name'), prompt: '...');

    final response = await openAI.audio.translate(request);
  }

  void audioTranscribe() async {
    final mAudio = File('mp3-path');
    final request =
        AudioRequest(file: EditFile(mAudio.path, 'name'), prompt: '...');

    final response = await openAI.audio.transcribes(request);
  }

  void editImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    final response = await openAI.editor.editImage(EditImageRequest(
        image: EditFile("${image?.path}", '${image?.name}'),
        mask: EditFile('file path', 'file name'),
        size: ImageSize.size1024,
        prompt: 'King Snake'));

    print(response.data?.last?.url);

    ///stop edit
    /// openAI.editor.cancelEdit();
  }

  void variation() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final request =
        Variation(image: EditFile('${image?.path}', '${image?.name}'));
    final response = await openAI.editor.variation(request);

    print(response.data?.last?.url);
  }

  void embedding() async {
    final request = EmbedRequest(
        model: EmbedModel.EmbedTextModel,
        input: 'The food was delicious and the waiter');

    final response = await openAI.embed.embedding(request);

    print(response.data.last.embedding);
  }

  void editPrompt() async {
    final response = await openAI.editor.prompt(EditRequest(
        model: EditModel.TextEditModel,
        input: 'What day of the wek is it?',
        instruction: 'Fix the spelling mistakes'));

    print(response.choices.last.text);

    ///stop edit
    /// openAI.editor.cancelEdit();
  }

  ///ID of the model to use. Currently, only and are supported
  ///[kChatGptTurboModel]
  ///[kChatGptTurbo0301Model]
  void _chatGpt3Example() async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: ChatModel.ChatGptTurbo0301Model);

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
  }

  void modelDataList() async {
    final model = await OpenAI.instance.build(token: "").listModel();
  }

  void engineList() async {
    final engines = await OpenAI.instance.build(token: "").listEngine();
  }

  void completeWithSSE() {
    final request = CompleteText(
        prompt: "Hello world", maxTokens: 200, model: Model.TextDavinci3);
    openAI.onCompletionSSE(request: request).listen((it) {
      debugPrint(it.choices.last.text);
    });
  }

  void chatCompleteWithSSE() {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: ChatModel.ChatGptTurboModel);

    openAI.onChatCompletionSSE(request: request).listen((it) {
      debugPrint(it.choices.last.message?.content);
    });
  }

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: token,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20)),
        isLog: true);
    super.initState();
  }

  @override
  void dispose() {
    tController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /**
                 * title translate
                 */
                _titleCard(size),
                /**
                 * input card
                 * insert your text for translate to th.com
                 */
                _inputCard(size),

                /**
                 * card input translate
                 */
                _resultCard(size),
                /**
                 * button translate
                 */
                _btnTranslate()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _navigation(size),
    );
  }

  Widget _btnTranslate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: MaterialButtonX(
                message: "Translate",
                height: 40.0,
                width: 130.0,
                color: Colors.blueAccent,
                icon: Icons.translate,
                iconSize: 18.0,
                radius: 46.0,
                onClick: () => _translateEngToThai())),
      ],
    );
  }

  Widget _resultCard(Size size) {
    return FutureBuilder<CTResponse?>(
      future: _translateFuture,
      builder: (context, snapshot) {
        final text = snapshot.data?.choices.last.text ?? "Loading...";
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 32.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.bottomCenter,
          width: size.width * .86,
          height: size.height * .3,
          decoration: heroCard,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  text,
                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                SizedBox(
                  width: size.width,
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.copy_outlined,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.grey,
                          size: 22.0,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Padding _navigation(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
      child: Container(
        width: size.width * .8,
        height: size.height * .06,
        decoration: heroNav,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(50.0)),
              child: const Icon(
                Icons.translate,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const Icon(
              Icons.record_voice_over_outlined,
              color: Colors.indigoAccent,
              size: 22.0,
            ),
            const Icon(
              Icons.favorite,
              color: Colors.indigoAccent,
              size: 22.0,
            ),
            const Icon(
              Icons.person,
              color: Colors.indigoAccent,
              size: 22.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _titleCard(Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32.0),
      width: size.width * .86,
      height: size.height * .08,
      decoration: heroCard,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  "https://www.clipartmax.com/png/middle/200-2009207_francais-english-italiano-english-flag-icon-flat.png",
                  fit: BoxFit.cover,
                  width: 30.0,
                  height: 30.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "Eng",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ),
              Transform.rotate(
                angle: -pi / 2,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16.0,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.swap_horiz_outlined,
              color: Colors.grey,
              size: 22.0,
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/197/197452.png",
                  fit: BoxFit.cover,
                  width: 30.0,
                  height: 30.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "Thai",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ),
              Transform.rotate(
                angle: -pi / 2,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16.0,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _inputCard(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.bottomCenter,
      width: size.width * .86,
      height: size.height * .25,
      decoration: heroCard,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
              controller: _txtWord,
              maxLines: 6,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              width: size.width,
              child: const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.copy_outlined,
                    color: Colors.grey,
                    size: 22.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.record_voice_over_outlined,
                      color: Colors.grey,
                      size: 22.0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## ChatGPT Application with flutter
ChatGPT is a chatbot launched by OpenAI in November 2022. It is built on top 
of OpenAI's GPT-3.5 family of large language models, and is fine-tuned with both 
supervised and reinforcement learning techniques.

## Install Package
```dart
chat_gpt: 2.0.4
```

## Example

Create ChatGPT Instance
 - Parameter
   - Token
     - Your secret API keys are listed below. Please note that we do not display your secret API keys again after you generate them. 
     - Do not share your API key with others, or expose it in the browser or other client-side code. In order to protect the security of your account, OpenAI may also automatically rotate any API key that we've found has leaked publicly.
     - https://beta.openai.com/account/api-keys
  - OrgId
     - Identifier for this organization sometimes used in API requests
     - https://beta.openai.com/account/org-settings

```dart
final openAI = OpenAI.instance.build(token: token,baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),isLogger: true);
```

- Text Complete API
  - Translate Method
    - translateEngToThai
    - translateThaiToEng
    - translateToJapanese
  - Model
    - kTranslateModelV3
    - kTranslateModelV2
    - kCodeTranslateModelV2
      - Translate natural language to SQL queries.
      - Create code to call the Stripe API using natural language.
      - Find the time complexity of a function.
  - https://beta.openai.com/examples

```dart
final request = CompleteText(prompt: translateEngToThai(word: ''),
                model: kTranslateModelV3, maxTokens: 200);

 openAI.onCompletionStream(request:request).listen((response) => print(response))
        .onError((err) {
          print("$err");
  });
```

- Complete with StreamBuilder
```dart
final tController = StreamController<CTResponse?>.broadcast();

openAI
        .onCompletionStream(request: request)
.asBroadcastStream()
        .listen((res) {
tController.sink.add(res);
});

///ui code
StreamBuilder<CTResponse?>(
 stream: tController.stream,
 builder: (context, snapshot) {
   final data = snapshot.data;
   if(snapshot.connectionState == ConnectionState.done) return something 
   if(snapshot.connectionState == ConnectionState.waiting) return something
   return something
})
```

- Complete with Feature

```dart
  void _translateEngToThai() async{
  final request = CompleteText(
          prompt: translateEngToThai(word: _txtWord.text.toString()),
          max_tokens: 200,
          model: kTranslateModelV3);

  final response = await openAI.onCompletion(request: request);
  print(response);
}
```

- Example Q&A 
  - Answer questions based on existing knowledge.
```dart
final request = CompleteText(prompt:'What is human life expectancy in the United States?'),
                model: kTranslateModelV3, maxTokens: 200);

 openAI.onCompletionStream(request:request).listen((response) => print(response))
        .onError((err) {
           print("$err");
});
```
- Request
 
```dart
Q: What is human life expectancy in the United States?
```

- Response

```dart
A: Human life expectancy in the United States is 78 years.
```

- Support ChatGPT 3.5 Turbo

```dart
  void _chatGpt3Example() async {
  final request = ChatCompleteText(messages: [
    Map.of({"role": "user", "content": 'Hello!'})
  ], maxToken: 200, model: kChatGptTurbo0301Model);

  final response = await openAI.onChatCompletion(request: request);
  for (var element in response!.choices) {
    print("data -> ${element.message.content}");
  }
}
```


- Generate Image
  - prompt
    - A text description of the desired image(s). The maximum length is 1000 characters.
  - n
    - The number of images to generate. Must be between 1 and 10.
  - size
    - The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
  - response_format
    - The format in which the generated images are returned. Must be one of url or b64_json.
  - user
    - A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
- 
- Generate with stream
```dart
  openAI = OpenAI
        .instance
        .builder(toekn:"token",
         baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),isLogger:true);

const prompt = "Snake Red";

final request = GenerateImage(prompt,2);

               openAI.generateImageStream(request)
              .asBroadcastStream()
              .listen((it) {
                print(it.data?.last?.url)
              });

/// cancel stream controller
openAI.genImgClose();
```
- Generate with feature
```dart
  void _generateImage() {
  const prompt = "cat eating snake blue red.";

  final request = GenerateImage(prompt,2);
  final response = openAI.generateImage(request);
  print("img url :${response.data?.last?.url}");
}
```


- Model List
  - List and describe the various models available in the API. You can refer to the Models documentation to 
  understand what models are available and the differences between them.
  - https://beta.openai.com/docs/api-reference/models

```dart
final models = await openAI.listModel();
```

- Engine List
  - Lists the currently available (non-finetuned) models, and provides basic 
  information about each one such as the owner and availability.
  - https://beta.openai.com/docs/api-reference/engines

```dart
final engines = await openAI.listEngine();
```

## Flutter Example

```dart
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

  void _translateEngToThai() async {
    final request = CompleteText(
            prompt: translateEngToThai(word: _txtWord.text.toString()),
            maxTokens: 200,
            model: kTextDavinci3);

    openAI.onCompletionStream(request: request).asBroadcastStream().listen((res) {
      tController.sink.add(res);
    }).onError((err) {
      print("$err");
    });
  }

  ///ID of the model to use. Currently, only and are supported
  ///[kChatGptTurboModel]
  ///[kChatGptTurbo0301Model]
  void _chatGpt3Example() async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: kChatGptTurbo0301Model);

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message.content}");
    }
  }

  void _chatGpt3ExampleStream() async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: kChatGptTurbo0301Model);

    openAI.onChatCompletionStream(request: request).listen((it) {
      debugPrint("${it?.choices.last.message}");
    }).onError((err) {
      print(err);
    });
  }

  void modelDataList() async {
    final model = await OpenAI.instance.build(token: "").listModel();
  }

  void engineList() async {
    final engines = await OpenAI.instance.build(token: "").listEngine();
  }

  @override
  void initState() {
    openAI = OpenAI.instance.build(
            token: token,
            baseOption: HttpSetup(
                    receiveTimeout: const Duration(seconds: 5),
                    connectTimeout: const Duration(seconds: 5)),
            isLogger: true);
    super.initState();
  }

  @override
  void dispose() {
    ///close stream complete text
    openAI.close();
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
                        onClick: () =>_translateEngToThai())),
      ],
    );
  }

  Widget _resultCard(Size size) {
    return StreamBuilder<CTResponse?>(
      stream: tController.stream,
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
```

<img src="https://scontent.fkkc3-1.fna.fbcdn.net/v/t39.30808-6/321956306_528473869217638_4959635231571092650_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=YumrmcfO7jAAX9N9Ygd&tn=aWCijFs0IEeQXzfE&_nc_ht=scontent.fkkc3-1.fna&oh=00_AfCQk9ebz2qnPl2pshugchDnaEXMPe6rogXpdzc3UCfcmg&oe=63EF77E4" width="350" height="760">

### Video Tutorials
 - <a href='https://www.youtube.com/watch?v=qUEUMxGW_0Q&ab_channel=idealBy'>Flutter Chat bot</a>

 - <a href='https://www.youtube.com/watch?v=z25HfnEi2zQ&t=1s&ab_channel=idealBy'>Flutter Generate Image</a>
 

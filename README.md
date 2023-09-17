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

# ChatGPT Application with flutter
ChatGPT is a chat-bot launched by OpenAI in November 2022. It is built on top
of OpenAI's GPT-3.5 family of large language models, and is fine-tuned with both
supervised and reinforcement learning techniques.

## Unofficial
"community-maintained” library.

# OpenAI Powerful Library Support GPT-4
<br>
<p align="center">
<img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/redevRx/Flutter-ChatGPT">
<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/redevRx/Flutter-ChatGPT">
<img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/redevRx/Flutter-ChatGPT?style=social">
<img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/redevRx/Flutter-ChatGPT/dart.yml?label=tests">
<img alt="GitHub" src="https://img.shields.io/github/license/redevRx/Flutter-ChatGPT">
<img alt="Pub Points" src="https://img.shields.io/pub/points/chat_gpt_sdk">
<img alt="Pub Popularity" src="https://img.shields.io/pub/popularity/chat_gpt_sdk">
<img alt="Pub Likes" src="https://img.shields.io/pub/likes/chat_gpt_sdk">
<img alt="Pub Version" src="https://img.shields.io/pub/v/chat_gpt_sdk">
<img alt="Code Coverage" src="https://img.shields.io/codecov/c/github/redevrx/chat_gpt_sdk?logo=codecov&color">
</p>
</br>



## Features

- [x] [Install Package](#install-package)
- [x] [Create OpenAI Instance](#create-openai-instance)
- [x] [Change Access Token](#change-access-token)
- [x] [Complete Text](#complete-text)
  - Support Server Sent Event
- [x] [Chat Complete GPT-4](#chat-complete-gpt-4-and-gpt-35)
  - Support GPT3.5 and GPT-4 
  - Support Server Sent Event
  - Support Function Calling
- [x] [Error Handle](#error-handle)
- [x] [Example Q&A](#qa)
- [x] [Generate Image With Prompt](#generate-image-with-prompt)
- [x] [Editing](#edit)
- [x] [Cancel Generate](#cancel-generate)
- [x] [File](#file)
- [x] [Audio](#audio)
- [x] [Embedding](#embedding)
- [x] [Fine-Tune](#fine-tune)
  - Support Server Sent Event
  - Fine-Tune Deprecate
  - New Fine-Tune Job
- [x] [Moderations](#modelengine)
- [x] [Model And Engine](#modelengine)
- [x] [Translate Example](#translate-app)
- [x] [Video Tutorial](#video-tutorials)
- [x] [Docs](#docs-support-thai)



## Install Package
```dart
chat_gpt_sdk: 2.2.5
```

## Create OpenAI Instance

 - Parameter
   - Token
     - Your secret API keys are listed below. Please note that we do not display your secret API keys again after you generate them. 
     - Do not share your API key with others, or expose it in the browser or other client-side code. In order to protect the security of your account, OpenAI may also automatically rotate any API key that we've found has leaked publicly.
     - https://beta.openai.com/account/api-keys
  - OrgId
     - Identifier for this organization sometimes used in API requests
     - https://beta.openai.com/account/org-settings

```dart
final openAI = OpenAI.instance.build(token: token,baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);
```
## Change Access Token

```dart
openAI.setToken('new-access-token');
///get toekn
openAI.token;
```

## Complete Text
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

- Complete with Feature

```dart
  void _translateEngToThai() async{
  final request = CompleteText(
          prompt: translateEngToThai(word: _txtWord.text.toString()),
          maxToken: 200,
          model: TextDavinci3Model());

  final response = await openAI.onCompletion(request: request);
  
  ///cancel request
  openAI.cancelAIGenerate();
  print(response);
}
```

- Complete with FutureBuilder
```dart
Future<CTResponse?>? _translateFuture;

_translateFuture = openAI.onCompletion(request: request);

///ui code
FutureBuilder<CTResponse?>(
 future: _translateFuture,
 builder: (context, snapshot) {
   final data = snapshot.data;
   if(snapshot.connectionState == ConnectionState.done) return something 
   if(snapshot.connectionState == ConnectionState.waiting) return something
   return something
})
```

- GPT-3 with SSE
```dart
 void completeWithSSE() {
  final request = CompleteText(
          prompt: "Hello world", maxTokens: 200, model: TextDavinci3Model());
  openAI.onCompletionSSE(request: request).listen((it) {
    debugPrint(it.choices.last.text);
  });
}
```

## Chat Complete (GPT-4 and GPT-3.5)

- GPT-4 
```dart
  void chatComplete() async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: Gpt4ChatModel());

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
  }
```

- GPT-4 with SSE(Server Send Event)
```dart
 void chatCompleteWithSSE() {
  final request = ChatCompleteText(messages: [
    Map.of({"role": "user", "content": 'Hello!'})
  ], maxToken: 200, model: Gpt4ChatModel());

  openAI.onChatCompletionSSE(request: request).listen((it) {
    debugPrint(it.choices.last.message?.content);
  });
}
```

- Support SSE(Server Send Event)
  - GPT-3.5 Turbo
```dart
 void chatCompleteWithSSE() {
  final request = ChatCompleteText(messages: [
    Map.of({"role": "user", "content": 'Hello!'})
  ], maxToken: 200, model: GptTurboChatModel());

  openAI.onChatCompletionSSE(request: request).listen((it) {
    debugPrint(it.choices.last.message?.content);
  });
}
```
- Chat Complete

```dart
  void chatComplete() async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: GptTurbo0301ChatModel());

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
  }
```

- Chat Complete Function Calling

```dart
/// work only with gpt-turbo-0613,gpt-4-0613
  void gptFunctionCalling() async {
  final request = ChatCompleteText(
          messages: [
            Messages(
                    role: Role.user, content: "What is the weather like in Boston?",name: "get_current_weather"),
          ],
          maxToken: 200,
          model: GptTurbo0631Model(),
          functions: [
            FunctionData(
                    name: "get_current_weather",
                    description: "Get the current weather in a given location",
                    parameters: {
                      "type": "object",
                      "properties": {
                        "location": {
                          "type": "string",
                          "description": "The city and state, e.g. San Francisco, CA"
                        },
                        "unit": {
                          "type": "string",
                          "enum": ["celsius", "fahrenheit"]
                        }
                      },
                      "required": ["location"]
                    })
          ],
          functionCall: FunctionCall.auto);

  ChatCTResponse? response = await openAI.onChatCompletion(request: request);
}
```

## Error Handle

```dart
///using catchError
 openAI.onCompletion(request: request)
    .catchError((err){
      if(err is OpenAIAuthError){
        print('OpenAIAuthError error ${err.data?.error?.toMap()}');
      }
      if(err is OpenAIRateLimitError){
        print('OpenAIRateLimitError error ${err.data?.error?.toMap()}');
      }
      if(err is OpenAIServerError){
        print('OpenAIServerError error ${err.data?.error?.toMap()}');
      }
      });

///using try catch
 try {
   await openAI.onCompletion(request: request);
 } on OpenAIRateLimitError catch (err) {
   print('catch error ->${err.data?.error?.toMap()}');
 }

///with stream
 openAI
        .onCompletionSSE(request: request)
        .transform(StreamTransformer.fromHandlers(
          handleError: (error, stackTrace, sink) {
              if (error is OpenAIRateLimitError) {
              print('OpenAIRateLimitError error ->${error.data?.message}');
              }}))
        .listen((event) {
          print("success");
        });
```

## Q&A
- Example Q&A 
  - Answer questions based on existing knowledge.
```dart
final request = CompleteText(prompt:'What is human life expectancy in the United States?'),
                model: TextDavinci3Model(), maxTokens: 200);

 final response = await openAI.onCompletion(request:request);
```
- Request
 
```dart
Q: What is human life expectancy in the United States?
```

- Response

```dart
A: Human life expectancy in the United States is 78 years.
```

## Generate Image With Prompt

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

- Generate with feature
```dart
  void _generateImage() {
  const prompt = "cat eating snake blue red.";

  final request = GenerateImage(prompt, 1,size: ImageSize.size256,
          responseFormat: Format.url);
  final response = openAI.generateImage(request);
  print("img url :${response.data?.last?.url}");
}
```
## Edit
- Edit Prompt
```dart
void editPrompt() async {
    final response = await openAI.editor.prompt(EditRequest(
        model: CodeEditModel(),
        input: 'What day of the wek is it?',
        instruction: 'Fix the spelling mistakes'));

    print(response.choices.last.text);
  }
```

- Edit Image
```dart
 void editImage() async {
  final response = await openAI.editor.editImage(EditImageRequest(
          image: EditFile("${image?.path}", '${image?.name}'),
          mask: EditFile('file path', 'file name'),
          size: ImageSize.size1024,
          prompt: 'King Snake'));

  print(response.data?.last?.url);
}
```

- Variations 
```dart
  void variation() async {
  final request =
  Variation(image: EditFile('${image?.path}', '${image?.name}'));
  final response = await openAI.editor.variation(request);

  print(response.data?.last?.url);
}
```
## Cancel Generate

- Stop Generate Prompt
```dart
 _openAI
        .onChatCompletionSSE(request: request, onCancel: onCancel);

///CancelData
CancelData? mCancel;
void onCancel(CancelData cancelData) {
  mCancel = cancelData;
}

mCancel?.cancelToken.cancel("canceled ");
```

- Stop Edit
  - image
  - prompt
```dart
openAI.edit.editImage(request,onCancel: onCancel);

///CancelData
CancelData? mCancel;
void onCancel(CancelData cancelData) {
  mCancel = cancelData;
}

mCancel?.cancelToken.cancel("canceled edit image");
```

- Stop Embedding
```dart
openAI.embed.embedding(request,onCancel: onCancel);

///CancelData
CancelData? mCancel;
void onCancel(CancelData cancelData) {
  mCancel = cancelData;
}

mCancel?.cancelToken.cancel("canceled embedding");
```

- Stop Audio
  - translate
  - transcript
```dart
openAI.audio.transcribes(request,onCancel: onCancel);

///CancelData
CancelData? mCancel;
void onCancel(CancelData cancelData) {
  mCancel = cancelData;
}

mCancel?.cancelToken.cancel("canceled audio transcribes");
```

- Stop File
  - upload file
  - get file
  - delete file
```dart
openAI.file.uploadFile(request,onCancel: onCancel);

///CancelData
CancelData? mCancel;
void onCancel(CancelData cancelData) {
  mCancel = cancelData;
}

mCancel?.cancelToken.cancel("canceled uploadFile");
```

## File

- Get File
```dart
void getFile() async {
  final response = await openAI.file.get();
  print(response.data);
}
```

- Upload File
```dart
void uploadFile() async {
  final request = UploadFile(file: EditFile('file-path', 'file-name'),purpose: 'fine-tune');
  final response = await openAI.file.uploadFile(request);
  print(response);
}
```

- Delete File
```dart
  void delete() async {
  final response = await openAI.file.delete("file-Id");
  print(response);
}
```

- Retrieve File
```dart
  void retrieve() async {
  final response = await openAI.file.retrieve("file-Id");
  print(response);
}
```

- Retrieve Content File
```dart
  void retrieveContent() async {
  final response = await openAI.file.retrieveContent("file-Id");
  print(response);
}
```

## Audio

- Audio Translate
```dart
void audioTranslate() async {
  final mAudio = File('mp3-path');
  final request =
  AudioRequest(file: EditFile(mAudio.path, 'name'), prompt: '...');

  final response = await openAI.audio.translate(request);
}
```

- Audio Transcribe
```dart
void audioTranscribe() async {
  final mAudio = File('mp3-path');
  final request =
  AudioRequest(file: EditFile(mAudio.path, 'name'), prompt: '...');

  final response = await openAI.audio.transcribes(request);
}
```
## Embedding

- Embedding
```dart
void embedding() async {
  final request = EmbedRequest(
          model: TextSearchAdaDoc001EmbedModel(),
          input: 'The food was delicious and the waiter');

  final response = await openAI.embed.embedding(request);

  print(response.data.last.embedding);
}
```

## Fine Tune

- Create Fine Tune
```dart
void createTineTune() async {
  final request = CreateFineTuneJob(trainingFile: 'The ID of an uploaded file');
  final response = await openAI.fineTune.createFineTuneJob(request);
}
```

- Fine Tune List
```dart
 void tineTuneList() async {
    final response = await openAI.fineTune.listFineTuneJob();
  }
```

- Fine Tune List Stream (SSE)
```dart
 void tineTuneListStream() {
    openAI.fineTune.listFineTuneJobStream('fineTuneId').listen((it) {
      ///handled data
    });
  }
```

-  Fine Tune Get by Id
```dart
void tineTuneById() async {
    final response = await openAI.fineTune.retrieveFineTuneJob('fineTuneId');
  }
```

- Cancel Fine Tune
```dart
  void tineTuneCancel() async {
    final response = await openAI.fineTune.cancel('fineTuneId');
  }
```

- Delete Fine Tune
```dart
 void deleteTineTune() async {
    final response = await openAI.fineTune.delete('model');
  }
```

## Moderations

- Create Moderation
```dart
  void createModeration() async {
  final response = await openAI.moderation
          .create(input: 'input', model: TextLastModerationModel());
}
```

## Model&Engine

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

## Translate App

<img src="https://github.com/redevrx/chat_gpt_sdk/blob/main/assets/example/translate_ui.jpg?raw=true" width="350" height="760">

## ChatGPT Demo App
[![Google Play](https://img.shields.io/badge/Google%20Play-Download-blue?logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.redevrx.openai.app.openai_app)

<img src="https://github.com/redevrx/chat_gpt_sdk/blob/main/assets/example/Screenshot_1684672351.png?raw=true" width="350" height="760">
<img src="https://github.com/redevrx/chat_gpt_sdk/blob/main/assets/example/Screenshot_1684672512.png?raw=true" width="350" height="760">
<img src="https://github.com/redevrx/chat_gpt_sdk/blob/main/assets/example/Screenshot_1684672715.png?raw=true" width="350" height="760">



## Video Tutorials
 - <a href='https://www.youtube.com/watch?v=qUEUMxGW_0Q&ab_channel=idealBy'>Flutter Chat bot</a>

 - <a href='https://www.youtube.com/watch?v=z25HfnEi2zQ&t=1s&ab_channel=idealBy'>Flutter Generate Image</a>
 

## Docs (Support Thai)
 <p align="center">
 <a target="_blank" href="https://medium.com/@relalso/flutter-chatgpt-part-1-สอน-2268197247f8"><img src="https://github-readme-medium-recent-article.vercel.app/medium/@relalso/2" alt="ChatGPT Part 1">
 <a target="_blank" href="https://medium.com/@relalso/flutter-chatgpt-part-2-สอน-e2935ad4f963"><img src="https://github-readme-medium-recent-article.vercel.app/medium/@relalso/1" alt="ChatGPT Part 2">
 <a target="_blank" href="https://medium.com/@relalso/flutter-chatgpt-part-2-สอน-e2935ad4f963"><img src="https://github-readme-medium-recent-article.vercel.app/medium/@relalso/0" alt="ChatGPT Part 2">
</p>

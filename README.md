# ChatGPT & OpenAI SDK for Flutter
A powerful, production-ready Dart and Flutter SDK for OpenAI's advanced APIs, supporting the latest generative models like **GPT-5**, **GPT-5-mini**, **GPT-4o**, **GPT-4o-mini**, **DALL-E 3**, and advanced reasoning models such as **o1** and **o3-mini**.

## Unofficial
"community-maintained” library.

# OpenAI Powerful Library Supporting GPT-5, GPT-4o, GPT-4o-mini & o1/o3-mini Reasoning Models
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
  - [Complete with Feature](#complete-with-feature) 
  - [Support Server Sent Event](#gpt-3-with-sse)
- [x] [Chat Complete (GPT-5, GPT-4o, GPT-4o-mini, and Reasoning Models)](#chat-complete-gpt-5-gpt-4o-gpt-4o-mini-and-reasoning-models)
  - [Support GPT-4o & GPT-4o-mini](#chat-complete-with-gpt-4o-mini)
  - [Support Server Sent Event (SSE Streaming)](#chat-complete-streaming-sse-with-gpt-4o)
  - [Support Function Calling & Tool Calls](#chat-complete-function-calling)
  - [OpenAI Reasoning Models (o1, o3-mini)](#openai-reasoning-models-o1-o3-mini)
  - [Modern OpenAI Features](#modern-openai-features)
  - [Chat Complete Image/Vision Input](#chat-complete-imagevision-input)
  - [Chat Complete Structured Outputs (JSON Schema)](#chat-complete-structured-outputs-json-schema)
- [x] [Assistants API](#assistants)
  - [Create assistant](#create-assistant)
  - [Create assistant file](#create-assistant-file) 
  - [List assistants](#list-assistants)
  - [List assistant files](#list-assistants-files)
  - [Retrieve assistant](#retrieve-assistant)
  - [Retrieve assistant file](#retrieve-assistant-file)
  - [Modify assistant](#modify-assistant)
  - [Delete assistant](#delete-assistant)
  - [Delete assistant file](#delete-assistant-file)
- [Threads](#threads)
  - [Create thread](#create-threads)
  - [Retrieve thread](#retrieve-thread)
  - [Modify thread](#modify-thread)
  - [Delete thread](#delete-thread)
- [Messages](#messages)
  - [Create message](#create-message)
  - [List messages](#list-messages)
  - [List message files](#list-message-files)
  - [Retrieve message](#retrieve-message)
  - [Retrieve message file](#retrieve-message-file)
  - [Modify message](#modify-message)
- [Runs](#runs)
  - [Create run](#create-run)
  - [Create thread and run](#create-thread-and-run)
  - [List runs](#list-runs)
  - [List run steps](#list-run-steps)
  - [Retrieve run](#retrieve-run)
  - [Retrieve run step](#retrieve-run-step)
  - [Modify run](#modify-run)
  - [Submit tool outputs to run](#submit-tool-outputs-to-run)
  - [Cancel a run](#cancel-a-run)
- [x] [Error Handle](#error-handle)
- [x] [Example Q&A](#qa)
- [x] [Generate Image With Prompt](#generate-image-with-prompt)
- [x] [Edit](#edit)
  - [Edit Prompt](#edit-prompt)
  - [Edit Image](#edit-image)
  - [Variations](#variations)
- [x] [Cancel Generate](#cancel-generate)
  - [Stop Generate Prompt](#stop-generate-prompt)
  - [Stop Edit](#stop-edit)
  - [Stop Embedding](#stop-embedding)
- [x] [File](#file)
  - [Get File](#get-file)
  - [Upload File](#upload-file)
  - [Delete File](#delete-file)
  - [Retrieve File](#retrieve-file)
  - [Retrieve Content File](#retrieve-content-file)
- [x] [Audio](#audio)
  - [Audio Translate](#audio-translate)
  - [Audio Transcribe](#audio-transcribe)
  - [Create speech](#create-speech)
- [x] [Embedding](#embedding)
- [x] [Fine-Tune](#fine-tune)
  - [Create Fine Tune](#create-fine-tune) 
  - [Fine Tune List](#fine-tune-list)
  - [Fine Tune List Stream (SSE)](#fine-tune-list-stream)
  - [Fine Tune Get by Id](#fine-tune-get-by-id)
  - [Cancel Fine Tune](#cancel-fine-tune)
- [x] [Moderations](#moderations)
  - [Create Moderation](#create-moderation)
- [x] [Prompt Caching](#prompt-caching)
- [x] [Audio Completions (Audio Input & Output)](#audio-completions)
- [x] [Project & Organization Management](#project-and-organization-management)
  - [Project Management](#project-management)
  - [User Management](#user-management)
- [x] [Responses API](#responses-api)
- [x] [Model and Engine](#model-and-engine)
- [x] [Translate Example](#translate-app)
- [x] [Video Tutorial](#video-tutorials)
- [x] [Docs](#docs-support-thai)



## Install Package
```dart
chat_gpt_sdk: 3.1.6
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
///get token
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

- ### Complete with Feature

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

- ### GPT 3 with SSE
```dart
 void completeWithSSE() {
  final request = CompleteText(
          prompt: "Hello world", maxTokens: 200, model: TextDavinci3Model());
  openAI.onCompletionSSE(request: request).listen((it) {
    debugPrint(it.choices.last.text);
  });
}
```

## Chat Complete (GPT-5, GPT-4o, GPT-4o-mini, and Reasoning Models)

- ### Chat Complete with GPT-4o-mini
```dart
  void chatComplete() async {
    final request = ChatCompleteText(
      messages: [
        Map.of({"role": "user", "content": 'Hello!'})
      ], 
      maxToken: 200, 
      model: Gpt4oMiniChatModel(),
    );

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
  }
```

- ### Chat Complete Streaming (SSE) with GPT-4o
```dart
 void chatCompleteWithSSE() {
  final request = ChatCompleteText(
    messages: [
      Map.of({"role": "user", "content": 'Explain photosynthesis in one sentence.'})
    ], 
    maxToken: 200, 
    model: Gpt4OChatModel(),
  );

  openAI.onChatCompletionSSE(request: request).listen((it) {
    debugPrint(it.choices.last.message?.content);
  });
}
```

- ### Chat Complete Function Calling

```dart
  void gptFunctionCalling() async {
    final request = ChatCompleteText(
      messages: [
        Messages(
                role: Role.user,
                content: "What is the weather like in Boston?",
                name: "get_current_weather"),
      ],
      maxToken: 200,
      model: Gpt4oMiniChatModel(),
      tools: [
        {
          "type": "function",
          "function": {
            "name": "get_current_weather",
            "description": "Get the current weather in a given location",
            "strict": true, // Enable Structured Outputs for tool
            "parameters": {
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
              "required": ["location", "unit"], // Must require all properties when strict is true
              "additionalProperties": false    // Must be false for Structured Outputs
            }
          }
        }
      ],
      toolChoice: 'auto',
    );

    ChatCTResponse? response = await openAI.onChatCompletion(request: request);
}
```

- ### OpenAI Reasoning Models (o1, o3-mini)

Support for OpenAI's latest reasoning models (`o1`, `o1-preview`, `o1-mini`, `o3-mini`) and their specialized API parameters:
- `reasoningEffort`: Controls how much thinking time the model uses (`"low"`, `"medium"`, `"high"`).
- `maxCompletionTokens`: The preferred token limit parameter for reasoning and generation in newer models. Set `maxToken` to `null` to let `maxCompletionTokens` govern.

```dart
  void reasoningModelChat() async {
    final request = ChatCompleteText(
      model: O3MiniChatModel(), // or O1ChatModel(), O1MiniChatModel()
      messages: [
        Map.of({"role": "user", "content": 'Write a quicksort algorithm in Dart'})
      ],
      temperature: 1.0, // Reasoning models support temperature 1.0
      maxToken: null, // Set maxToken to null to let maxCompletionTokens govern
      reasoningEffort: 'medium', // 'low' | 'medium' | 'high'
      maxCompletionTokens: 2000,
    );

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
    
    // Check total tokens used and reasoning details
    print("Total Tokens: ${response.usage?.totalTokens}");
    print("Prompt Tokens: ${response.usage?.promptTokens}");
    print("Completion Tokens: ${response.usage?.completionTokens}");
    print("Reasoning Tokens: ${response.usage?.completionTokensDetails?.reasoningTokens}");
  }
```

- ### Modern OpenAI Features

The SDK fully supports modern OpenAI API capabilities:
- **`Role.developer` / `Role.tool`**: Direct support for the new developer-guided messages and tool execution responses.
- **`store`**: Enable or disable storing chat completion outputs for training/evaluations (`store: true`).
- **`metadata`**: Add key-value tags to keep track of requests (`metadata: {"env": "production"}`).
- **`parallelToolCalls`**: Control if the model can trigger multiple functions in one turn (`parallelToolCalls: false`).
- **`streamOptions`**: Request token usage statistics in the streaming chunks (`streamOptions: {"include_usage": true}`).

```dart
  void chatWithModernFeatures() async {
    final request = ChatCompleteText(
      model: Gpt4OChatModel(),
      messages: [
        Messages(
          role: Role.developer,
          content: 'You are an advanced software engineer.',
        ).toJson(),
        Messages(
          role: Role.user,
          content: 'What is the current system status?',
        ).toJson(),
      ],
      parallelToolCalls: false,
      store: true,
      metadata: {
        'customer_id': '12345',
        'env': 'production',
      },
      stream: true,
      streamOptions: {
        'include_usage': true,
      },
      maxToken: null,
    );

    openAI.onChatCompletionSSE(request: request).listen((it) {
      debugPrint(it.choices.last.message?.content);
      
      // When streamOptions is included, the last chunk will contain the usage stats
      if (it.usage != null) {
        print("Stream Total Tokens: ${it.usage?.totalTokens}");
        print("Stream Reasoning Tokens: ${it.usage?.completionTokensDetails?.reasoningTokens}");
      }
    });
  }
```

- ### Chat Complete Image/Vision Input

```dart
  void imageInput() async {
  final request = ChatCompleteText(
    messages: [
      {
        "role": "user",
        "content": [
          {"type": "text", "text": "What’s in this image?"},
          {
            "type": "image_url",
            "image_url": {"url": "image-url"}
          }
        ]
      }
    ],
    maxToken: 200,
    model: Gpt4OChatModel(),
  );

  ChatCTResponse? response = await openAI.onChatCompletion(request: request);
  debugPrint("$response");
}
```

- ### Chat Complete Structured Outputs (JSON Schema)

Ensure the model's responses adhere strictly to your provided JSON schema. Use the type-safe `ResponseFormat.jsonSchema(...)` API:

```dart
  void structuredOutputExample() async {
    final request = ChatCompleteText(
      model: Gpt4OChatModel(),
      messages: [
        Map.of({"role": "user", "content": "Solve 2x + 5 = 15. Provide step-by-step reasoning."})
      ],
      // Supply a type-safe ResponseFormat configuration
      responseFormat: ResponseFormat.jsonSchema(
        jsonSchema: JsonSchema(
          name: "math_response",
          schema: {
            "type": "object",
            "properties": {
              "steps": {
                "type": "array",
                "items": {
                  "type": "object",
                  "properties": {
                    "explanation": {"type": "string"},
                    "output": {"type": "string"}
                  },
                  "required": ["explanation", "output"],
                  "additionalProperties": false
                }
              },
              "final_answer": {"type": "string"}
            },
            "required": ["steps", "final_answer"],
            "additionalProperties": false
          },
        ),
      ),
    );

    final response = await openAI.onChatCompletion(request: request);
    // The response content is guaranteed to match the exact schema structural layout
    print("Structured JSON: ${response?.choices.first.message?.content}");
  }
```
```

## Assistants
- ### Create Assistant
```dart
  void createAssistant() async {
  final assistant = Assistant(
    model: Gpt4oMiniModel(),
    name: 'Math Tutor',
    instructions:
    'You are a personal math tutor. When asked a question, write and run Python code to answer the question.',
    tools: [
      {
        "type": "code_interpreter",
      }
    ],
  );
  await openAI.assistant.create(assistant: assistant);
}

```

- ### Create Assistant File
```dart
void createAssistantFile() async {
  await openAI.assistant.createFile(assistantId: '',fileId: '',);
}
```

- ### List assistants
```dart
  void listAssistant() async {
  final assistants = await openAI.assistant.list();
  assistants.map((e) => e.toJson()).forEach(print);
}
```

- ### List assistants files
```dart
  void listAssistantFile() async {
  final assistants = await openAI.assistant.listFile(assistantId: '');
  assistants.data.map((e) => e.toJson()).forEach(print);
}
```

- ### Retrieve assistant
```dart
  void retrieveAssistant() async {
  final assistants = await openAI.assistant.retrieves(assistantId: '');
}
```

- ### Retrieve assistant file
```dart
  void retrieveAssistantFiles() async {
  final assistants = await openAI.assistant.retrievesFile(assistantId: '',fileId: '');
}
```

- ### Modify assistant
```dart
  void modifyAssistant() async {
  final assistant = Assistant(
    model: Gpt4OModel(),
    instructions:
    'You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.',
    tools: [
      {
        "type": "retrieval",
      }
    ],
    fileIds: [
      "file-abc123",
      "file-abc456",
    ],
  );
  await openAI.assistant.modifies(assistantId: '', assistant: assistant);
}
```

- ### Delete assistant
```dart
  void deleteAssistant() async {
  await openAI.assistant.delete(assistantId: '');
}
```

- ### Delete assistant file
```dart
  void deleteAssistantFile() async {
  await openAI.assistant.deleteFile(assistantId: '',fileId: '');
}
```

## Threads
 - ### Create threads
```dart
///empty body
  void createThreads()async {
  await openAI.threads.createThread(request: ThreadRequest());
}

///with message
void createThreads() async {
  final request = ThreadRequest(messages: [
    {
      "role": "user",
      "content": "Hello, what is AI?",
      "file_ids": ["file-abc123"]
    },
    {
      "role": "user",
      "content": "How does AI work? Explain it in simple terms."
    },
  ]);

  await openAI.threads.createThread(request: request);
}
```

- ### Retrieve thread
```dart
 void retrieveThread()async {
  final mThread = await openAI.threads.retrieveThread(threadId: 'threadId');
}
```

- ### Modify thread
```dart
  void modifyThread() async {
  await openAI.threads.modifyThread(threadId: 'threadId', metadata: {
    "metadata": {
      "modified": "true",
      "user": "abc123",
    },
  });
}
```

- ### Delete thread
```dart
  void deleteThread() async {
  await openAI.threads.deleteThread(threadId: 'threadId');
}
```

## Messages
- ### Create Message
```dart
void createMessage() async {
  final request = CreateMessage(
    role: 'user',
    content: 'How does AI work? Explain it in simple terms.',
  );
  await openAI.threads.messages.createMessage(
    threadId: 'threadId',
    request: request,
  );
}
```

- ### List messages
```dart
  void listMessage()async {
  final mMessages = await openAI.threads.messages.listMessage(threadId: 'threadId');
}
```
- ### List message files
```dart
  void listMessageFile() async {
  final mMessagesFile = await openAI.threads.messages.listMessageFile(
    threadId: 'threadId',
    messageId: '',
  );
}
```

- ### Retrieve message
```dart
  void retrieveMessage() async {
  final mMessage = await openAI.threads.messages.retrieveMessage(
    threadId: 'threadId',
    messageId: '',
  );
}
```

- ### Retrieve message file
```dart
void retrieveMessageFile() async {
  final mMessageFile = await openAI.threads.messages.retrieveMessageFile(
    threadId: 'threadId',
    messageId: '',
    fileId: '',
  );
}
```

- ### Modify message
```dart
  void modifyMessage() async {
  await openAI.threads.messages.modifyMessage(
    threadId: 'threadId',
    messageId: 'messageId',
    metadata: {
      "metadata": {"modified": "true", "user": "abc123"},
    },
  );
}
```

## Runs
- ### Create run
```dart
void createRun() async {
    final request = CreateRun(assistantId: 'assistantId');
    await openAI.threads.runs.createRun(threadId: 'threadId', request: request);
  }
```

- ### Create thread and run
```dart
  void createThreadAndRun() async {
    final request = CreateThreadAndRun(assistantId: 'assistantId', thread: {
      "messages": [
        {"role": "user", "content": "Explain deep learning to a 5 year old."}
      ],
    });
    await openAI.threads.runs.createThreadAndRun(request: request);
  }
```

- ### List runs
```dart
 void listRuns() async {
   final mRuns = await openAI.threads.runs.listRuns(threadId: 'threadId');
  }
```

- ### List run steps
```dart
void listRunSteps() async {
   final mRunSteps = await openAI.threads.runs.listRunSteps(threadId: 'threadId',runId: '',);
  }
```

- ### Retrieve run
```dart
void retrieveRun() async {
   final mRun = await openAI.threads.runs.retrieveRun(threadId: 'threadId',runId: '',);
  }
```

- ### Retrieve run step
```dart
 void retrieveRunStep() async {
   final mRun = await openAI.threads.runs.retrieveRunStep(threadId: 'threadId',runId: '',stepId: '');
  }
```

- ### Modify run
```dart
void modifyRun() async {
    await openAI.threads.runs.modifyRun(
      threadId: 'threadId',
      runId: '',
      metadata: {
        "metadata": {"user_id": "user_abc123"},
      },
    );
  }
```

- ### Submit tool outputs to run
```dart
  void submitToolOutputsToRun() async {
    await openAI.threads.runs.submitToolOutputsToRun(
      threadId: 'threadId',
      runId: '',
      toolOutputs: [
        {
          "tool_call_id": "call_abc123",
          "output": "28C",
        },
      ],
    );
  }
```

- ### Cancel a run
```dart
  void cancelRun() async {
    await openAI.threads.runs.cancelRun(
      threadId: 'threadId',
      runId: '',
    );
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

- ### Generate with feature
```dart
  void _generateImage() {
  const prompt = "cat eating snake blue red.";

  final request = GenerateImage( model: DallE2(),prompt, 1,size: ImageSize.size256,
          responseFormat: Format.url);
  final response = openAI.generateImage(request);
  print("img url :${response.data?.last?.url}");
}
```

## Edit
- ### Edit Prompt
```dart
void editPrompt() async {
    final response = await openAI.editor.prompt(EditRequest(
        model: CodeEditModel(),
        input: 'What day of the wek is it?',
        instruction: 'Fix the spelling mistakes'));

    print(response.choices.last.text);
  }
```

- ### Edit Image
```dart
 void editImage() async {
  final response = await openAI.editor.editImage(EditImageRequest(
          image: FileInfo("${image?.path}", '${image?.name}'),
          mask: FileInfo('file path', 'file name'),
          size: ImageSize.size1024,
          prompt: 'King Snake'),
          model: DallE3(),);

  print(response.data?.last?.url);
}
```

- ### Variations
```dart
  void variation() async {
  final request =
  Variation(model: DallE2(),image: FileInfo('${image?.path}', '${image?.name}'));
  final response = await openAI.editor.variation(request);

  print(response.data?.last?.url);
}
```
## Cancel Generate

- ### Stop Generate Prompt
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

- ### Stop Edit
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

- ### Stop Embedding
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

- ### Get File
```dart
void getFile() async {
  final response = await openAI.file.get();
  print(response.data);
}
```

- ### Upload File
```dart
void uploadFile() async {
  final request = UploadFile(file: FileInfo('file-path', 'file-name'),purpose: 'fine-tune');
  final response = await openAI.file.uploadFile(request);
  print(response);
}
```

- ### Delete File
```dart
  void delete() async {
  final response = await openAI.file.delete("file-Id");
  print(response);
}
```

- ### Retrieve File
```dart
  void retrieve() async {
  final response = await openAI.file.retrieve("file-Id");
  print(response);
}
```

- ### Retrieve Content File
```dart
  void retrieveContent() async {
  final response = await openAI.file.retrieveContent("file-Id");
  print(response);
}
```

## Audio

- ### Audio Translate
```dart
void audioTranslate() async {
  final mAudio = File('mp3-path');
  final request =
  AudioRequest(file: FileInfo(mAudio.path, 'name'), prompt: '...');

  final response = await openAI.audio.translate(request);
}
```

- ### Audio Transcribe
```dart
void audioTranscribe() async {
  final mAudio = File('mp3-path');
  final request =
  AudioRequest(file: FileInfo(mAudio.path, 'name'), prompt: '...');

  final response = await openAI.audio.transcribes(request);
}
```

- ### Create speech
```dart
  void createSpeech() async {
  final request = SpeechRequest(
          model: 'tts-1', input: 'The quick brown fox jumped over the lazy dog.');

  final List<int> response = await openAI.audio
          .createSpeech(request: request);
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

- ### Create Fine Tune
```dart
void createTineTune() async {
  final request = CreateFineTuneJob(trainingFile: 'The ID of an uploaded file');
  final response = await openAI.fineTune.createFineTuneJob(request);
}
```

- ### Fine Tune List
```dart
 void tineTuneList() async {
    final response = await openAI.fineTune.listFineTuneJob();
  }
```

- ### Fine Tune List Stream
```dart
 void tineTuneListStream() {
    openAI.fineTune.listFineTuneJobStream('fineTuneId').listen((it) {
      ///handled data
    });
  }
```

-  ### Fine Tune Get by Id
```dart
void tineTuneById() async {
    final response = await openAI.fineTune.retrieveFineTuneJob('fineTuneId');
  }
```

- ### Cancel Fine Tune
```dart
  void tineTuneCancel() async {
    final response = await openAI.fineTune.cancelFineTuneJob('fineTuneId');
  }
```

## Moderations

- ### Create Moderation
```dart
  void createModeration() async {
  final response = await openAI.moderation
          .create(input: 'input', model: TextLastModerationModel());
}
```

## Prompt Caching

OpenAI automatically applies prompt caching for supported models. You can retrieve caching statistics from the usage data of chat completions:

```dart
  void checkPromptCaching() async {
    final request = ChatCompleteText(
      messages: [
        Map.of({"role": "user", "content": "Explain quantum computing in detail."})
      ],
      maxToken: 1000,
      model: Gpt4OChatModel(),
    );

    final response = await openAI.onChatCompletion(request: request);
    
    // Read total/cached tokens
    print("Total Prompt Tokens: ${response?.usage?.promptTokens}");
    print("Cached Tokens: ${response?.usage?.promptTokensDetails?.cachedTokens}");
  }
```

## Audio Completions

You can now use Chat Completions with native support for audio input and output. Specify the desired audio output configurations and receive base64 encoded audio responses.

```dart
  void chatAudioCompletion() async {
    final request = ChatCompleteText(
      model: Gpt4OChatModel(),
      messages: [
        Map.of({"role": "user", "content": "Tell me a joke out loud."})
      ],
      // request both text and audio outputs
      modalities: ['text', 'audio'],
      audio: ChatAudioConfig(
        voice: 'alloy',
        format: 'wav',
      ),
    );

    final response = await openAI.onChatCompletion(request: request);
    for (var choice in response!.choices) {
      final message = choice.message;
      if (message != null) {
        print("Text response: ${message.content}");
        
        // Handle audio data output
        final audioData = message.audio;
        if (audioData != null) {
          print("Audio ID: ${audioData.id}");
          print("Audio Expires At: ${audioData.expiresAt}");
          print("Audio Data (Base64 WAV): ${audioData.data}");
          print("Audio Transcript: ${audioData.transcript}");
        }
      }
    }
  }
```

## Project and Organization Management

Manage your projects, organizations, API limits, and user access programmatically.

### Project Management
```dart
  void projectManagementExample() async {
    // 1. List Projects
    final listRes = await openAI.projectAndOrg.listProjects(limit: 10);
    print("Projects: ${listRes.data.map((p) => p.name).toList()}");

    // 2. Create a new project
    final newProject = await openAI.projectAndOrg.createProject(name: "New Flutter Dev Project");
    print("Created project ID: ${newProject.id}");

    // 3. Retrieve a specific project
    final proj = await openAI.projectAndOrg.retrieveProject(projectId: newProject.id);
    print("Retrieved project: ${proj.name}");

    // 4. Modify a project name
    final modifiedProj = await openAI.projectAndOrg.modifyProject(
      projectId: newProject.id, 
      name: "Updated Flutter Dev Project Name",
    );
    print("Updated project name: ${modifiedProj.name}");

    // 5. Archive a project
    final archivedProj = await openAI.projectAndOrg.archiveProject(projectId: newProject.id);
    print("Project archived status: ${archivedProj.status}");
  }
```

### User Management
```dart
  void userManagementExample() async {
    // 1. List Organization Users
    final listUserRes = await openAI.projectAndOrg.listUsers(limit: 5);
    print("Users: ${listUserRes.data.map((u) => u.email).toList()}");

    // 2. Retrieve a specific user
    if (listUserRes.data.isNotEmpty) {
      final userId = listUserRes.data.first.id;
      final user = await openAI.projectAndOrg.retrieveUser(userId: userId);
      print("User Email: ${user.email}, Role: ${user.role}");

      // 3. Modify user role
      final modifiedUser = await openAI.projectAndOrg.modifyUserRole(
        userId: userId, 
        role: "admin", // "owner" | "admin" | "member"
      );
      print("New User Role: ${modifiedUser.role}");

      // 4. Remove/delete user from organization
      final deleteUserRes = await openAI.projectAndOrg.deleteUser(userId: userId);
      print("User deleted: ${deleteUserRes.deleted}");
    }
  }
```
## Responses API

The Responses API (`/v1/responses`) is designed for advanced development, code generation, and complex unified reasoning workflows utilizing modern models (such as `gpt-4o`, `gpt-4o-mini`, `o1`, `o3-mini`, etc.). It lets you specify inputs, models, optional reasoning parameters, background tasks, and includes a flexible Polymorphic output structure.

### Main Request Model: `OpenAiResponseRequest`
* `model`: The model to use for this response (e.g., `gpt-4o`, `o3-mini`).
* `input`: The input to the model. Can be a `String` (simple prompt) or a `List` of structured message objects (e.g. system, developer, user messages).
* `reasoning`: Optional map defining reasoning configurations (e.g., `{'effort': 'medium'}`).
* `background`: Run the model response in the background when set to `true`.
* `conversation`: Optional unique conversation ID or object.
* `include`: Optional list of additional data fields to return.
* `tools`: A list of tools the model may call (e.g. `[{"type": "web_search"}]`).
* `toolChoice`: Controls which (if any) tool is called by the model (e.g., `'auto'`).

### Convenience Output Getter
The response model `OpenAiResponseData` has a convenience property `outputText` which automatically traverses nested output items and content parts to return the first generated text block (`type == 'output_text'`).

### Usage Example

```dart
void responsesApiExample() async {
  // 1. Simple Text Input
  final requestSimple = OpenAiResponseRequest(
    model: 'gpt-4o',
    input: 'Explain the theory of relativity in one simple sentence.',
    reasoning: {'effort': 'medium'},
  );

  final responseSimple = await openAI.onResponse(request: requestSimple);
  print("Response Output: ${responseSimple?.outputText}");

  // 2. Structured Messages Input (Developer instructions + User query)
  final requestMessages = OpenAiResponseRequest(
    model: 'gpt-4o',
    input: [
      {
        'role': 'developer',
        'content': 'You are a highly efficient software architect expert in Flutter and Dart.',
      },
      {
        'role': 'user',
        'content': 'Write a generic Repository interface in Dart.',
      }
    ],
  );

  final responseMessages = await openAI.onResponse(request: requestMessages);

  // Easily extract the main output text using the convenience getter:
  print("Generated Code:\n${responseMessages?.outputText}");

  // Access detailed usage metrics
  print("Total Tokens: ${responseMessages?.usage?.totalTokens}");
  print("Prompt Tokens: ${responseMessages?.usage?.promptTokens}");
  print("Completion Tokens: ${responseMessages?.usage?.completionTokens}");

  // 3. Unified Reasoning with Native Web Search
  final requestSearch = OpenAiResponseRequest(
    model: 'gpt-4o',
    input: 'Who won the UEFA Champions League this season?',
    tools: [
      {'type': 'web_search'}
    ],
    toolChoice: 'auto',
  );

  final responseSearch = await openAI.onResponse(request: requestSearch);
  print("Search Output:\n${responseSearch?.outputText}");
}
```

## Model and Engine

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

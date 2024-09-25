## 1.0.1+4
  - Fix bug  Http status error [429] error

## 1.0.1+5
 Add Parameter HttpSetup 
  - sendTimeout  
  - connectTimeout
  - receiveTimeout

## 1.0.2
  New Feature
   - Generation Image With Prompt
   - 
## 1.0.2 + 1
 - Fix Bug

## 1.0.2 + 3
- Fix Bug
- Add stop field in complete request
- New example
- Bloc code complete and error

## 1.0.2 + 4
 - Refactor and Fix Bug

## 2.0.0
- add b64 field in response generate image

## 2.0.1
- update client library
- change method name
  - onCompleteText as onCompletion
  - onCompleteStream as onCompletionStream
- Support ChatGPT 3.5 turbo
  - Add new Model
  - kChatGptTurboModel
  - kChatGptTurbo0301Model
  - New Method
  - onChatCompletion
  - onChatCompletionStream

## 2.0.2
- Fix bug
- change top_p to topP in ChatComplete

## 2.0.5
- HttpSetup add proxy
- Generate Image Change parameter to enum

## 2.0.6
- Deprecated Methods
  - onChatCompletionStream
  - onCompletionStream
- Support Stream Parameter Make SSE With Generate Prompt
  - onCompletionSSE
  - onChatCompletionSSE


## 2.0.7
- Update
  - Stop Generating prompt Method
  - parentId message in response data
  - change model string to enum type

## 2.0.8
- Features
  - Edit 
    - Edit Prompt
    - Edit Image
    - Variations
  - Cancel Generate
    - Complete Text
    - Chat Complete
    - Edit
    - File
    - Audio
    - Embedding
  - File
    - Get File
    - Upload File
    - Delete File
    - Retrieve File
    - Retrieve Content File
  - Audio
    - Audio Translate
    - Audio Transcribe
  - Embedding
  - Update README

## 2.0.9
- Features
  - Fine-tunes
    - Create Fine tune
    - Fine Tune List
    - Fine Tune List Stream (SSE)
    - Retrieve
    - Cancel
    - Delete
  - Moderation's
- Remove Method Deprecate

## 2.1.0
 - Fix Bug
 - Chat Complete SSE change json name
 - update docs

## 2.1.3
 - Add New Error Handle
 - change isLog to enableLog

## 2.1.4
- Add New Error Handle

## 2.1.5
- Add New Error Handle

## 2.1.6
-  New Handle Cancel Request
-  Add New Example Cancel Request

## 2.1.7
-  Change Response name

## 2.1.8
-  Fig but convert type error

## 2.1.9
-  new models data
- completion custom model
- chat complete custom model
- fineTune custom model
- embedded custom model
- edit custom model

## 2.2.0
- update new model
  - gpt-4-0613
  - gpt-3.5-turbo-0613
- Support Function calling

## 2.2.1
- Fig dio deprecate method

## 2.2.2
- Fig openai function call require parameter name

## 2.2.3
- Fig openai optional error with null value

## 2.2.4
- add header orgId 

## 2.2.5
- Update Fine-Tuning
  - Add recommended model
    - gpt-3.5-turbo-0613
  - Deprecate Model
    - CurieFineModel()
    - AdaFineModel()
  - FineTuned Deprecate Method
    - create
    - list
    - retrieve
    - cancel
    - delete
    - listStream
  - New API
    - createFineTuneJob
    - listFineTuneJob
    - retrieveFineTuneJob
    - cancelFineTuneJob
    - cancelFineTuneJobStream

## 2.2.6
 - Fix Bug Chunks error

## 2.2.8
 - Update Lib from community
  - missing first word in sse response
  - Fix sse bad state close 
  - sse not work as intended
  - custom OpenAI endpoint

# 3.0.0
 - Update OpenAi Model
 - Add New Model Generate Image
 - Add Assistants API

# 3.0.1
- Audio 
  - Fix create transcribes error
  - Create speech
- Embedding 
  - Add new Model
- Thread
  - Create a thread.
  - Retrieves a thread.
  - Modifies a thread.
  - Delete a thread.
- Message
  - Create a message.
  - List messages
  - List message files
  - Retrieve message
  - Retrieve message file
  - Modify message
- Run
  - Create a run.
  - Create a thread and run it in one request.
  - List runs
  - List run steps
  - Retrieves a run.
  - Retrieve run step
  - Modifies a run.
  - Submit tool outputs to run
  - Cancel a run
# 3.0.2
 - Fix bugs
## 3.0.3
 - Fix bugs
 - Update Demo App

## 3.0.4
- Fix bugs
- Update Assistant Model
- Add Support Tools to Json
- Update Generate Image Request

## 3.0.5
- Fix Assistant Data Json parsing bug

## 3.0.7
- Fix list run case id is null
- Message add runId
- Add fix for assistant_data json parsing

## 3.0.8
  - Assistants Add gpt4o model
  - Complete Add gpt4o model

## 3.0.9
- Assistants v2
- Deprecate API

## 3.1.0
 - Add Gpt 4o mini
 - Add Doc API version 2 (Assistants v2)

## 3.1.1
  - Update sdk

## 3.1.2
  - Update sdk
  - remove path provider
## 1.0.1+4

Fix bug  Http status error [429] error

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

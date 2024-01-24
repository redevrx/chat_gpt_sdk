import 'package:chat_gpt_sdk/src/model/chat_complete/enum/chat_model.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/enum/function_call.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/function_data.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/response_format.dart';

class ChatCompleteText {
  ///ID of the model to use. Currently, only gpt-3.5-turbo and
  /// gpt-3.5-turbo-0301 are supported. [model]
  ///[kChatGptTurboModel]
  ///[kChatGptTurbo0301Model]
  ///
  /// ## models list
  /// - GptTurboChatModel();
  /// - GptTurbo0301ChatModel();
  /// - Gpt4ChatModel();
  /// - Gpt40314ChatModel();
  /// - Gpt432kChatModel();
  /// - Gpt432k0314ChatModel();
  /// - ChatModelFromValue(model: 'your-model-name')
  ///
  final ChatModel model;

  ///The messages to generate chat completions for,
  /// in the chat format. [messages]
  final List<Map<String, dynamic>> messages;

  ///A list of functions the model may generate JSON inputs for.
  ///[functions]
  @Deprecated('using tools')
  final List<FunctionData>? functions;

  ///Controls how the model responds to function calls.
  /// "none" means the model does not call a function,
  /// and responds to the end-user. "auto" means the model
  /// can pick between an end-user or calling a function.
  /// Specifying a particular function via forces the model to
  /// call that function. "none" is the default when no functions
  /// are present. "auto" is the default if functions are present.{"name":\ "my_function"}
  /// [functionCall]
  @Deprecated('using tools')
  final FunctionCall? functionCall;

  ///Defines the format of the model's response output. Currently, only supports
  /// "json_object", and it is available only for certain models.
  /// [responseFormat]
  final ResponseFormat? responseFormat;

  ///What sampling temperature to use, between 0 and
  ///2. Higher values like 0.8 will make the output more random,
  ///while lower values like 0.2 will make it more focused and deterministic.
  ///We generally recommend altering this or top_p but not both. [temperature]
  final double? temperature;

  ///An alternative to sampling with temperature, called nucleus sampling,
  /// where the model considers the results of the tokens with top_p probability
  /// mass. So 0.1 means only the tokens comprising the top 10% probability
  /// mass are considered.
  ///We generally recommend altering this or temperature but not both. [topP]
  final double? topP;

  ///A list of tools the model may call. Currently,
  /// only functions are supported as a tool.
  /// Use this to provide a list of functions
  /// the model may generate JSON inputs for.
  /// [tools]
  /**
   * ## Example
   * ```dart
   * final tools = [
      {
      "type": "function",
      "function": {
      "name": "get_current_weather",
      "description": "Get the current weather in a given location",
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
      "required": ["location"]}}},
      ]
   * ```
   */
  final List<Map<String, dynamic>>? tools;

  ///[toolChoice]
  /// ### Type String or Map
  ///Controls which (if any) function is called by the model.
  /// none means the model will not call a function and instead
  /// generates a message. auto means the model can pick between
  /// generating a message or calling a function.
  /// Specifying a particular function via
  /// {"type": "function", "function": {"name": "my_function"}}
  /// forces the model to call that function.none is the default when no
  /// functions are present. auto is the default if functions are present.
  final dynamic toolChoice;

  ///How many chat completion choices to generate for each input message. [n]
  final int? n;

  ///If set, partial message deltas will be sent, like in ChatGPT.
  /// Tokens will be sent as data-only server-sent events as they become
  /// available, with the stream terminated by a data: [DONE] message. [stream]
  final bool? stream;

  ///Up to 4 sequences where the API will stop generating further tokens. [stop]
  /// ### example use it
  /// - ["You:"]
  ///Q: Who is Batman?
  ///A: Batman is a fictional comic book character.
  /// - Chat bot
  /// [" Human:", " AI:"]
  final List<String>? stop;

  ///The maximum number of tokens allowed for the generated answer. By default,
  /// the number of tokens the model can return will be (4096 - prompt tokens).
  /// [maxToken]
  final int? maxToken;

  ///Number between -2.0 and 2.0. Positive values penalize new tokens based on
  /// whether they appear in the text so far, increasing the model's likelihood
  /// to talk about new topics. [presencePenalty]
  final double? presencePenalty;

  ///Number between -2.0 and 2.0. Positive values penalize new tokens based on
  /// their existing frequency in the text so far, decreasing the model's
  /// likelihood to repeat the same line verbatim. [frequencyPenalty]
  final double? frequencyPenalty;

  ///Modify the likelihood of specified tokens appearing in the completion.
  /// Accepts a json object that maps tokens
  /// (specified by their token ID in the tokenizer) to an associated bias value
  /// from -100 to 100. Mathematically, the bias is added to the logits generated
  /// by the model prior to sampling. The exact effect will vary per model, but
  /// values between -1 and 1 should decrease or increase likelihood of selection;
  /// values like -100 or 100 should result in a ban or exclusive selection of the
  /// relevant token. [logitBias]
  final Map<String, dynamic>? logitBias;

  ///Whether to return log probabilities of the output tokens or not.
  /// If true, returns the log probabilities of each output token returned
  /// in the content of message. This option is currently not available on
  /// the gpt-4-vision-preview model.
  /// [logprobs]
  final bool logprobs;

  ///An integer between 0 and 5 specifying the number of most
  /// likely tokens to return at each token position,
  /// each with an associated log probability.
  /// logprobs must be set to true if this parameter is used.
  /// [topLogprobs]
  final int? topLogprobs;

  ///This feature is in Beta.
  /// If specified, our system will make a best effort to sample
  /// deterministically, such that repeated requests with the same seed
  /// and parameters should return the same result. Determinism is not
  /// guaranteed, and you should refer to the system_fingerprint response
  /// parameter to monitor changes in the backend.
  /// [seed]
  final int? seed;

  ///A unique identifier representing your end-user, which can help OpenAI
  ///to monitor and detect abuse.[user]
  final String? user;

  ChatCompleteText({
    required this.model,
    required this.messages,
    this.temperature = .3,
    this.topP = 1.0,
    this.n = 1,
    this.stream = false,
    this.stop,
    this.maxToken = 100,
    this.presencePenalty = .0,
    this.frequencyPenalty = .0,
    this.user = "",
    this.functions,
    this.functionCall,
    this.responseFormat,
    this.logprobs = false,
    this.logitBias,
    this.topLogprobs,
    this.seed,
    this.tools,
    this.toolChoice,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json;
    json = Map.of({
      "model": model.model,
      "messages": messages,
      "temperature": temperature,
      "top_p": topP,
      "n": n,
      "stream": stream,
      "stop": stop,
      "max_tokens": maxToken,
      "presence_penalty": presencePenalty,
      "frequency_penalty": frequencyPenalty,
      "user": user,
      "response_format": responseFormat?.toJson(),
      "logit_bias": logitBias,
      "logprobs": logprobs,
      "top_logprobs": topLogprobs,
      "seed": seed,
      "tool_choice": toolChoice,
    })
      ..removeWhere((key, value) => value == null);

    return json;
  }
}

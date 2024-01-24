import 'dart:async';
import 'dart:io';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:openai_app/bloc/openai/openai_state.dart';
import 'package:openai_app/constants/constants.dart';
import 'package:openai_app/models/message/message.dart';
import 'package:openai_app/service/shred_preference/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class OpenAIBloc extends Cubit<OpenAIState> {
  OpenAIBloc() : super(OpenAIInitialState());

  ///[_shared]
  final _shared = GetIt.instance.get<SharedPreferences>();

  ///[_openAI]
  late OpenAI _openAI;

  ///[_txtInput]
  final _txtToken = TextEditingController();

  ///[getTxtToken]
  TextEditingController getTxtToken() => _txtToken;

  void onSetToken(
      {required Function() success, required Function() error}) async {
    if (getToken() == "") {
      error();
    } else {
      saveToken(
          success: () {
            _openAI.setToken(getToken());
            success();
          },
          error: error);
    }
  }

  @Deprecated('use textController')
  void tokenChange({required String token}) async {
    if (token == "") {
      await _shared.setString(SharedRefKey.kAccessToken, "");
    }
    await _shared.setString(SharedRefKey.kAccessToken, token);
  }

  ///save token
  ///[saveToken]
  void saveToken(
      {required Function() success, required Function() error}) async {
    if (_txtToken.value.text == "") {
      error();
      await _shared.setString(SharedRefKey.kAccessToken, "");
    } else {
      await _shared.setString(SharedRefKey.kAccessToken, _txtToken.value.text);
      success();
    }
  }

  String getToken() {
    _txtToken.text = _shared.getString(SharedRefKey.kAccessToken) ?? "";
    return _txtToken.value.text;
  }

  bool _getVersion() => _shared.getBool(SharedRefKey.kGPTVersion) ?? false;

  ///[initOpenAISdk]
  void initOpenAISdk() async {
    _openAI = OpenAI.instance.build(
        token: getToken(),
        apiUrl:
            'https://api.openai.com/v1/', // you can replace with your api url
        enableLog: true,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 30),
            connectTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30)));
  }

  void openAIEvent(String event, {required Function() error}) {
    if (_txtInput.value.text == "") {
      error();
    } else {
      switch (event) {
        case FeatureType.kCompletion:
          sendWithPrompt();
          break;
        case FeatureType.kGenerateImage:
          generateImage();
          break;
        case FeatureType.kGrammar:
          textDavinci();
          break;
        case FeatureType.kQuestionInterview:
          textDavinci();
          break;
      }
    }
  }

  ///messages of chat
  List<Message> list = [];
  void sendWithPrompt() async {
    ///update user chat message
    list.add(Message(isBot: false, message: getTextInput().value.text));
    emit(ChatCompletionState(
        isBot: false, messages: list, showStopButton: true));

    ///start send request
    final request = ChatCompleteText(
        model: _getVersion() ? Gpt4ChatModel() : GptTurboChatModel(),
        messages: [
          Messages(role: Role.user, content: getTextInput().value.text)
              .toJson(),
        ],
        maxToken: 400);

    ///clear text
    getTextInput().text = "";

    _openAI
        .onChatCompletionSSE(request: request, onCancel: onCancel)
        .transform(StreamTransformer.fromHandlers(handleError: handleError))
        .listen((it) {
      Message? message;
      list.removeWhere((element) {
        if (element.id == '${it.id}') {
          message = element;
          return true;
        }
        return false;
      });

      ///+= message
      String msg =
          '${message?.message ?? ""}${it.choices.last.message?.content ?? ""}';
      list.add(Message(isBot: true, id: '${it.id}', message: msg));
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: true));
    }, onDone: () {
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: false));
    });
  }

  ///generate image with prompt
  ///[generateImage]
  void generateImage() async {
    final request = GenerateImage(_txtInput.value.text, 1,
        model: DallE3(), size: ImageSize.size1024, responseFormat: Format.url);

    ///update user chat message
    list.add(Message(isBot: false, message: getTextInput().value.text));
    emit(ChatCompletionState(
        isBot: false, messages: list, showStopButton: true));

    ///clear text
    _txtInput.text = "";

    try {
      ///start request
      final response = await _openAI.generateImage(request, onCancel: onCancel);

      ///add new message
      list.add(Message(
          isBot: true,
          message: response?.data != [] ? response?.data?.last?.url : ""));
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: false));
    } on OpenAIAuthError catch (_) {
      ///return state auth error
      emit(AuthErrorState());
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: false));
    } on OpenAIRateLimitError catch (_) {
      ///return state rate limit error
      emit(RateLimitErrorState());
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: false));
    } on OpenAIServerError catch (_) {
      ///return state server error
      emit(OpenAIServerErrorState());
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: false));
    }
  }

  void textDavinci() async {
    ///update user chat message
    list.add(Message(isBot: false, message: getTextInput().value.text));
    emit(ChatCompletionState(
        isBot: false, messages: list, showStopButton: true));

    ///setup request body
    final request = CompleteText(
        prompt: _txtInput.value.text,
        maxTokens: 400,
        model: Gpt3TurboInstruct());

    ///clear text
    _txtInput.text = "";

    ///send request
    _openAI
        .onCompletionSSE(request: request, onCancel: onCancel)
        .transform(StreamTransformer.fromHandlers(handleError: handleError))
        .listen((it) {
      ///new message object
      Message? message;
      for (final m in list) {
        if (m.id == it.id) {
          message = m;
          list.remove(m);
          break;
        }
      }

      ///+= message
      message?.message = '${message.message ?? ""}${it.choices.last.text}';

      ///add new message
      list.add(Message(isBot: true, message: message?.message, id: it.id));
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: true));
    }, onDone: () {
      emit(ChatCompletionState(
          isBot: true, messages: list, showStopButton: false));
    });
  }

  void clearMessage() {
    list = [];
  }

  CancelData? mCancel;
  void onCancel(CancelData cancelData) {
    mCancel = cancelData;
  }

  void handleError(Object error, StackTrace t, EventSink<dynamic> eventSink) {
    emit(ChatCompletionState(
        isBot: true, messages: list, showStopButton: false));
    if (error is OpenAIAuthError) {
      emit(AuthErrorState());
    }
    if (error is OpenAIRateLimitError) {
      emit(RateLimitErrorState());
    }
    if (error is OpenAIServerError) {
      emit(OpenAIServerErrorState());
    }
  }

  void onStopGenerate() {
    emit(ChatCompletionState(
        isBot: true, messages: list, showStopButton: false));
    mCancel?.cancelToken.cancel("canceled ");
  }

  void openSettingSheet(bool isOpen) {
    isOpen = isOpen;
    emit(OpenSettingState(isOpen: isOpen));
  }

  ///isHasToken
  ///[isHasToken]
  void isHasToken({required Function() success, required Function() error}) {
    if (getToken() == "") {
      error();
    } else {
      success();
    }
  }

  /// text controller
  final _txtInput = TextEditingController();
  TextEditingController getTextInput() => _txtInput;
  void closeTextInput() {
    getTextInput().clear();
  }

  void closeOpenAIError() => emit(CloseOpenAIErrorUI());

  void isFirstSetting(
      {required Function() success, required Function() error}) {
    if (_shared.getBool(SharedRefKey.kIsFistSetting) == true) {
      success();
    } else {
      _shared.setBool(SharedRefKey.kIsFistSetting, true);
      error();
    }
  }

  ///download image from bot chat
  void downloadImage(String url,
      {required Function() success,
      required Function(String message) error}) async {
    try {
      final response = await get(Uri.parse(url));

      /// Get temporary directory
      const path = "/storage/emulated/0/Download";
      final createDirect = Directory("$path/openai");
      if (await createDirect.exists()) {
      } else {
        await createDirect.create(recursive: true);
      }

      /// Create an image name
      var filename = '$path/${DateTime.now().microsecondsSinceEpoch}.png';

      /// Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      if (await file.exists()) {
        success();
      }
    } catch (err) {
      error('path have problem.');
    }
  }

  @override
  Future<void> close() {
    _txtInput.dispose();
    _txtInput.dispose();
    return super.close();
  }
}

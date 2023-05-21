import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:openai_app/bloc/openai/openai_state.dart';
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
      saveToken(success: () => null, error: () => null);
      _openAI.setToken(getToken());
      success();
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

  ///select gpt4
  void onSetGpt4() async {
    ///keep chat gpt version
    await _shared.setBool(SharedRefKey.kGPTVersion, true);
    emit(OpenAIGptVersionState(isGPT4: true));
  }

  ///select gpt3.5
  void onSetGpt3() async {
    ///keep chat gpt version
    await _shared.setBool(SharedRefKey.kGPTVersion, false);
    emit(OpenAIGptVersionState(isGPT4: false));
  }

  ///gpt version
  ///[getVersion]
  void getVersion() => emit(OpenAIGptVersionState(isGPT4: _getVersion()));

  String getToken() {
    _txtToken.text = _shared.getString(SharedRefKey.kAccessToken) ?? "";
    return _txtToken.value.text;
  }

  bool _getVersion() => _shared.getBool(SharedRefKey.kGPTVersion) ?? false;

  ///[initOpenAISdk]
  void initOpenAISdk() async {
    _openAI = OpenAI.instance.build(
        token: getToken(),
        enableLog: true,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 30),
            connectTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30)));
  }

  ///messages of chat
  List<Message> list = [];
  void sendWithPrompt(bool isBot) async {
    ///update user chat message
    list.add(Message(isBot: false, message: getTextInput().value.text));
    emit(ChatCompletionState(isBot: false, messages: list));

    ///start send request
    final request = ChatCompleteText(
        model: _getVersion() ? ChatModel.gpt_4 : ChatModel.gptTurbo,
        messages: [
          Map.of({"role": "user", "content": getTextInput().value.text})
        ],
        maxToken: 400);

    // try {
    //   final response = await _openAI.onChatCompletion(request: request);
    //   list.add(Message(
    //       isBot: true, message: '${response?.choices.last.message?.content}'));
    //   emit(ChatCompletionState(isBot: true, messages: list));
    // }on OpenAIAuthError catch(_) {
    //   ///return state auth error
    //   emit(AuthErrorState());
    // } on OpenAIRateLimitError catch(_) {
    //   ///return state rate limit error
    //   emit(RateLimitErrorState());
    // } on OpenAIServerError catch(_){
    //   ///return state server error
    //   emit(OpenAIServerErrorState());
    // }
    getTextInput().text = "";

    _openAI
        .onChatCompletionSSE(request: request)
        .transform(StreamTransformer.fromHandlers(handleError: handleError))
        .listen((it) {
      Message? message;
      for (final m in list) {
        if (m.id == '${it.id}') {
          message = m;
          list.remove(m);
          break;
        }
      }
      //  list.removeWhere((element) => element.id == '${it.id}');
      ///+= message
      message?.message =
          '${message.message ?? ""}${it.choices.last.message?.content ?? ""}';
      list.add(Message(isBot: true, id: '${it.id}', message: message?.message));
      emit(ChatCompletionState(isBot: true, messages: list));
    });
  }

  void clearMessage() {
    list = [];
  }

  void handleError(Object error, StackTrace t, EventSink<dynamic> eventSink) {
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

  @override
  Future<void> close() {
    getTextInput().clear();
    return super.close();
  }
}

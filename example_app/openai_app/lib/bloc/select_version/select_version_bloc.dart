import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:openai_app/bloc/select_version/select_version_state.dart';
import 'package:openai_app/service/shred_preference/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectVersionBloc extends Cubit<SelectVersionState> {
  SelectVersionBloc() : super(SelectVersionInitState());

  ///[_shared]
  final _shared = GetIt.instance.get<SharedPreferences>();

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

  bool _getVersion() => _shared.getBool(SharedRefKey.kGPTVersion) ?? false;
}

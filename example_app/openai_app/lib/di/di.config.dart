// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/service/shred_preference/shared_preference.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferenceService = _$SharedPreferenceService();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => sharedPreferenceService.prefs,
      preResolve: true,
    );
    gh.factory(() => OpenAIBloc());
    return this;
  }
}

class _$SharedPreferenceService extends _i4.SharedPreferenceService {}

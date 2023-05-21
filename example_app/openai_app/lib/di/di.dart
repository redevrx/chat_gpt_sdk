import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:openai_app/di/di.config.dart';

@InjectableInit()
Future<void> configureDependencies() async => await GetIt.instance.init();

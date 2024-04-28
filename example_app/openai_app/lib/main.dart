import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/bloc/select_version/select_version_bloc.dart';
import 'package:openai_app/bloc/theme/theme_bloc.dart';
import 'package:openai_app/constants/theme/theme.dart';
import 'package:openai_app/di/di.dart';
import 'package:openai_app/screen/splash/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ThemeBloc()),
      BlocProvider(create: (context) => OpenAIBloc()),
      BlocProvider(create: (context) => SelectVersionBloc())
    ], child: const App());
  }
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/constants/theme/dimen.dart';
import 'package:openai_app/screen/home/home_screen.dart';
import 'package:openai_app/screen/preview/preview_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void countDownTime({required BuildContext context}) {
    Future.delayed(const Duration(seconds: 3), () {
      if (!context.mounted) return;
      BlocProvider.of<OpenAIBloc>(context, listen: false).isFirstSetting(
          success: () {
        ///navigate to preview screen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }, error: () {
        ///navigate to preview screen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PreviewScreen()),
            (route) => false);
      });
    });
  }

  @override
  void initState() {
    countDownTime(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Center(
              child: buildPreviewAnimation(size),
            )));
  }

  Widget buildPreviewAnimation(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/animation/robot_loading_screen.json',
            width: 200, height: 200, fit: BoxFit.fill),
        SizedBox(height: size.height * .3)
      ],
    );
  }
}

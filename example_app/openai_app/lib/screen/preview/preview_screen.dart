import 'package:flutter/material.dart';
import 'package:openai_app/components/button/openai_button.dart';
import 'package:openai_app/constants/extension/size_box_extension.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';
import 'package:openai_app/screen/home/home_screen.dart';
import 'package:openai_app/screen/setup/setup_token.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  void toSetupScreen({required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SetupScreen(),
        ),
        (route) => false);
  }

  void toHomeScreen({required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding * 2),
      child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height * .9,
              child: Column(
                children: [
                  kDefaultPadding.toHeight(),
                  buildSkipButton(context),
                  const Spacer(),
                  AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.asset(
                        'assets/images/robot_hello.png',
                      )),
                  const Spacer(),
                  Text(
                    "Chat with OpenAI",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  kDefaultPadding.toHeight(height: 2),
                  Text(
                    "Chat with the OpenAI  Experience \nthe power of ChatGPT with us",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  kDefaultPadding.toHeight(height: 2),
                  OpenAIButton(
                      height: size.height * .05,
                      width: double.infinity,
                      title: "Get Started",
                      tab: () => toSetupScreen(context: context)),
                  const Spacer()
                ],
              ),
            ),
          )),
    ));
  }

  Row buildSkipButton(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkOffBgColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kDefaultPadding))),
            onPressed: () => toHomeScreen(context: context),
            child: Text(
              "Skip",
              style: Theme.of(context).textTheme.titleSmall,
            ))
      ],
    );
  }

  Widget buildImageBackground() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/robot_bg.jpg'),
              fit: BoxFit.cover)),
    );
  }
}

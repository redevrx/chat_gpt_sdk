import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/components/error/notfound_token.dart';
import 'package:openai_app/components/setting/setting_card.dart';
import 'package:openai_app/screen/home/home_screen.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  void toHomeScreen({required BuildContext context}) {
    final bloc = BlocProvider.of<OpenAIBloc>(context, listen: false);
    bloc.saveToken(success: () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    }, error: () {
      errorNotFoundToken(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: buildSettingCard(context),
          ),
        )
      ],
    ));
  }

  Column buildSettingCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.asset(
              'assets/images/robot_hello.png',
            )),
        SettingCard(
          height: MediaQuery.of(context).size.height * .5,
          tab: () => toHomeScreen(context: context),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:openai_app/components/setting/setting_card.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [SettingCard()],
    ));
  }
}

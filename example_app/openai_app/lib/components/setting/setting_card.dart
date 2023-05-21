import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/bloc/select_version/select_version_bloc.dart';
import 'package:openai_app/bloc/select_version/select_version_state.dart';
import 'package:openai_app/components/button/openai_button.dart';
import 'package:openai_app/constants/extension/size_box_extension.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    required this.height,
    required this.tab,
  });

  final double height;
  final GestureTapCallback tab;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OpenAIBloc>(context, listen: false).getTxtToken();
    context.read<SelectVersionBloc>().getVersion();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        height: height,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: kDarkOffBgColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(kDefaultPadding * 2),
                topLeft: Radius.circular(kDefaultPadding * 2)),
            boxShadow: [
              BoxShadow(
                  color: kDarkOffBgColor.withOpacity(.4),
                  offset: const Offset(8, 0),
                  blurRadius: 27.0)
            ]),
        child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                MediaQuery.of(context).size.height.toHeight(height: .06),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Text(
                    "Setting OpenAI",
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding * 1.5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                      color: kDarkBgColor,
                      borderRadius: BorderRadius.circular(kDefaultPadding),
                      boxShadow: [
                        BoxShadow(
                            color: kDarkOffBgColor.withOpacity(.23),
                            offset: const Offset(0, 5),
                            blurRadius: 6)
                      ]),
                  child: TextFormField(
                    controller:
                        BlocProvider.of<OpenAIBloc>(context, listen: false)
                            .getTxtToken(),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Access Token",
                      hintStyle: TextStyle(color: Colors.white),
                      focusColor: Colors.white,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                ///checkbox gpt version
                BlocBuilder<SelectVersionBloc, SelectVersionState>(
                  builder: (context, state) {
                    if (state is OpenAIGptVersionState) {
                      return buildCheckBox(state.isGPT4, context);
                    }
                    return buildCheckBox(false, context);
                  },
                ),
                MediaQuery.of(context).size.height.toHeight(height: .1),
                OpenAIButton(
                  width: MediaQuery.of(context).size.width * .56,
                  height: kDefaultPadding * 2.8,
                  title: 'Save',
                  boxShadow: [
                    BoxShadow(
                        color: kButtonColor.withOpacity(.23),
                        offset: const Offset(0.0, 6),
                        blurRadius: 5.0)
                  ],
                  tab: tab,
                ),
              ],
            )));
  }

  Row buildCheckBox(bool isGPT4, BuildContext context) {
    return Row(
      children: [
        CupertinoCheckbox(
            value: isGPT4 ? false : true,
            onChanged: (_) => context.read<SelectVersionBloc>().onSetGpt3()),
        Text("ChatGPT 3.5", style: Theme.of(context).textTheme.titleSmall),
        CupertinoCheckbox(
            value: isGPT4,
            onChanged: (_) => context.read<SelectVersionBloc>().onSetGpt4()),
        Text("ChatGPT 4", style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}

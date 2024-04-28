import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/components/button/openai_button.dart';
import 'package:openai_app/constants/extension/size_box_extension.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard(
      {super.key,
      required this.height,
      required this.animation,
      required this.title,
      required this.error});

  final double height;
  final String animation;
  final String title;
  final String error;

  @override
  Widget build(BuildContext context) {
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
                    title,
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                kDefaultPadding.toHeight(height: .1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Text(
                    error,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                kDefaultPadding.toHeight(),
                Lottie.asset(
                  animation,
                  width: 150,
                  height: 150,
                ),
                kDefaultPadding.toHeight(height: 2),
                OpenAIButton(
                  width: MediaQuery.of(context).size.width * .56,
                  height: kDefaultPadding * 2.8,
                  title: 'Close',
                  boxShadow: [
                    BoxShadow(
                        color: kButtonColor.withOpacity(.23),
                        offset: const Offset(0.0, 6),
                        blurRadius: 5.0)
                  ],
                  tab: () => BlocProvider.of<OpenAIBloc>(context, listen: false)
                      .closeOpenAIError(),
                ),
              ],
            )));
  }
}

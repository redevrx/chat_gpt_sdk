import 'package:flutter/material.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';

class OpenAIButton extends StatelessWidget {
  const OpenAIButton({
    super.key,
    required this.height,
    required this.width,
    required this.tab,
    required this.title,
    this.boxShadow,
    this.color = kButtonColor,
  });

  final double height;
  final double width;
  final GestureTapCallback tab;
  final String title;
  final List<BoxShadow>? boxShadow;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kDefaultPadding * 1.22),
          boxShadow: boxShadow),
      child: InkWell(
        splashColor: kDarkOffBgColor.withOpacity(.23),
        onTap: tab,
        child: Center(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}

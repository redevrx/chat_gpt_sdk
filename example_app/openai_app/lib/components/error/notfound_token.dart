import 'package:flutter/material.dart';
import 'package:openai_app/constants/theme/colors.dart';

void errorNotFoundToken(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: kDarkBgColor,
      content: Text('Error NotFound Your Token.',
          style: Theme.of(context).textTheme.titleMedium),
    ));

void errorNotFoundPrompt(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: kDarkBgColor,
      content: Text('Error NotFound Your Prompt.',
          style: Theme.of(context).textTheme.titleMedium),
    ));

void toast(BuildContext context, {required String message}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: kDarkBgColor,
      content: Text(message, style: Theme.of(context).textTheme.titleMedium),
    ));

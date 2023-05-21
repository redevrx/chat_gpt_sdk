import 'package:flutter/material.dart';
import 'package:openai_app/constants/theme/colors.dart';

void errorNotFoundToken(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: kDarkBgColor,
      content: Text('Error NotFound Your Token.',
          style: Theme.of(context).textTheme.titleMedium),
    ));

import 'package:flutter/material.dart';
import 'package:openai_app/constants/constants.dart';
import 'package:openai_app/constants/theme/colors.dart';

class FeatureData {
  final String type;
  final String image;
  final String title;
  final Color imageColor;
  final Color bgColor;

  FeatureData(
      {required this.image,
      required this.title,
      required this.imageColor,
      required this.type,
      required this.bgColor});
}

final openAIFeatures = [
  FeatureData(
      image: "assets/images/q_and_a.png",
      title: "Question and Answer",
      imageColor: Colors.indigo,
      bgColor: Colors.indigoAccent,
      type: FeatureType.kCompletion),
  FeatureData(
      image: "assets/images/translate.png",
      title: "Translate Language",
      imageColor: Colors.redAccent,
      bgColor: Colors.red,
      type: FeatureType.kCompletion),
  FeatureData(
      image: "assets/images/generate_image.png",
      title: "Generate image with prompt",
      imageColor: kButtonColor,
      bgColor: kButtonColor,
      type: FeatureType.kGenerateImage),
  FeatureData(
      image: "assets/images/grammar_image.png",
      title: "Grammar Correction",
      imageColor: Colors.green,
      bgColor: Colors.green,
      type: FeatureType.kGrammar),
  FeatureData(
      image: "assets/images/question_interview_image.png",
      title: "Interview questions",
      imageColor: Colors.deepOrange,
      bgColor: Colors.deepOrange,
      type: FeatureType.kQuestionInterview),
];

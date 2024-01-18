import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

sealed class GenerateImageModel {
  final String model;

  GenerateImageModel({required this.model});
}

class DallE2 extends GenerateImageModel {
  DallE2() : super(model: kDallE2);
}

class DallE3 extends GenerateImageModel {
  DallE3() : super(model: kDallE3);
}

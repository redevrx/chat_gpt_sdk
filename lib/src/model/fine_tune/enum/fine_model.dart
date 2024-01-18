import 'package:chat_gpt_sdk/src/utils/constants.dart';

sealed class FineModel {
  String model;
  FineModel({required this.model});
}

class GptTurbo0631Model extends FineModel {
  GptTurbo0631Model() : super(model: kChatGptTurbo0613);
}

class Babbage002FineModel extends FineModel {
  Babbage002FineModel() : super(model: kBabbage002Model);
}

class FineModelFromValue extends FineModel {
  FineModelFromValue({required super.model});
}

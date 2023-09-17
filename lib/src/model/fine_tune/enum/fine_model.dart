import 'package:chat_gpt_sdk/src/utils/constants.dart';

sealed class FineModel {
  String model;
  FineModel({required this.model});
}

class GptTurbo0631Model extends FineModel {
  GptTurbo0631Model() : super(model: kChatGptTurbo0613);
}

class AdaFineModel extends FineModel {
  AdaFineModel() : super(model: kAdaModel);
}

class BabbageFineModel extends FineModel {
  BabbageFineModel() : super(model: kBabbageModel);
}

class CurieFineModel extends FineModel {
  CurieFineModel() : super(model: kCurieModel);
}

class DavinciFineModel extends FineModel {
  DavinciFineModel() : super(model: kDavinciModel);
}

class FineModelFromValue extends FineModel {
  FineModelFromValue({required super.model});
}

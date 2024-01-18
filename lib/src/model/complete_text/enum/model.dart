import '../../../utils/constants.dart';

sealed class Model {
  String model;
  Model({required this.model});
}

class Gpt3TurboInstruct extends Model {
  Gpt3TurboInstruct() : super(model: kGpt3TurboInstruct);
}

class ModelFromValue extends Model {
  ModelFromValue({required super.model});
}

class Davinci002Model extends Model {
  Davinci002Model() : super(model: kDavinci002Model);
}

class Babbage002Model extends Model {
  Babbage002Model() : super(model: kBabbage002Model);
}

import '../../../utils/constants.dart';

sealed class Model {
  String model;
  Model({required this.model});
}

class TextDavinci3Model extends Model {
  TextDavinci3Model() : super(model: kTextDavinci3);
}

class TextDavinci2Model extends Model {
  TextDavinci2Model() : super(model: kTextDavinci2);
}

class CodeDavinci2Model extends Model {
  CodeDavinci2Model() : super(model: kCodeDavinci2);
}

class ModelFromValue extends Model {
  ModelFromValue({required super.model});
}

class TextCurie001Model extends Model {
  TextCurie001Model() : super(model: kTextCurie001);
}

class TextBabbage001Model extends Model {
  TextBabbage001Model() : super(model: kTextBabbage001);
}

class TextAda001Model extends Model {
  TextAda001Model() : super(model: kTextAda001);
}

class DavinciModel extends Model {
  DavinciModel() : super(model: kDavinciModel);
}

class CurieModel extends Model {
  CurieModel() : super(model: kCurieModel);
}

class BabbageModel extends Model {
  BabbageModel() : super(model: kBabbageModel);
}

class AdaModel extends Model {
  AdaModel() : super(model: kAdaModel);
}

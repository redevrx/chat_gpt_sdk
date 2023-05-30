import '../../../utils/constants.dart';

enum Model {
  textDavinci3,
  textDavinci2,
  codeDavinci2,
  textCurie001,
  textBabbage001,
  textAda001,
  davinci,
  curie,
  babbage,
  ada
}

extension ModelExtension on Model {
  String getName() {
    switch (this) {
      case Model.textDavinci3:
        return kTextDavinci3;
      case Model.textDavinci2:
        return kTextDavinci2;
      case Model.codeDavinci2:
        return kCodeDavinci2;
      case Model.textCurie001:
        return kCodeDavinci2;
      case Model.textBabbage001:
        return kTextBabbage001;
      case Model.textAda001:
        return kTextAda001;
      case Model.davinci:
        return kDavinciModel;
      case Model.curie:
        return kCurieModel;
      case Model.babbage:
        return kBabbageModel;
      case Model.ada:
        return kAdaModel;
      default:
        return "";
    }
  }
}

Model fromName(String name) {
  for (var value in Model.values) {
    if (value.name == name) return value;
  }
  throw ArgumentError.value(name, "name", "No enum value with that name");
}

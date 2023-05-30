import 'package:chat_gpt_sdk/src/utils/constants.dart';

enum FineModel { ada, babbage, curie, davinci }

extension FineModelExtension on FineModel {
  String getName() {
    switch (this) {
      case FineModel.ada:
        return kAdaModel;
      case FineModel.babbage:
        return kBabbageModel;
      case FineModel.curie:
        return kCurieModel;
      case FineModel.davinci:
        return kDavinciModel;
      default:
        return '';
    }
  }
}

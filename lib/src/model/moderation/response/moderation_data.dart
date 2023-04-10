import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import 'moderation_result.dart';

enum ModerationModel { textStable, textLast }

extension ModerationModelES on ModerationModel {
  String getName() {
    switch (this) {
      case ModerationModel.textLast:
        return kTextMLast;
      case ModerationModel.textStable:
        return kTextMStable;
      default:
        return '';
    }
  }
}

class ModerationData {
  ModerationData({
    required this.id,
    required this.model,
    required this.results,
  });
  late final String id;
  late final String model;
  late final List<ModerationResult> results;

  ModerationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    results = List.from(json['results'])
        .map((e) => ModerationResult.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['results'] = results.map((e) => e.toJson()).toList();
    return data;
  }
}

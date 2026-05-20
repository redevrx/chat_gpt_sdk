import 'package:chat_gpt_sdk/src/model/moderation/response/categories.dart';
import 'package:chat_gpt_sdk/src/model/moderation/response/category_scores.dart';

class ModerationResult {
  ModerationResult({
    required this.categories,
    required this.categoryScores,
    required this.flagged,
  });

  late final Categories categories;
  late final CategoryScores categoryScores;
  late final bool flagged;

  ModerationResult.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] == null
        ? Categories.fromJson({})
        : Categories.fromJson(Map<String, dynamic>.from(json['categories']));
    categoryScores = json['category_scores'] == null
        ? CategoryScores.fromJson({})
        : CategoryScores.fromJson(Map<String, dynamic>.from(json['category_scores']));
    flagged = json['flagged'] as bool? ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['categories'] = categories.toJson();
    data['category_scores'] = categoryScores.toJson();
    data['flagged'] = flagged;

    return data;
  }
}

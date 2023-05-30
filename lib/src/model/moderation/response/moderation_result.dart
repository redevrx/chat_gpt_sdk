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
    categories = Categories.fromJson(json['categories']);
    categoryScores = CategoryScores.fromJson(json['category_scores']);
    flagged = json['flagged'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['categories'] = categories.toJson();
    data['category_scores'] = categoryScores.toJson();
    data['flagged'] = flagged;

    return data;
  }
}

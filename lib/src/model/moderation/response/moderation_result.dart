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

  ModerationResult.fromJson(Map<String, dynamic> json){
    categories = Categories.fromJson(json['categories']);
    categoryScores = CategoryScores.fromJson(json['category_scores']);
    flagged = json['flagged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categories'] = categories.toJson();
    _data['category_scores'] = categoryScores.toJson();
    _data['flagged'] = flagged;
    return _data;
  }
}
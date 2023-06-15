import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/moderation/response/moderation_result.dart';
import 'package:test/test.dart';

void main() {
  group('moderation result test', () {
    test('moderation result test', () {
      final json = {
        'categories': {
          "hate": true,
          'hate/threatening': false,
          'self-harm': true,
          'sexual': true,
          'sexual/minors': true,
          'violence': true,
          'violence/graphic': true,
        },
        'category_scores': {
          'hate': .5,
          'hate/threatening': .5,
          'self-harm': .5,
          'sexual': .5,
          'sexual/minors': .5,
          'violence': .5,
          'violence/graphic': .5,
        },
        'flagged': true,
      };

      final result = ModerationResult.fromJson(json);

      expect(result.categories.hate, true);
      expect(result.categoryScores.hate, .5);
    });

    test('moderation result test', () {
      final json = ModerationResult(
        categories: Categories.fromJson({
          "hate": true,
          'hate/threatening': false,
          'self-harm': true,
          'sexual': true,
          'sexual/minors': true,
          'violence': true,
          'violence/graphic': true,
        }),
        categoryScores: CategoryScores.fromJson({
          'hate': .5,
          'hate/threatening': .5,
          'self-harm': .5,
          'sexual': .5,
          'sexual/minors': .5,
          'violence': .5,
          'violence/graphic': .5,
        }),
        flagged: true,
      ).toJson();

      expect(json['categories']['hate'], true);
      expect(json['category_scores']['hate'], .5);
    });
  });
}

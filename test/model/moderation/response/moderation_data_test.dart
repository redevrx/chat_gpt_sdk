import 'package:chat_gpt_sdk/src/model/moderation/response/moderation_data.dart';
import 'package:chat_gpt_sdk/src/model/moderation/response/moderation_result.dart';
import 'package:test/test.dart';

void main() {
  group('moderation data test', () {
    test('moderation data test from json', () {
      final json = {
        'id': 'id',
        'model': 'model',
        'results': [
          {
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
          },
        ],
      };

      final moderation = ModerationData.fromJson(json);

      expect(moderation.model, 'model');
      expect(moderation.id, 'id');
    });
    test('moderation data test to json', () {
      final json = ModerationData(id: 'id', model: 'model', results: [
        ModerationResult.fromJson({
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
        }),
      ]).toJson();

      expect(json['model'], 'model');
      expect(json['id'], 'id');
    });
  });
}

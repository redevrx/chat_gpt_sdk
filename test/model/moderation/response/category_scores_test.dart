import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('category scores test', () {
    test('category scores test from json', () {
      final json = {
        'hate': .5,
        'hate/threatening': .5,
        'self-harm': .5,
        'sexual': .5,
        'sexual/minors': .5,
        'violence': .5,
        'violence/graphic': .5,
      };

      final cate = CategoryScores.fromJson(json);

      expect(cate.selfHarm, .5);
      expect(cate.hateThreatening, .5);
      expect(cate.sexual, .5);
      expect(cate.violence, .5);
      expect(cate.violenceGraphic, .5);
    });

    test('category scores test to json', () {
      final json = CategoryScores(
        hate: .5,
        hateThreatening: .5,
        selfHarm: .5,
        sexual: .5,
        sexualMinors: .5,
        violence: .5,
        violenceGraphic: .5,
      ).toJson();

      expect(json['self-harm'], .5);
      expect(json['hate/threatening'], .5);
      expect(json['sexual'], .5);
      expect(json['violence'], .5);
      expect(json['violence/graphic'], .5);
    });
  });
}

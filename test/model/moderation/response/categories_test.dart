import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('categories test', () {
    test('categories test from json', () {
      final json = {
        "hate": true,
        'hate/threatening': false,
        'self-harm': true,
        'sexual': true,
        'sexual/minors': true,
        'violence': true,
        'violence/graphic': true,
      };

      final category = Categories.fromJson(json);

      expect(category.hate, true);
      expect(category.hateThreatening, false);
      expect(category.selfHarm, true);
    });

    test('categories test to json', () {
      final json = Categories(
        hate: true,
        hateThreatening: false,
        selfHarm: true,
        sexual: true,
        sexualMinors: true,
        violence: true,
        violenceGraphic: true,
      ).toJson();

      expect(json['hate'], true);
      expect(json['hate/threatening'], false);
      expect(json['self-harm'], true);
    });
  });
}

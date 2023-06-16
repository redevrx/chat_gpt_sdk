import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/moderation/enum/moderation_model.dart';
import 'package:test/test.dart';

void main() {
  group('moderation test', () {
    test('moderation test get value textLast', () {
      final textLast = TextLastModerationModel();

      expect(textLast.model, kTextMLast);
    });
    test('moderation test get value textStable', () {
      final textStable = TextStableModerationModel();

      expect(textStable.model, kTextMStable);
    });
    test('moderation test get from value', () {
      final textStable = ModerationModelFromValue(model: 'model');

      expect(textStable.model, 'model');
    });
  });
}

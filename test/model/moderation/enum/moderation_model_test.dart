
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/moderation/enum/moderation_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('moderation test', () {
    test('moderation test get value textLast', () {
      const textLast = ModerationModel.textLast;

      expect(textLast.getName(), kTextMLast);
    });
    test('moderation test get value textStable', () {
      const textStable = ModerationModel.textStable;

      expect(textStable.getName(), kTextMStable);
    });
  });
}
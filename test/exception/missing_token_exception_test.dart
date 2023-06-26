import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('missing token test', () {
    test("missing token not found token test", () {
      expect(
        () => OpenAI.instance.build(token: ''),
        throwsA(isA<MissingTokenException>()),
      );
    });
    test("missing token is null test", () {
      expect(
        () => OpenAI.instance.build(),
        throwsA(isA<MissingTokenException>()),
      );
    });
    test("missing token Exception set value test", () {
      final missingToken = MissingTokenException();

      expect(
        missingToken.toString(),
        "Not Missing Your Token look more https://beta.openai.com/account/api-keys",
      );
    });

    test("missing token Exception test", () {
      final missingToken = MissingTokenException();

      expect(missingToken.toString(), isA<String>());
    });
  });
}

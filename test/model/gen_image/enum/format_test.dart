import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('image format', () {
    test('image format get value url', () {
      const url = Format.url;

      expect(url.getName(), 'url');
    });

    test('image format get value b64Json', () {
      const b64Json = Format.b64Json;

      expect(b64Json.getName(), 'b64_json');
    });
  });
}

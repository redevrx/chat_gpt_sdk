import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('http setup test', () {
    test('http setup test valid instance', () {
      final httpSetup = HttpSetup();
      expect(httpSetup, isA<HttpSetup>());
    });
    test('http setup test valid timeout', () {
      final httpSetup = HttpSetup();
      expect(httpSetup.connectTimeout, isA<Duration>());
      expect(httpSetup.receiveTimeout, isA<Duration>());
      expect(httpSetup.sendTimeout, isA<Duration>());
    });
    test('http setup test has proxy', () {
      final httpSetup = HttpSetup(proxy: "proxy");
      expect(httpSetup.proxy, 'proxy');
    });
  });
}

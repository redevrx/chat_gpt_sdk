import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('HttpSetup', () {
    test('default values', () {
      final httpSetup = HttpSetup();
      expect(httpSetup.sendTimeout, const Duration(seconds: 6));
      expect(httpSetup.connectTimeout, const Duration(seconds: 6));
      expect(httpSetup.receiveTimeout, const Duration(seconds: 6));
      expect(httpSetup.proxy, '');
    });

    test('custom values', () {
      final httpSetup = HttpSetup(
        sendTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 30),
        proxy: 'http://myproxy.com',
      );
      expect(httpSetup.sendTimeout, const Duration(seconds: 10));
      expect(httpSetup.connectTimeout, const Duration(seconds: 20));
      expect(httpSetup.receiveTimeout, const Duration(seconds: 30));
      expect(httpSetup.proxy, 'http://myproxy.com');
    });
  });
}

import 'package:chat_gpt_sdk/src/logger/logger.dart';
import 'package:test/test.dart';

void main() {
  group("openai log test", () {
    test('openai logger test isLogging true', () {
      final log = Logger.instance.builder(isLogging: true);
      log.log('message');
      expect(log.isLogging, true);
    });
    test('openai logger test isLogging true print error', () {
      final log = Logger.instance.builder(isLogging: true);
      log.error(Object(), null, message: "");
      expect(log.isLogging, true);
    });
  });
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('default value', () async {
    final target = GenerateImage('test', 2);
    expect(target.prompt, 'test');
    expect(target.n, 2);

    expect(target.size, '1024x1024');
    expect(target.response_format, 'url');
    expect(target.user, '');
  });
}

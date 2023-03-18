import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('default value', () async {
    final target = GenerateImage('test', 2,
        size: ImageSize.size1024, response_format: Format.url);
    expect(target.prompt, 'test');
    expect(target.n, 2);

    expect(target.size?.size, '1024x1024');
    expect(target.response_format?.name, 'url');
    expect(target.user, '');
  });

  test('set value with enum', () async {
    final target1 = GenerateImage('test', 1,
        size: ImageSize.size256,
        response_format: Format.b64_json,
        user: 'user');
    expect(target1.prompt, 'test');
    expect(target1.n, 1);

    expect(target1.size?.size, '256x256');
    expect(target1.response_format?.name, 'b64_json');
    expect(target1.user, 'user');

    final target2 = GenerateImage('test', 2,
        size: ImageSize.size512, response_format: Format.url, user: 'user');
    expect(target2.size?.size, '512x512');
    expect(target2.response_format?.name, 'url');

    final target3 =
        GenerateImage('test', 1, size: ImageSize.size1024, user: 'user');
    expect(target3.size?.size, '1024x1024');
  });

  group('GeneratedImageSize', () {
    test('normal', () async {
      expect(GenerateImage('test', 2).size?.size, '1024x1024');
      expect(GenerateImage('test', 2, size: ImageSize.size256).size?.size, '256x256');
      expect(GenerateImage('test', 2, size: ImageSize.size512).size?.size, '512x512');
      expect(
          GenerateImage('test', 2, size: ImageSize.size1024).size?.size, '1024x1024');
    });

  });

  test('n must be between 1 and 10', () {
    expect(() => GenerateImage('test', 0), throwsAssertionError);
    expect(() => GenerateImage('test', 11), throwsAssertionError);

    expect(GenerateImage('test', 1).n, 1);
    expect(GenerateImage('test', 10).n, 10);
  });

  group('toJson', () {
    test('example', () {
      final json = GenerateImage('test', 1,
              size: ImageSize.size256,
              response_format: Format.b64_json,
              user: 'user')
          .toJson();

      expect(json['prompt'], 'test');
      expect(json['n'], 1);
      expect(json['size'], '256x256');
      expect(json['response_format'], 'b64_json');
      expect(json['user'], 'user');
    });
  });
}

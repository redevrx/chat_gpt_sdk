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

  test('set value without enum', () async {
    final target1 = GenerateImage('test', 2,
        size: '256x256', response_format: 'b64_json', user: 'user');
    expect(target1.prompt, 'test');
    expect(target1.n, 2);

    expect(target1.size, '256x256');
    expect(target1.response_format, 'b64_json');
    expect(target1.user, 'user');

    final target2 = GenerateImage('test2', 3,
        size: '512x512', response_format: 'url', user: 'user2');
    expect(target2.prompt, 'test2');
    expect(target2.n, 3);

    expect(target2.size, '512x512');
    expect(target2.response_format, 'url');
    expect(target2.user, 'user2');
  });

  test('set value with enum', () async {
    final target1 = GenerateImage('test', 1,
        generateImageSize: GenerateImageSize.size256,
        generatedResponseFormat: GeneratedResponseFormat.b64_json,
        user: 'user');
    expect(target1.prompt, 'test');
    expect(target1.n, 1);

    expect(target1.size, '256x256');
    expect(target1.response_format, 'b64_json');
    expect(target1.user, 'user');

    final target2 = GenerateImage('test', 2,
        generateImageSize: GenerateImageSize.size512,
        generatedResponseFormat: GeneratedResponseFormat.url,
        user: 'user');
    expect(target2.size, '512x512');
    expect(target2.response_format, 'url');

    final target3 = GenerateImage('test', 1,
        generateImageSize: GenerateImageSize.size1024, user: 'user');
    expect(target3.size, '1024x1024');
  });

  group('response_format', () {
    test('error', () {
      try {
        GenerateImage('test2', 3,
            size: '512x512', response_format: 'b64json', user: 'user2');
        fail('exception must be throw');
      } on AssertionError catch (e) {
        expect(e.message,
            'response_format(b64json) must be null or [url,b64_json]');
      } catch (e) {
        fail('unexpected exception');
      }
    });
  });

  group('GeneratedImageSize', () {
    test('normal', () async {
      expect(GenerateImage('test', 2).size, '1024x1024');
      expect(
          GenerateImage('test', 2, generateImageSize: GenerateImageSize.size256)
              .size,
          '256x256');
      expect(
          GenerateImage('test', 2, generateImageSize: GenerateImageSize.size512)
              .size,
          '512x512');
      expect(
          GenerateImage('test', 2,
                  generateImageSize: GenerateImageSize.size1024)
              .size,
          '1024x1024');
    });

    test('error', () {
      expect(() => GenerateImage('test', 1, size: '1024x1023'),
          throwsAssertionError);
      expect(
          () => GenerateImage('test', 1,
              size: '1024x1024', generateImageSize: GenerateImageSize.size256),
          throwsAssertionError);
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
              generateImageSize: GenerateImageSize.size256,
              generatedResponseFormat: GeneratedResponseFormat.b64_json,
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

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

main() {
  test('default value', () {
    final target = GenerateImage(
      'test',
      2,
      model: DallE3(),
      size: ImageSize.size1024,
      responseFormat: Format.url,
    );
    expect(target.prompt, 'test');
    expect(target.n, 2);

    expect(target.size?.size, '1024x1024');
    expect(target.responseFormat?.name, 'url');
    expect(target.user, '');
  });

  test('set value with enum', () {
    final target1 = GenerateImage(
      model: DallE3(),
      'test',
      1,
      size: ImageSize.size256,
      responseFormat: Format.b64Json,
      user: 'user',
    );
    expect(target1.prompt, 'test');
    expect(target1.n, 1);

    expect(target1.size?.size, '256x256');
    expect(target1.responseFormat?.getName(), 'b64_json');
    expect(target1.user, 'user');

    final target2 = GenerateImage(
      model: DallE3(),
      'test',
      2,
      size: ImageSize.size512,
      responseFormat: Format.url,
      user: 'user',
    );
    expect(target2.size?.size, '512x512');
    expect(target2.responseFormat?.name, 'url');

    final target3 = GenerateImage(
      'test',
      1,
      model: DallE3(),
      size: ImageSize.size1024,
      user: 'user',
    );
    expect(target3.size?.size, '1024x1024');
  });

  group('GeneratedImageSize', () {
    test('normal', () {
      expect(
        GenerateImage(
          'test',
          2,
          model: DallE3(),
        ).size?.size,
        '1024x1024',
      );
      expect(
        GenerateImage('test', 2, model: DallE3(), size: ImageSize.size256)
            .size
            ?.size,
        '256x256',
      );
      expect(
        GenerateImage('test', 2, model: DallE3(), size: ImageSize.size512)
            .size
            ?.size,
        '512x512',
      );
      expect(
        GenerateImage('test', 2, model: DallE3(), size: ImageSize.size1024)
            .size
            ?.size,
        '1024x1024',
      );
    });
  });

  test('n must be between 1 and 10', () {
    expect(
      () => GenerateImage('test', model: DallE3(), 0),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => GenerateImage('test', model: DallE3(), 11),
      throwsA(isA<AssertionError>()),
    );

    expect(GenerateImage('test', model: DallE3(), 1).n, 1);
    expect(GenerateImage('test', model: DallE3(), 10).n, 10);
  });

  group('toJson', () {
    test('example', () {
      final json = GenerateImage(
        'test',
        model: DallE3(),
        1,
        size: ImageSize.size256,
        responseFormat: Format.b64Json,
        user: 'user',
      ).toJson();

      expect(json['prompt'], 'test');
      expect(json['n'], 1);
      expect(json['size'], '256x256');
      expect(json['response_format'], 'b64_json');
      expect(json['user'], 'user');
    });
  });
}

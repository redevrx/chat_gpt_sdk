import 'package:chat_gpt_sdk/src/model/gen_image/response/image_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ImageData test with parameters', () {
    final String url = 'https://example.com';
    final String b64Json = 'ABC123';

    final ImageData imageData = ImageData(
      url: url,
      b64Json: b64Json,
    );

    expect(imageData.url, equals(url));
    expect(imageData.b64Json, equals(b64Json));
  });

  test('ImageData test without parameters', () {
    final ImageData imageData = ImageData();

    expect(imageData.url, isNull);
    expect(imageData.b64Json, isNull);
  });

  test('Test toJson method for ImageData', () {
    final imageData = ImageData(
      url: 'https://example.com/image.png',
      b64Json: 'eyJmb28iOiJiYXIifQ==',
    );

    final expectedJson = {
      'url': 'https://example.com/image.png',
      'b64_json': 'eyJmb28iOiJiYXIifQ==',
    };

    final resultJson = imageData.toJson();

    expect(resultJson, equals(expectedJson));
  });
}

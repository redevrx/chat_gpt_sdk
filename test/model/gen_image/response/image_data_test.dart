import 'package:chat_gpt_sdk/src/model/gen_image/response/image_data.dart';
import 'package:test/test.dart';

void main() {
  group('image data test', () {
    test('image data test from json', () {
      final json = {
        'url': 'url',
        'b64_json': 'b64_json',
      };

      final data = ImageData.fromJson(json);

      expect(data.url, 'url');
      expect(data.b64Json, 'b64_json');
    });

    test('image data test to json', () {
      final json = ImageData(url: 'url', b64Json: 'b64_json').toJson();

      expect(json['url'], 'url');
      expect(json['b64_json'], 'b64_json');
    });
  });
}

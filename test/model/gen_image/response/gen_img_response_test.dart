import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('generate image response test', () {
    test('generate image response test', () {
      final json = {
        'data': [
          {
            'url': 'url',
            'b64_json': 'b64_json',
          },
        ],
        'created': 1231,
      };

      final image = GenImgResponse.fromJson(json);

      expect(image.data?.length, 1);
      expect(image.data?.last?.url, 'url');
    });
  });
}

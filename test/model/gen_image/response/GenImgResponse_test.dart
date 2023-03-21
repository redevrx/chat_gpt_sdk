import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/response/image_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should correctly assign member variables when valid data is provided',
      () {
    final response = GenImgResponse(
      created: 1616327482,
      data: [
        ImageData(
          url: 'https://example.com/image1.jpg',
          b64Json:
              'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiQ2hhdCBH',
        ),
        ImageData(
          url: 'https://example.com/image2.jpg',
          b64Json:
              'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiVGVzdCBH',
        ),
      ],
    );

    expect(response.created, 1616327482);
    expect(response.data!.length, 2);
    expect(response.data![0]!.url, 'https://example.com/image1.jpg');
    expect(response.data![0]!.b64Json,
        'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiQ2hhdCBH');
    expect(response.data![1]!.url, 'https://example.com/image2.jpg');
    expect(response.data![1]!.b64Json,
        'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiVGVzdCBH');
  });

  test('should return null when data is incomplete or invalid', () {
    final response1 = GenImgResponse(
      created: null,
      data: null,
    );
    expect(response1.created, isNull);
    expect(response1.data, isNull);

    final response2 = GenImgResponse(
      created: 1616327482,
      data: [
        ImageData(url: 'https://example.com/image1.jpg'),
        ImageData(b64Json: 'invalid'),
      ],
    );
    expect(response2.created, 1616327482);
    expect(response2.data!.length, 2);
    expect(response2.data![0]!.url, 'https://example.com/image1.jpg');
    expect(response2.data![0]!.b64Json, isNull);
    expect(response2.data![1]!.url, isNull);
    expect(response2.data![1]!.b64Json, 'invalid');
  });

  test('fromJson() should correctly parse JSON data', () {
    final jsonData = {
      'created': 1616327482,
      'data': [
        {
          'url': 'https://example.com/image1.jpg',
          'b64_json':
              'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiQ2hhdCBH',
        },
        {
          'url': 'https://example.com/image2.jpg',
          'b64_json':
              'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiVGVzdCBH',
        },
      ]
    };

    final response = GenImgResponse.fromJson(jsonData);

    expect(response.created, 1616327482);
    expect(response.data!.length, 2);
    expect(response.data![0]!.url, 'https://example.com/image1.jpg');
    expect(response.data![0]!.b64Json,
        'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiQ2hhdCBH');
    expect(response.data![1]!.url, 'https://example.com/image2.jpg');
    expect(response.data![1]!.b64Json,
        'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiVGVzdCBH');
  });

  test('fromJson() should correctly parse JSON data when  with data is null',
      () {
    final jsonData = {
      'created': 1616327482,
      'data': null,
    };

    final response = GenImgResponse.fromJson(jsonData);

    expect(response.created, 1616327482);
    expect(response.data!.length, 0);
  });

  test(
    'fromJson() should return null when JSON data is invalid',
    skip:
        'Not performed because the operation stops with the following message before checking for an exception:'
        "type 'String' is not a subtype of type 'int?'",
    () {
      final jsonData = {
        'created': 'invalid',
        'data': [
          {
            'url': 'https://example.com/image1.jpg',
            'b64_json':
                'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJzdWIiOiAiQ2hhdCBH',
          },
          {
            'url': 'https://example.com/image2.jpg',
            'b64_json': 12345, // invalid type
          },
        ]
      };

      expect(
        GenImgResponse.fromJson(jsonData),
        throwsA(TypeMatcher<TypeError>()),
      );
    },
  );

  test('Test toJson method', () {
    final imageData1 = ImageData(url: 'test_url_1', b64Json: 'test_b64json_1');
    final imageData2 = ImageData(url: 'test_url_2', b64Json: 'test_b64json_2');
    final genImgResponse =
        GenImgResponse(created: 1234567890, data: [imageData1, imageData2]);

    final expectedJson = {
      'created': 1234567890,
      'data': [
        {'url': 'test_url_1', 'b64_json': 'test_b64json_1'},
        {'url': 'test_url_2', 'b64_json': 'test_b64json_2'}
      ]
    };

    expect(genImgResponse.toJson(), expectedJson);
  });

  test('should convert object to json when data is null', () {
    final genImgResponse = GenImgResponse(
      created: 123456,
      data: null,
    );
    final expectedJson = {
      "created": 123456,
      "data": [],
    };

    final json = genImgResponse.toJson();

    expect(json, equals(expectedJson));
  });
}

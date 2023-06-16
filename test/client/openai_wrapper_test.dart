import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'openai_wrapper_test.mocks.dart';

@GenerateNiceMocks([MockSpec<OpenAIClient>()])
void main() {
  final client = MockOpenAIClient();

  group('openai client test', () {
    test('openai wrapper client test', () {
      expect(client, isA<OpenAIWrapper>());
    });
    test('openai client test get', () {
      client.get(
        "mock url",
        onSuccess: (it) {
          expect(it, isA<Map<String, dynamic>>());
          expect(it.isEmpty, false);
        },
        onCancel: (c) {
          return;
        },
      );
    });
    test('openai client test post', () {
      client.post(
        "mock url",
        {},
        onSuccess: (it) {
          expect(it, isA<Map<String, dynamic>>());
          expect(it.isEmpty, false);
        },
        onCancel: (c) {
          return;
        },
      );
    });
    test('openai client test delete', () {
      client.delete(
        "mock url",
        onSuccess: (it) {
          expect(it, isA<Map<String, dynamic>>());
          expect(it.isEmpty, false);
        },
        onCancel: (c) {
          return;
        },
      );
    });
    test('openai client test getStream', () {
      client.getStream(
        "mock url",
        onSuccess: (it) {
          expect(it, isA<Map<String, dynamic>>());
          expect(it.isEmpty, false);
        },
        onCancel: (c) {
          return;
        },
      );
    });
    test('openai client test post formData', () {
      client.postFormData(
        "mock url",
        FormData(),
        complete: (it) {
          expect(it, isA<Map<String, dynamic>>());
          expect(it.isEmpty, false);
        },
        onCancel: (c) {
          return;
        },
      );
    });
    test('openai client test getStream', () {
      client.sse(
        "mock url",
        {},
        complete: (it) {
          expect(it, isA<Map<String, dynamic>>());
          expect(it.isEmpty, false);
        },
        onCancel: (c) {
          return;
        },
      );
    });
  });
}

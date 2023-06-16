import 'package:chat_gpt_sdk/src/utils/token_builder.dart';
import 'package:test/test.dart';

void main() {
  group('TokenBuilder test', () {
    test('TokenBuilder set token', () {
      final token = TokenBuilder.build;
      token.setToken('token');

      expect(token.token, 'token');
      expect(token.token, isA<String>());
    });

    test('TokenBuilder set orgId', () {
      final token = TokenBuilder.build;
      token.setOrgId('orgId');

      expect(token.orgId, 'orgId');
      expect(token.orgId, isA<String>());
    });
  });
}

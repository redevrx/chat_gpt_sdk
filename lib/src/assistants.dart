import 'client/client.dart';

class Assistants {
  final OpenAIClient _client;
  Assistants(this._client);

  void create() {
    _client.get(
      'url',
      onSuccess: (p0) {
        return;
      },
      onCancel: (cancelData) {
        return;
      },
    );
  }
}

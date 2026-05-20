import 'package:chat_gpt_sdk/src/model/assistant/request/assistant.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/assistant_data.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/delete_assistant.dart';
import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

import 'client/client.dart';

class Assistants {
  final OpenAIClient _client;

  Assistants(this._client);

  Map<String, String> get getHeader => headersAssistantsV2;

  void addHeader(Map<String, String> mHeader) {
    if (mHeader == {}) return;

    headersAssistantsV2.addAll(mHeader);
  }

  ///Create an assistant with a model and instructions.
  ///[create]
  Future<AssistantData> create({
    required Assistant assistant,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kAssistants,
      assistant.toJson(),
      headers: headersAssistantsV2,
      onSuccess: AssistantData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///Returns a list of assistants.
  ///[list]
  Future<List<AssistantData>> list() {
    return _client.get(
      _client.apiUrl + kAssistants,
      headers: headersAssistantsV2,
      onSuccess: (it) => it['data'] == null
          ? []
          : List<AssistantData>.from(
              it['data'].map((x) => AssistantData.fromJson(x)),
            ),
      onCancel: (_) => null,
    );
  }

  ///Retrieves an assistant.
  ///[retrieves]
  Future<AssistantData> retrieves({required String assistantId}) {
    return _client.get(
      _client.apiUrl + kAssistants + "/$assistantId",
      headers: headersAssistantsV2,
      onSuccess: AssistantData.fromJson,
      onCancel: (_) => null,
    );
  }

  ///Modifies an assistant.
  /// [modifies]
  Future<AssistantData> modifies({
    required String assistantId,
    required Assistant assistant,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kAssistants + "/$assistantId",
      assistant.toJson(),
      headers: headersAssistantsV2,
      onSuccess: AssistantData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///Delete an assistant.
  ///[delete]
  Future<DeleteAssistant> delete({required String assistantId}) {
    return _client.delete(
      _client.apiUrl + kAssistants + "/$assistantId",
      headers: headersAssistantsV2,
      onSuccess: DeleteAssistant.fromJson,
      onCancel: (_) => null,
    );
  }
}

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/assistant/request/assistant.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/assistant_data.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/assistant_file_data.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/list_assistant_file.dart';

import 'client/client.dart';

class Assistants {
  final OpenAIClient _client;
  Assistants(this._client);
  Map<String, String> _headers = {'OpenAI-Beta': 'assistants=v1'};

  Map<String, String> get getHeader => _headers;

  void addHeader(Map<String, String> mHeader) {
    if (mHeader == {}) return;

    _headers.addAll(mHeader);
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
      headers: _headers,
      onSuccess: AssistantData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///
  /// [assistantId]
  /// The ID of the assistant for which to create a File.
  /// [fileId]
  /// A <a href='https://platform.openai.com/docs/api-reference/files'>File ID</a>
  /// (with purpose="assistants") that the assistant should use.
  /// Useful for tools like retrieval and code_interpreter that can access files.
  /// [createFile]
  Future<AssistantFileData> createFile({
    required String fileId,
    required String assistantId,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kAssistants + "/$assistantId/file",
      {
        'file_id': fileId,
      },
      headers: _headers,
      onSuccess: AssistantFileData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///Returns a list of assistants.
  ///[list]
  Future<List<AssistantData>> list() {
    return _client.get(
      _client.apiUrl + kAssistants,
      headers: _headers,
      onSuccess: (it) => it['data'] == null
          ? []
          : List<AssistantData>.from(
              it['data'].map((x) => AssistantData.fromJson(x)),
            ),
      onCancel: (_) => null,
    );
  }

  ///Returns a list of assistant files.
  ///[listFile]
  Future<ListAssistantFile> listFile() {
    return _client.get(
      _client.apiUrl + kAssistants,
      headers: _headers,
      onSuccess: ListAssistantFile.fromJson,
      onCancel: (_) => null,
    );
  }
}

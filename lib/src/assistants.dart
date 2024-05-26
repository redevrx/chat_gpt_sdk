import 'package:chat_gpt_sdk/src/model/assistant/request/assistant.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/assistant_data.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/assistant_file_data.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/delete_assistant.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/list_assistant_file.dart';
import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

import 'client/client.dart';

class AssistantsV2 {
  final OpenAIClient _client;
  AssistantsV2(this._client);

  Map<String, String> get getHeader => headersAssistantsV2;

  ///Create an assistant with a model and instructions.
  ///[create]
  Future<AssistantData> create({
    required Assistant assistant,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kAssistants,
      assistant.toJsonV2(),
      headers: headersAssistants,
      onSuccess: AssistantData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///Returns a list of assistants.
  ///[list]
  Future<List<AssistantData>> list() {
    return _client.get(
      _client.apiUrl + kAssistants,
      headers: headersAssistants,
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
  Future<AssistantData> retrieves({
    required String assistantId,
  }) {
    return _client.get(
      _client.apiUrl + kAssistants + "/$assistantId",
      headers: headersAssistants,
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
      headers: headersAssistants,
      onSuccess: AssistantData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///Delete an assistant.
  ///[delete]
  Future<DeleteAssistant> delete({
    required String assistantId,
  }) {
    return _client.delete(
      _client.apiUrl + kAssistants + "/$assistantId",
      headers: headersAssistants,
      onSuccess: DeleteAssistant.fromJson,
      onCancel: (_) => null,
    );
  }
}

class Assistants {
  final OpenAIClient _client;
  Assistants(this._client);

  Map<String, String> get getHeader => headersAssistants;

  void addHeader(Map<String, String> mHeader) {
    if (mHeader == {}) return;

    headersAssistants.addAll(mHeader);
  }

  ///Assistants Version2
  ///We have changed the way that tools and files work in the Assistants API
  /// between the v1 and v2 versions of the beta.
  /// Both versions of the beta continue to be accessible via the API today,
  /// but we recommend migrating to the newest version of our APIs as soon as feasible.
  /// We will deprecate v1 of the beta by the end of 2024.
  AssistantsV2 get v2 => AssistantsV2(_client);

  @Deprecated('Using Assistants Version 2')
  ///Create an assistant with a model and instructions.
  ///[create]
  Future<AssistantData> create({
    required Assistant assistant,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kAssistants,
      assistant.toJson(),
      headers: headersAssistants,
      onSuccess: AssistantData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }


  @Deprecated('Using Assistants Version 2')
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
      _client.apiUrl + kAssistants + "/$assistantId/files",
      {
        'file_id': fileId,
      },
      headers: headersAssistants,
      onSuccess: AssistantFileData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  @Deprecated('Using Assistants Version 2')
  ///Returns a list of assistants.
  ///[list]
  Future<List<AssistantData>> list() {
    return _client.get(
      _client.apiUrl + kAssistants,
      headers: headersAssistants,
      onSuccess: (it) => it['data'] == null
          ? []
          : List<AssistantData>.from(
              it['data'].map((x) => AssistantData.fromJson(x)),
            ),
      onCancel: (_) => null,
    );
  }

  @Deprecated('Using Assistants Version 2')
  ///Returns a list of assistant files.
  ///[listFile]
  ///[assistantId]
  ///The ID of the assistant the file belongs to.
  Future<ListAssistantFile> listFile({
    required String assistantId,
  }) {
    return _client.get(
      _client.apiUrl + kAssistants + "/$assistantId/files",
      headers: headersAssistants,
      onSuccess: ListAssistantFile.fromJson,
      onCancel: (_) => null,
    );
  }

  @Deprecated('Using Assistants Version 2')
  ///Retrieves an assistant.
  ///[retrieves]
  Future<AssistantData> retrieves({
    required String assistantId,
  }) {
    return _client.get(
      _client.apiUrl + kAssistants + "/$assistantId",
      headers: headersAssistants,
      onSuccess: AssistantData.fromJson,
      onCancel: (_) => null,
    );
  }

  @Deprecated('Using Assistants Version 2')
  ///Retrieves an AssistantFile.
  /// [retrievesFile]
  Future<AssistantFileData> retrievesFile({
    required String fileId,
    required String assistantId,
  }) {
    return _client.get(
      _client.apiUrl + kAssistants + "/$assistantId/files/$fileId",
      headers: headersAssistants,
      onSuccess: AssistantFileData.fromJson,
      onCancel: (_) => null,
    );
  }

  @Deprecated('Using Assistants Version 2')
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
      headers: headersAssistants,
      onSuccess: AssistantData.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  @Deprecated('Using Assistants Version 2')
  ///Delete an assistant.
  ///[delete]
  Future<DeleteAssistant> delete({
    required String assistantId,
  }) {
    return _client.delete(
      _client.apiUrl + kAssistants + "/$assistantId",
      headers: headersAssistants,
      onSuccess: DeleteAssistant.fromJson,
      onCancel: (_) => null,
    );
  }

  ///Delete an assistant file.
  /// [deleteFile]
  Future<DeleteAssistant> deleteFile({
    required String fileId,
    required String assistantId,
  }) {
    return _client.delete(
      _client.apiUrl + kAssistants + "/$assistantId/files/$fileId",
      headers: headersAssistants,
      onSuccess: DeleteAssistant.fromJson,
      onCancel: (_) => null,
    );
  }
}

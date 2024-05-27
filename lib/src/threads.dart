import 'package:chat_gpt_sdk/src/client/openai_client.dart';
import 'package:chat_gpt_sdk/src/messages.dart';
import 'package:chat_gpt_sdk/src/runs.dart';
import 'package:chat_gpt_sdk/src/model/thread/request/thread_request.dart';
import 'package:chat_gpt_sdk/src/model/thread/response/thread_delete_response.dart';
import 'package:chat_gpt_sdk/src/model/thread/response/thread_response.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

class ThreadsV2 {
  final OpenAIClient _client;

  ThreadsV2({required OpenAIClient client}) : _client = client;

  Map<String, String> get getHeader => headersAssistantsV2;

  void addHeader(Map<String, String> mHeader) {
    if (mHeader == {}) return;

    headersAssistantsV2.addAll(mHeader);
  }

  ///Create a thread.
  /// [createThread]
  Future<ThreadResponse> createThread({
    ThreadRequest? request,
  }) {
    return _client.post(
      _client.apiUrl + kThread,
      request == null ? {} : request.toJsonV2(),
      headers: headersAssistantsV2,
      onSuccess: ThreadResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ///The ID of the thread to retrieve.[threadId]
  /// [retrieveThread]
  Future<ThreadResponse> retrieveThread({
    required String threadId,
  }) {
    return _client.get(
      _client.apiUrl + kThread + "/$threadId",
      headers: headersAssistantsV2,
      onSuccess: ThreadResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ///### Example Data
  ///```dart
  ///{
  ///       "metadata": {
  ///         "modified": "true",
  ///         "user": "abc123"
  ///       },
  ///       "tool_resources": {}
  ///     }
  ///```
  Future<ThreadResponse> modifyThread({
    required String threadId,
    required Map<String, dynamic> data,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId",
      data,
      headers: headersAssistantsV2,
      onSuccess: ThreadResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<ThreadDeleteResponse> deleteThread({
    required String threadId,
  }) {
    return _client.delete(
      _client.apiUrl + kThread + "/$threadId",
      headers: headersAssistantsV2,
      onSuccess: ThreadDeleteResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ///messages
  MessagesV2 get messages =>
      MessagesV2(client: _client, headers: headersAssistantsV2);

  ///runs
  Runs get runs => Runs(client: _client, headers: headersAssistantsV2);
}

class Threads {
  final OpenAIClient _client;

  Threads({required OpenAIClient client}) : _client = client;

  Map<String, String> get getHeader => headersAssistants;

  void addHeader(Map<String, String> mHeader) {
    if (mHeader == {}) return;

    headersAssistants.addAll(mHeader);
  }

  @Deprecated("Using Thread Version 2")

  ///Create a thread.
  /// [createThread]
  Future<ThreadResponse> createThread({
    ThreadRequest? request,
  }) {
    return _client.post(
      _client.apiUrl + kThread,
      request == null ? {} : request.toJson(),
      headers: headersAssistants,
      onSuccess: ThreadResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Thread Version 2")

  ///The ID of the thread to retrieve.[threadId]
  /// [retrieveThread]
  Future<ThreadResponse> retrieveThread({
    required String threadId,
  }) {
    return _client.get(
      _client.apiUrl + kThread + "/$threadId",
      headers: headersAssistants,
      onSuccess: ThreadResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Thread Version 2")
  Future<ThreadResponse> modifyThread({
    required String threadId,
    required Map<String, dynamic> metadata,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId",
      metadata,
      headers: headersAssistants,
      onSuccess: ThreadResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Thread Version 2")
  Future<ThreadDeleteResponse> deleteThread({
    required String threadId,
  }) {
    return _client.delete(
      _client.apiUrl + kThread + "/$threadId",
      headers: headersAssistants,
      onSuccess: ThreadDeleteResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ThreadsV2 get v2 => ThreadsV2(client: _client);

  ///messages
  Messages get messages =>
      Messages(client: _client, headers: headersAssistants);

  ///runs
  Runs get runs => Runs(client: _client, headers: headersAssistants);
}

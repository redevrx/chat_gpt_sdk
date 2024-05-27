import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:chat_gpt_sdk/src/model/file/response/delete_file.dart';
import 'package:chat_gpt_sdk/src/model/message/request/create_message.dart';
import 'package:chat_gpt_sdk/src/model/message/response/create_message_response.dart';
import 'package:chat_gpt_sdk/src/model/message/response/list_message_file.dart';
import 'package:chat_gpt_sdk/src/model/message/response/list_message_file_data.dart';
import 'package:chat_gpt_sdk/src/model/message/response/message_data.dart';
import 'package:chat_gpt_sdk/src/model/message/response/message_data_response.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

import 'model/message/response/create_message_v2_response.dart';

class MessagesV2 {
  final OpenAIClient _client;
  final Map<String, String> _headers;

  MessagesV2(
      {required OpenAIClient client, required Map<String, String> headers})
      : _client = client,
        _headers = headers;

  Future<CreateMessageV2Response> createMessage({
    required String threadId,
    required CreateMessage request,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId/$kMessages",
      request.toJsonV2,
      headers: _headers,
      onSuccess: CreateMessageV2Response.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<MessageDataResponse> listMessage({
    required String threadId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
    String? runId,
  }) {
    String url = _client.apiUrl +
        kThread +
        "/$threadId/$kMessages?limit=$limit&order=$order";

    if (before != null && before.isNotEmpty) {
      url += '&before=$before';
    }
    if (after != null && after.isNotEmpty) {
      url += '&after=$after';
    }
    if (runId != null && runId.isNotEmpty) {
      url += '&run_id=$runId';
    }

    return _client.get(
      url,
      headers: _headers,
      onSuccess: MessageDataResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<CreateMessageV2Response> retrieveMessage({
    required String threadId,
    required String messageId,
  }) {
    return _client.get(
      _client.apiUrl + kThread + "/$threadId/$kMessages/$messageId",
      headers: _headers,
      onSuccess: CreateMessageV2Response.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<MessageData> modifyMessage({
    required String threadId,
    required String messageId,
    required Map<String, dynamic> metadata,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId/$kMessages/$messageId",
      headers: _headers,
      metadata,
      onSuccess: MessageData.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<DeleteFile> deleteMessage({
    required String threadId,
    required String messageId,
  }) {
    return _client.delete(
      _client.apiUrl + kThread + "/$threadId/$kMessages/$messageId",
      headers: _headers,
      onSuccess: DeleteFile.fromJson,
      onCancel: (cancelData) => null,
    );
  }
}

class Messages {
  final OpenAIClient _client;
  final Map<String, String> _headers;

  Messages({required OpenAIClient client, required Map<String, String> headers})
      : _client = client,
        _headers = headers;

  @Deprecated("Using Message Version 2")
  Future<MessageData> createMessage({
    required String threadId,
    required CreateMessage request,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId/$kMessages",
      request.toJson(),
      headers: _headers,
      onSuccess: MessageData.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Message Version 2")
  Future<CreateMessageResponse> listMessage({
    required String threadId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
    String? runId,
  }) {
    String url = _client.apiUrl +
        kThread +
        "/$threadId/$kMessages?limit=$limit&order=$order";

    if (before != null && before.isNotEmpty) {
      url += '&before=$before';
    }
    if (after != null && after.isNotEmpty) {
      url += '&after=$after';
    }
    if (runId != null && runId.isNotEmpty) {
      url += '&run_id=$runId';
    }

    return _client.get(
      url,
      headers: _headers,
      onSuccess: CreateMessageResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Message Version 2")
  Future<ListMessageFile> listMessageFile({
    required String threadId,
    required String messageId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
  }) {
    String url = _client.apiUrl +
        kThread +
        "/$threadId/$kMessages/$messageId/$kFile?limit=$limit&order=$order";

    if (before != null && before.isNotEmpty) {
      url += '&before=$before';
    }
    if (after != null && after.isNotEmpty) {
      url += '&after=$after';
    }

    return _client.get(
      url,
      headers: _headers,
      onSuccess: ListMessageFile.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Message Version 2")
  Future<MessageData> retrieveMessage({
    required String threadId,
    required String messageId,
  }) {
    return _client.get(
      _client.apiUrl + kThread + "/$threadId/$kMessages/$messageId",
      headers: _headers,
      onSuccess: MessageData.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Message Version 2")
  Future<ListMessageFileData> retrieveMessageFile({
    required String threadId,
    required String messageId,
    required String fileId,
  }) {
    return _client.get(
      _client.apiUrl +
          kThread +
          "/$threadId/$kMessages/$messageId/$kFile/$fileId",
      headers: _headers,
      onSuccess: ListMessageFileData.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Message Version 2")
  Future<MessageData> modifyMessage({
    required String threadId,
    required String messageId,
    required Map<String, dynamic> metadata,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId/$kMessages/$messageId",
      headers: _headers,
      metadata,
      onSuccess: MessageData.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("Using Message Version 2")
  Future<DeleteFile> deleteMessage({
    required String threadId,
    required String messageId,
  }) {
    return _client.delete(
      _client.apiUrl + kThread + "/$threadId/$kMessages/$messageId",
      headers: _headers,
      onSuccess: DeleteFile.fromJson,
      onCancel: (cancelData) => null,
    );
  }
}

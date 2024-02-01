import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:chat_gpt_sdk/src/model/message/request/create_message.dart';
import 'package:chat_gpt_sdk/src/model/message/response/create_message_response.dart';
import 'package:chat_gpt_sdk/src/model/message/response/list_message_file.dart';
import 'package:chat_gpt_sdk/src/model/message/response/list_message_file_data.dart';
import 'package:chat_gpt_sdk/src/model/message/response/message_data.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

class Messages {
  final OpenAIClient _client;
  final Map<String, String> _headers;

  Messages({required OpenAIClient client, required Map<String, String> headers})
      : _client = client,
        _headers = headers;

  Future<CreateMessageResponse> createMessage({
    required String threadId,
    required CreateMessage request,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId/$kMessages",
      request.toJson(),
      headers: _headers,
      onSuccess: CreateMessageResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<List<CreateMessageResponse>> listMessage({
    required String threadId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
  }) {
    String url = after != null || before != null
        ? _client.apiUrl +
            kThread +
            "/$threadId/$kMessages?limit=$limit&order=$order&after=$after&before=$before"
        : _client.apiUrl +
            kThread +
            "/$threadId/$kMessages?limit=$limit&order=$order";

    return _client.get(
      url,
      headers: _headers,
      onSuccess: (it) => it['data'] == null
          ? []
          : List<CreateMessageResponse>.from(
              it['data'].map(
                (x) => CreateMessageResponse.fromJson(x),
              ),
            ),
      onCancel: (cancelData) => null,
    );
  }

  Future<ListMessageFile> listMessageFile({
    required String threadId,
    required String messageId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
  }) {
    String url = after != null || before != null
        ? _client.apiUrl +
            kThread +
            "/$threadId/$kMessages/$messageId/$kFile?limit=$limit&order=$order&after=$after&before=$before"
        : _client.apiUrl +
            kThread +
            "/$threadId/$kMessages/$messageId/$kFile?limit=$limit&order=$order";

    return _client.get(
      url,
      headers: _headers,
      onSuccess: ListMessageFile.fromJson,
      onCancel: (cancelData) => null,
    );
  }

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

  Future<MessageData> modifyMessage({
    required String threadId,
    required String messageId,
    required Map<String, dynamic> metadata,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId/$kMessages/$messageId",
      metadata,
      onSuccess: MessageData.fromJson,
      onCancel: (cancelData) => null,
    );
  }
}

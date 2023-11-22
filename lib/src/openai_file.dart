import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/model/file/request/upload_file.dart';
import 'package:chat_gpt_sdk/src/model/file/response/delete_file.dart';
import 'package:chat_gpt_sdk/src/model/file/response/file_response.dart';
import 'package:chat_gpt_sdk/src/model/file/response/upload_response.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

import 'client/client.dart';

class OpenAIFile {
  final OpenAIClient _client;
  OpenAIFile(this._client);

  ///Returns a list of files that belong to the user's organization.
  Future<FileResponse> get({void Function(CancelData cancelData)? onCancel}) {
    return _client.get(
      _client.apiUrl + kFile,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => FileResponse.fromJson(it),
    );
  }

  ///Upload a file that contains document(s)
  /// to be used across various endpoints/features.
  /// Currently, the size of all the files uploaded
  /// by one organization can be up to 1 GB. Please
  /// contact us if you need to increase the storage limit.[uploadFile]
  Future<UploadResponse> uploadFile(
    UploadFile request, {
    void Function(CancelData cancelData)? onCancel,
  }) async {
    final mRequest = await request.getForm();

    return _client.postFormData(
      _client.apiUrl + kFile,
      mRequest,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) => UploadResponse.fromJson(it),
    );
  }

  ///Delete a file.
  Future<DeleteFile> delete(
    String fileId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.delete(
      "${_client.apiUrl}$kFile/{$fileId}",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => DeleteFile.fromJson(it),
    );
  }

  ///Returns information about a specific file.
  Future<UploadResponse> retrieve(
    String fileId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.get(
      "${_client.apiUrl}$kFile/$fileId",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => UploadResponse.fromJson(it),
    );
  }

  ///Returns the contents of the specified file
  Future retrieveContent(
    String fileId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.get(
      '${_client.apiUrl}$kFile/$fileId/content',
      returnRawData: true,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => it,
    );
  }
}

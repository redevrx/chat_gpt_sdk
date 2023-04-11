import 'package:chat_gpt_sdk/src/model/file/request/upload_file.dart';
import 'package:chat_gpt_sdk/src/model/file/response/delete_file.dart';
import 'package:chat_gpt_sdk/src/model/file/response/file_response.dart';
import 'package:chat_gpt_sdk/src/model/file/response/upload_response.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:dio/dio.dart';

import 'client/client.dart';

class OpenAIFile {
  final OpenAIClient _client;
  OpenAIFile(this._client);

  final _cancel = CancelToken();

  ///Returns a list of files that belong to the user's organization.
  Future<FileResponse> get() {
    return _client.get(kURL + kFile, _cancel,
        onSuccess: (it) => FileResponse.fromJson(it));
  }

  ///Upload a file that contains document(s)
  /// to be used across various endpoints/features.
  /// Currently, the size of all the files uploaded
  /// by one organization can be up to 1 GB. Please
  /// contact us if you need to increase the storage limit.[uploadFile]
  Future<UploadResponse> uploadFile(UploadFile request) async {
    final mRequest = await request.getForm();
    return _client.postFormData(kURL + kFile, _cancel, mRequest,
        complete: (it) => UploadResponse.fromJson(it));
  }

  ///Delete a file.
  Future<DeleteFile> delete(String fileId) async {
    return _client.delete("$kURL$kFile/{$fileId}", _cancel,
        onSuccess: (it) => DeleteFile.fromJson(it));
  }

  ///Returns information about a specific file.
  Future<UploadResponse> retrieve(String fileId) async {
    return _client.get("$kURL$kFile/$fileId", _cancel,
        onSuccess: (it) => UploadResponse.fromJson(it));
  }

  ///Returns the contents of the specified file
  Future<dynamic> retrieveContent(String fileId) async {
    return _client.get('$kURL$kFile/$fileId/content', _cancel,
        onSuccess: (it) => it as dynamic);
  }

  ///cancel file
  void cancelFile() {
    _client.log.log("stop openAI");
    _cancel.cancel();
  }
}

import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/model/edits/request/edit_request.dart';
import 'package:chat_gpt_sdk/src/model/edits/response/edit_response.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/file_info.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/response/gen_img_response.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

import 'client/client.dart';
import 'model/gen_image/request/variation.dart';

class Edit {
  final OpenAIClient _client;
  Edit(this._client);

  ///Given a prompt and an instruction,
  /// the model will return an edited
  /// version of the prompt.[prompt]
  Future<EditResponse> prompt(
    EditRequest request, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kEditPrompt,
      request.toJson(),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => EditResponse.fromJson(it),
    );
  }

  ///Creates an edited or extended image
  /// given an original image and a prompt.[editImage]
  Future<GenImgResponse> editImage(
    EditImageRequest request, {
    void Function(CancelData cancelData)? onCancel,
  }) async {
    final mRequest = await request.convert();

    return _client.postFormData(
      _client.apiUrl + kImageEdit,
      mRequest,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) => GenImgResponse.fromJson(it),
    );
  }

  ///Creates a variation of a given image.[variation]
  Future<GenImgResponse> variation(
    Variation request, {
    void Function(CancelData cancelData)? onCancel,
  }) async {
    final mRequest = await request.convert();

    return _client.postFormData(
      _client.apiUrl + kVariation,
      mRequest,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) => GenImgResponse.fromJson(it),
    );
  }
}

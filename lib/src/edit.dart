import 'package:chat_gpt_sdk/src/model/edits/request/edit_request.dart';
import 'package:chat_gpt_sdk/src/model/edits/response/edit_response.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/edit_image.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/response/gen_img_response.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:dio/dio.dart';

import 'client/client.dart';
import 'model/gen_image/request/variation.dart';

class Edit {
  final OpenAIClient _client;
  Edit(this._client);

  final _cancel = CancelToken();

  ///Given a prompt and an instruction,
  /// the model will return an edited
  /// version of the prompt.[prompt]
  Future<EditResponse> prompt(EditRequest request) {
    return _client.post(kURL + kEditPrompt, _cancel, request.toJson(),
        onSuccess: (it) {
      return EditResponse.fromJson(it);
    });
  }

  ///Creates an edited or extended image
  /// given an original image and a prompt.[editImage]
  Future<GenImgResponse> editImage(EditImageRequest request) async {
    final mRequest = await request.convert();
    return _client.postFormData(kURL + kImageEdit, _cancel, mRequest,
        complete: (it) {
      return GenImgResponse.fromJson(it);
    });
  }

  ///Creates a variation of a given image.[variation]
  Future<GenImgResponse> variation(Variation request) async {
    final mRequest = await request.convert();
    return _client.postFormData(kURL + kVariation, _cancel, mRequest,
        complete: (it) {
      return GenImgResponse.fromJson(it);
    });
  }

  ///cancel edit
  void cancelEdit() {
    _client.log.log("stop openAI edit");
    _cancel.cancel();
  }
}

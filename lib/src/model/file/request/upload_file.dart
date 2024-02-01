import 'dart:io';

import 'package:chat_gpt_sdk/src/model/gen_image/request/file_info.dart';
import 'package:dio/dio.dart';

class UploadFile {
  ///Name of the JSON Lines file to be uploaded.
  ///If the is set to "fine-tune",
  ///each line is a JSON record with "prompt" and "completion"
  /// fields representing your training examples.purpose. [file]
  final FileInfo file;

  ///The intended purpose of the uploaded documents.
  ///Use "fine-tune" for Fine-tuning.
  ///This allows us to validate the format of the uploaded file.[purpose]
  final String purpose;

  UploadFile({required this.file, this.purpose = 'fine-tune'});

  Future<FormData> getForm() async {
    return FormData.fromMap({
      'file': (await File(file.path).exists())
          ? await MultipartFile.fromFile(file.path, filename: file.name)
          : null,
      'purpose': purpose,
    });
  }
}

import 'dart:io';

import 'package:chat_gpt_sdk/src/model/gen_image/enum/format.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/enum/image_size.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/file_info.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class Variation {
  ///The image to edit. Must be a valid PNG file, less than 4MB,
  /// and square. If mask is not provided, image must have transparency,
  /// which will be used as the mask.[image]
  /// file name is image
  final FileInfo image;

  ///The number of images to generate. Must be between 1 and 10.[n]
  final int n;

  ///The size of the generated images.[size]
  final ImageSize size;

  ///The format in which the generated images are returned.
  /// Must be one of or .url b64_json .[responseFormat]
  final Format responseFormat;

  ///A unique identifier representing your end-user,
  /// which can help OpenAI to monitor and detect abuse.[user]
  final String? user;

  Variation({
    required this.image,
    this.n = 2,
    this.size = ImageSize.size1024,
    this.responseFormat = Format.url,
    this.user,
  });

  Future<FormData> convert() async {
    return FormData.fromMap({
      'image': File(image.path).existsSync()
          ? await MultipartFile.fromFile(
              image.path,
              filename: image.name,
              contentType: MediaType('image', 'png'),
            )
          : null,
      'n': n,
      'size': size.size,
      'response_format': responseFormat.name,
      "user": user,
    });
  }

  Map<String, dynamic> toJson() => Map.of({
        'image': image,
        'n': n,
        'size': size.size,
        'response_format': responseFormat.name,
        "user": user,
      });
}

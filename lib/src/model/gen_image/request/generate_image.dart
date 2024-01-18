import 'package:chat_gpt_sdk/src/model/gen_image/enum/format.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/enum/generate_image_model.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/enum/image_size.dart';

class GenerateImage {
  /// prompt string Required A text description of the desired image(s). The maximum length is 1000 characters.
  final String prompt;

  ///The number of images to generate. Must be between 1 and 10.
  final int n;

  ///The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
  final ImageSize? size;

  ///The format in which the generated images are returned. Must be one of url or b64_json.
  final Format? responseFormat;

  ///A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
  final String user;

  final GenerateImageModel model;

  GenerateImage(
    this.prompt,
    this.n, {
    required this.model,
    this.size = ImageSize.size1024,
    this.responseFormat = Format.url,
    this.user = "",
  }) : assert(1 <= n && n <= 10, 'n must be between 1 and 10.');

  Map<String, dynamic> toJson() => Map.of({
        "prompt": prompt,
        "model": model.model,
        "n": n,
        "size": size?.size,
        "response_format": responseFormat?.getName(),
        "user": user,
      });
}

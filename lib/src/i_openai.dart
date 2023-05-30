import 'model/cancel/cancel_data.dart';
import 'model/chat_complete/request/chat_complete_text.dart';
import 'model/chat_complete/response/chat_ct_response.dart';
import 'model/chat_complete/response/chat_response_sse.dart';
import 'model/client/http_setup.dart';
import 'model/complete_text/request/complete_text.dart';
import 'model/complete_text/response/complete_response.dart';
import 'model/gen_image/request/generate_image.dart';
import 'model/gen_image/response/gen_img_response.dart';
import 'openai.dart';

mixin IOpenAI {
  OpenAI build({String? token, HttpSetup? baseOption, bool enableLog = false});
  listModel({void Function(CancelData cancelData)? onCancel});
  listEngine({void Function(CancelData cancelData)? onCancel});
  Future<CompleteResponse?> onCompletion({
    required CompleteText request,
    void Function(CancelData cancelData)? onCancel,
  });
  Stream<CompleteResponse> onCompletionSSE({
    required CompleteText request,
    void Function(CancelData cancelData)? onCancel,
  });
  Future<ChatCTResponse?> onChatCompletion({
    required ChatCompleteText request,
    void Function(CancelData cancelData)? onCancel,
  });
  Stream<ChatResponseSSE> onChatCompletionSSE({
    required ChatCompleteText request,
    void Function(CancelData cancelData) onCancel,
  });
  Future<GenImgResponse?> generateImage(
    GenerateImage request, {
    void Function(CancelData cancelData)? onCancel,
  });
}

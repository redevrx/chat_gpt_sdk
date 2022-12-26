import 'package:chat_gpt/src/model/err_data.dart';

class ReqError {
  late final ErrorData error ;

  ReqError({required this.error});

  // ReqError fromJson(Map<String,dynamic> data) => ReqError(error: data["error"] as ErrorData);
}


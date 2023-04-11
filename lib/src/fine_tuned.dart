import 'package:chat_gpt_sdk/src/model/fine_tune/request/create_fine.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'client/client.dart';
import 'model/fine_tune/response/fine_tune_delete.dart';
import 'model/fine_tune/response/fine_tune_response.dart';

class FineTune {
  final OpenAIClient _client;
  FineTune(this._client);

  final _cancel = CancelToken();

  Future<FineTuneModel> create(CreateFineTune request) async {
    return _client.post(kURL + kFineTune, _cancel, request.toJson(),
        onSuccess: (it) => FineTuneModel.formJson(it));
  }

  Future<List<FineTuneModel>> list() async {
    return _client.get(kURL + kFineTune, _cancel, onSuccess: (it) {
      final data = it['data'] as List;
      return data.map((e) => FineTuneModel.formJson(e)).toList();
    });
  }

  Future<FineTuneModel> retrieve(String fineTuneId) async {
    return _client.get("$kURL$kFineTune/$fineTuneId", _cancel,
        onSuccess: (it) => FineTuneModel.formJson(it));
  }

  Future<FineTuneModel> cancel(String fineTuneId) async {
    return _client.post("$kURL$kFineTune/$fineTuneId/cancel", _cancel, {},
        onSuccess: (it) => FineTuneModel.formJson(it));
  }

  Future<FineTuneDelete> delete(String model) {
    return _client.delete("$kURL$kFineTuneModel/$model", _cancel,
        onSuccess: (it) => FineTuneDelete.fromJson(it));
  }

  Stream<List<FineTuneModel>> listStream(String fineTuneId) {
    return _client.getStream("$kURL$kFineTune/$fineTuneId/events", _cancel,
        onSuccess: (it) {
      final data = it['data'] as List;
      return data.map((e) => FineTuneModel.formJson(e)).toList();
    });
  }

  ///cancel file
  void cancelFileTune() {
    _client.log.log("stop openAI");
    _cancel.cancel();
  }
}

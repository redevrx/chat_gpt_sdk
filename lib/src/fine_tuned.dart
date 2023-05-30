import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/request/create_fine_tune.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'client/client.dart';
import 'model/fine_tune/response/fine_tune_delete.dart';
import 'model/fine_tune/response/fine_tune_model.dart';

class FineTuned {
  final OpenAIClient _client;
  FineTuned(this._client);

  Future<FineTuneModel> create(CreateFineTune request,
      {void Function(CancelData cancelData)? onCancel,})  {

    return _client.post(kURL + kFineTune, request.toJson(),
        onCancel: (it) => onCancel != null ? onCancel(it) : null,
        onSuccess: (it) => FineTuneModel.formJson(it),);
  }

  Future<List<FineTuneModel>> list(
      {void Function(CancelData cancelData)? onCancel,}) async {

    return _client.get(kURL + kFineTune,
        onCancel: (it) => onCancel != null ? onCancel(it) : null,
        onSuccess: (it) {
          final data = it['data'] as List;

          return data.map((e) => FineTuneModel.formJson(e)).toList();
        },);
  }

  Future<FineTuneModel> retrieve(String fineTuneId,
      {void Function(CancelData cancelData)? onCancel,})  {

    return _client.get("$kURL$kFineTune/$fineTuneId",
        onCancel: (it) => onCancel != null ? onCancel(it) : null,
        onSuccess: (it) => FineTuneModel.formJson(it),);
  }

  Future<FineTuneModel> cancel(String fineTuneId,
      {void Function(CancelData cancelData)? onCancel,})  {

    return _client.post("$kURL$kFineTune/$fineTuneId/cancel", {},
        onCancel: (it) => onCancel != null ? onCancel(it) : null,
        onSuccess: (it) => FineTuneModel.formJson(it),);
  }

  Future<FineTuneDelete> delete(String model,
      {void Function(CancelData cancelData)? onCancel,}) {

    return _client.delete("$kURL$kFineTuneModel/$model",
        onCancel: (it) => onCancel != null ? onCancel(it) : null,
        onSuccess: (it) => FineTuneDelete.fromJson(it),);
  }

  Stream<List<FineTuneModel>> listStream(String fineTuneId,
      {void Function(CancelData cancelData)? onCancel,}) {

    return _client.getStream("$kURL$kFineTune/$fineTuneId/events",
        onCancel: (it) => onCancel != null ? onCancel(it) : null,
        onSuccess: (it) {
          final data = it['data'] as List;

          return data.map((e) => FineTuneModel.formJson(e)).toList();
        },);
  }
}

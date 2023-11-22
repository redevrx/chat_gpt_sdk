import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/request/create_fine_tune.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/request/create_fine_tune_job.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/response/job/fine_tune_list.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/response/job/fine_tune_model_job.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';
import 'client/client.dart';
import 'model/fine_tune/response/fine_tune_delete.dart';
import 'model/fine_tune/response/fine_tune_model.dart';

class FineTuned {
  final OpenAIClient _client;
  FineTuned(this._client);

  @Deprecated('Creates a job that fine-tunes a specified model'
      ' from a given dataset.Response includes details of the'
      ' enqueued job including job status and the name of the'
      ' fine-tuned models once complete.')
  Future<FineTuneModel> create(
    CreateFineTune request, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kFineTune,
      request.toJson(),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => FineTuneModel.fromJson(it),
    );
  }

  @Deprecated('API Deprecated')
  Future<List<FineTuneModel>> list({
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.get(
      _client.apiUrl + kFineTune,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) {
        final data = it['data'] as List;

        return data.map((e) => FineTuneModel.fromJson(e)).toList();
      },
    );
  }

  @Deprecated('API Deprecated')
  Future<FineTuneModel> retrieve(
    String fineTuneId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.get(
      "$_client.apiUrl$kFineTune/$fineTuneId",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => FineTuneModel.fromJson(it),
    );
  }

  @Deprecated('API Deprecated')
  Future<FineTuneModel> cancel(
    String fineTuneId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      "$_client.apiUrl$kFineTune/$fineTuneId/cancel",
      {},
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => FineTuneModel.fromJson(it),
    );
  }

  @Deprecated('API Deprecated')
  Future<FineTuneDelete> delete(
    String model, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.delete(
      "$_client.apiUrl$kFineTuneModel/$model",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => FineTuneDelete.fromJson(it),
    );
  }

  @Deprecated('API Deprecated')
  Stream<List<FineTuneModel>> listStream(
    String fineTuneId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.getStream(
      "$_client.apiUrl$kFineTune/$fineTuneId/events",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) {
        final data = it['data'] as List;

        return data.map((e) => FineTuneModel.fromJson(e)).toList();
      },
    );
  }

/**
 * new api
 */

  ///Creates a job that fine-tunes a specified model from a given dataset.
  ///Response includes details of the enqueued job including job status
  ///and the name of the fine-tuned models once complete. [createFineTuneJob]
  Future<FineTuneModelJob> createFineTuneJob(
    CreateFineTuneJob request, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      _client.apiUrl + kFineTuneJob,
      request.toJson(),
      onSuccess: FineTuneModelJob.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///Get info about a fine-tuning job.[retrieveFineTuneJob]
  Future<FineTuneList> retrieveFineTuneJob(
    String fineTuneId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.get(
      _client.apiUrl + kFineTuneJob + "/$fineTuneId",
      onSuccess: FineTuneList.fromJson,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
    );
  }

  ///List your organization's fine-tuning jobs
  Future<List<FineTuneList>> listFineTuneJob({
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.get(
      _client.apiUrl + kFineTune,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) {
        final data = it['data'] as List;

        return data.map((e) => FineTuneList.fromJson(e)).toList();
      },
    );
  }

  ///Immediately cancel a fine-tune job.
  Future<FineTuneList> cancelFineTuneJob(
    String fineTuneId, {
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.post(
      "$_client.apiUrl$kFineTuneJob/$fineTuneId/cancel",
      {},
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: FineTuneList.fromJson,
    );
  }

  ///Get status updates for a fine-tuning job.
  Stream<List<FineTuneList>> listFineTuneJobStream(
    String fineTuneId, {
    String? after,
    int? limit,
    void Function(CancelData cancelData)? onCancel,
  }) {
    Map<String, dynamic>? query;

    if (after != null || limit != null) {
      query = Map.of({
        'after': after,
        'limit': limit,
      });
    }

    return _client.getStream(
      "$_client.apiUrl$kFineTuneJob/$fineTuneId/events",
      queryParameters: query,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) {
        final data = it['data'] as List;

        return data.map((e) => FineTuneList.fromJson(e)).toList();
      },
    );
  }
}

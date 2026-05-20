import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/message/response/image_data.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/assistant_file_data.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/list_assistant_file.dart';
import 'package:chat_gpt_sdk/src/model/assistant/response/tool.dart';
import 'package:chat_gpt_sdk/src/model/run/response/create_run_response.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/function_data.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/json_schema.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/response/fine_tune_event.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/response_format.dart';
import 'package:chat_gpt_sdk/src/model/message/response/content.dart';
import 'package:chat_gpt_sdk/src/model/message/response/content_v2.dart';
import 'package:chat_gpt_sdk/src/model/message/response/create_message_response.dart';
import 'package:chat_gpt_sdk/src/model/message/response/list_message_file.dart';
import 'package:chat_gpt_sdk/src/model/message/response/list_message_file_data.dart';
import 'package:chat_gpt_sdk/src/model/message/response/text_data.dart';
import 'package:chat_gpt_sdk/src/model/run/response/message_creation.dart';
import 'package:chat_gpt_sdk/src/model/run/response/step_detail.dart';
import 'package:chat_gpt_sdk/src/model/assistant/enum/assistant_model.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/request/chat_audio_config.dart';
import 'package:test/test.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/response/job/fine_tune_list.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/response/job/fine_tune_model_job.dart';
import 'package:chat_gpt_sdk/src/model/run/response/list_run.dart';
import 'package:chat_gpt_sdk/src/model/fine_tune/request/hyper_parameter.dart';
import 'package:chat_gpt_sdk/src/model/embedding/enum/embed_model.dart';
import 'package:chat_gpt_sdk/src/model/chat_complete/enum/chat_model.dart'
    as cm;
import 'package:chat_gpt_sdk/src/model/fine_tune/enum/fine_model.dart' as fm;
import 'package:chat_gpt_sdk/src/model/gen_image/enum/generate_image_model.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/file_info.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/request/variation.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/enum/image_size.dart';
import 'package:chat_gpt_sdk/src/model/gen_image/enum/format.dart';
import 'dart:io';

void main() {
  group('Model Coverage Unit Tests', () {
    test('ImageData serialization', () {
      final json = {'url': 'http://url', 'file_id': 'fid', 'detail': 'high'};
      final model = ImageData.fromJson(json);
      expect(model.url, 'http://url');
      expect(model.fileId, 'fid');
      expect(model.detail, 'high');

      final map = model.toJson();
      expect(map['url'], 'http://url');
      expect(map['file_id'], 'fid');
      expect(map['detail'], 'high');
    });

    test('AssistantFileData serialization', () {
      final json = {
        'assistant_id': 'asst_123',
        'created_at': 12345,
        'id': 'file_123',
        'object': 'file',
      };
      final model = AssistantFileData.fromJson(json);
      expect(model.assistantId, 'asst_123');
      expect(model.createdAt, 12345);
      expect(model.id, 'file_123');
      expect(model.object, 'file');

      final map = model.toJson();
      expect(map['assistant_id'], 'asst_123');
      expect(map['created_at'], 12345);
      expect(map['id'], 'file_123');
      expect(map['object'], 'file');
    });

    test('ListAssistantFile serialization', () {
      final json = {
        'object': 'list',
        'data': [
          {
            'assistant_id': 'asst_123',
            'created_at': 12345,
            'id': 'file_123',
            'object': 'file',
          },
        ],
        'first_id': 'file_123',
        'last_id': 'file_123',
        'has_more': false,
      };
      final model = ListAssistantFile.fromJson(json);
      expect(model.object, 'list');
      expect(model.data.first.id, 'file_123');
      expect(model.firstId, 'file_123');
      expect(model.lastId, 'file_123');
      expect(model.hasMore, false);

      final map = model.toJson();
      expect(map['object'], 'list');
      expect(map['first_id'], 'file_123');
      expect(map['last_id'], 'file_123');
      expect(map['has_more'], false);
    });

    test('Tool serialization', () {
      final json = {'type': 'code_interpreter'};
      final model = Tool.fromJson(json);
      expect(model.type, 'code_interpreter');

      final map = model.toJson();
      expect(map['type'], 'code_interpreter');
    });

    test('FunctionData serialization', () {
      final model = FunctionData(
        name: 'my_func',
        description: 'desc',
        parameters: {'type': 'object'},
      );
      final map = model.toJson();
      expect(map['name'], 'my_func');
      expect(map['description'], 'desc');
      expect(map['parameters']['type'], 'object');
    });

    test('JsonSchema serialization', () {
      final model = JsonSchema(name: 'schema_name', schema: {'type': 'object'});
      final map = model.toJson();
      expect(map['name'], 'schema_name');
      expect(map['schema']['type'], 'object');
      expect(map['strict'], true);
    });

    test('FineTuneEvent serialization', () {
      final json = {'created_at': 12345, 'level': 'info', 'message': 'msg'};
      final model = FineTuneEvent.fromJson(json);
      expect(model.createdAt.millisecondsSinceEpoch, 12345000);
      expect(model.level, 'info');
      expect(model.message, 'msg');
    });

    test('ResponseFormat serialization', () {
      final schema = JsonSchema(
        name: 'schema_name',
        schema: {'type': 'object'},
      );
      final model = ResponseFormat.jsonSchema(jsonSchema: schema);
      final map = model.toJson();
      expect(map['type'], 'json_schema');
      expect(map['json_schema']['name'], 'schema_name');

      final objectFormat = ResponseFormat.jsonObject;
      expect(objectFormat.type, 'json_object');
    });

    test('Content serialization', () {
      final json = {
        'type': 'text',
        'text': {'value': 'hello text', 'annotations': []},
      };
      final model = Content.fromJson(json);
      expect(model.type, 'text');
      expect(model.text?.value, 'hello text');

      final map = model.toJson();
      expect(map['type'], 'text');
      expect(map['text']['value'], 'hello text');
    });

    test('ContentV2 serialization', () {
      // Text type
      final textJson = {
        'type': 'text',
        'text': {'value': 'hello text v2', 'annotations': []},
      };
      final textModel = ContentV2.fromJson(textJson);
      expect(textModel.type, 'text');
      expect(textModel.text?.value, 'hello text v2');
      expect(textModel.toJson()['text']['value'], 'hello text v2');

      // Image type
      final imageJson = {
        'type': 'image_url',
        'image_url': {'url': 'http://img', 'file_id': 'f1', 'detail': 'high'},
      };
      final imageModel = ContentV2.fromJson(imageJson);
      expect(imageModel.type, 'image_url');
      expect(imageModel.image?.url, 'http://img');
      expect(imageModel.toJson()['image_url']['url'], 'http://img');
    });

    test('CreateMessageResponse serialization', () {
      final json = {
        'first_id': 'm1',
        'last_id': 'm1',
        'has_more': false,
        'object': 'list',
        'data': [
          {
            'id': 'msg_123',
            'object': 'thread.message',
            'created_at': 12345,
            'thread_id': 't1',
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text': {'value': 'hello', 'annotations': []},
              },
            ],
            'assistant_id': 'asst_1',
            'run_id': 'run_1',
            'file_ids': ['file_1'],
            'metadata': {},
          },
        ],
      };
      final model = CreateMessageResponse.fromJson(json);
      expect(model.firstId, 'm1');
      expect(model.data.first.id, 'msg_123');

      final map = model.toJson();
      expect(map['first_id'], 'm1');
      expect(map['data'].first['id'], 'msg_123');
    });

    test('ListMessageFile serialization', () {
      final json = {
        'first_id': 'f1',
        'last_id': 'f1',
        'has_more': false,
        'object': 'list',
        'data': [
          {
            'created_at': 12345,
            'message_id': 'msg_123',
            'id': 'file_123',
            'object': 'thread.message.file',
          },
        ],
      };
      final model = ListMessageFile.fromJson(json);
      expect(model.firstId, 'f1');
      expect(model.data.first.id, 'file_123');

      final map = model.toJson();
      expect(map['first_id'], 'f1');
    });

    test('ListMessageFileData serialization', () {
      final json = {
        'created_at': 12345,
        'message_id': 'msg_123',
        'id': 'file_123',
        'object': 'thread.message.file',
      };
      final model = ListMessageFileData.fromJson(json);
      expect(model.createdAt, 12345);
      expect(model.messageId, 'msg_123');
      expect(model.id, 'file_123');
      expect(model.object, 'thread.message.file');

      final map = model.toJson();
      expect(map['created_at'], 12345);
    });

    test('TextData serialization', () {
      final json = {
        'value': 'txt',
        'annotations': ['a1'],
      };
      final model = TextData.fromJson(json);
      expect(model.value, 'txt');
      expect(model.annotations.first, 'a1');

      final map = model.toJson();
      expect(map['value'], 'txt');
      expect(map['annotations'].first, 'a1');
    });

    test('MessageCreation serialization', () {
      final json = {'message_id': 'msg1'};
      final model = MessageCreation.fromJson(json);
      expect(model.messageId, 'msg1');

      final map = model.toJson();
      expect(map['message_id'], 'msg1');
    });

    test('StepDetail serialization', () {
      final json = {
        'type': 'message_creation',
        'message_creation': {'message_id': 'msg1'},
      };
      final model = StepDetail.fromJson(json);
      expect(model.type, 'message_creation');
      expect(model.messageCreation.messageId, 'msg1');

      final map = model.toJson();
      expect(map['type'], 'message_creation');
      expect(map['message_creation']['message_id'], 'msg1');
    });

    test('AssistantModel subclasses', () {
      expect(Gpt4AModel().model, kChatGpt4);
      expect(GptTurbo0301AModel().model, kChatGptTurbo0301Model);
      expect(GptTurbo1106AModel().model, kChatGptTurbo1106);
      expect(GptTurboModel().model, kChatGptTurboModel);
      expect(Gpt41106PreviewAModel().model, kGpt41106Preview);
      expect(Gpt4OModel().model, kGpt4o);
      expect(Gpt4O2024Model().model, kGpt4O2024);
      expect(Gpt4oMiniModel().model, kGpt4oMini);
      expect(Gpt4oMini2024Model().model, kGpt4oMini2024);
      expect(Gpt41Model().model, kGpt41);
      expect(Gpt41MiniModel().model, kGpt41Mini);
      expect(Gpt41NanoModel().model, kGpt41Nano);
      expect(AssistantModelFromValue(model: 'custom').model, 'custom');
    });

    test('ChatAudioConfig serialization', () {
      final json = {'voice': 'alloy', 'format': 'wav'};
      final model = ChatAudioConfig.fromJson(json);
      expect(model.voice, 'alloy');
      expect(model.format, 'wav');

      final map = model.toJson();
      expect(map['voice'], 'alloy');
      expect(map['format'], 'wav');
    });

    test('AssistantData serialization', () {
      final json = {
        'instructions': 'instructions',
        'metadata': {'key': 'val'},
        'name': 'asst_name',
        'file_ids': ['f1'],
        'created_at': 12345,
        'model': 'gpt-4',
        'id': 'asst_123',
        'tools': [],
        'object': 'assistant',
        'description': 'desc',
        'top_p': 1.0,
        'temperature': 0.7,
      };
      final model = AssistantData.fromJson(json);
      expect(model.instructions, 'instructions');
      expect(model.metadata['key'], 'val');
      expect(model.name, 'asst_name');
      expect(model.fileIds.first, 'f1');
      expect(model.createdAt, 12345);
      expect(model.model, 'gpt-4');
      expect(model.id, 'asst_123');
      expect(model.object, 'assistant');
      expect(model.description, 'desc');
      expect(model.topP, 1.0);
      expect(model.temperature, 0.7);

      final map = model.toJson();
      expect(map['instructions'], 'instructions');
      expect(map['metadata']['key'], 'val');
      expect(map['name'], 'asst_name');
    });

    test('CreateMessageV2Response serialization', () {
      final json = {
        'id': 'msg_123',
        'object': 'thread.message',
        'created_at': 12345,
        'thread_id': 't1',
        'role': 'user',
        'content': [
          {
            'type': 'text',
            'text': {'value': 'hello text v2', 'annotations': []},
          },
        ],
        'assistant_id': 'asst_1',
        'run_id': 'run_1',
        'attachments': [],
        'metadata': {},
      };
      final model = CreateMessageV2Response.fromJson(json);
      expect(model.id, 'msg_123');
      expect(model.content.first.text?.value, 'hello text v2');

      final map = model.toJson();
      expect(map['id'], 'msg_123');
    });

    test('ThreadResponse serialization', () {
      final json = {
        'metadata': {'key': 'val'},
        'created_at': 12345,
        'id': 't1',
        'object': 'thread',
        'tool_resources': {'code_interpreter': {}},
      };
      final model = ThreadResponse.fromJson(json);
      expect(model.metadata['key'], 'val');
      expect(model.createdAt, 12345);
      expect(model.id, 't1');
      expect(model.object, 'thread');
      expect(model.toolResources?['code_interpreter'], isNotNull);

      final map = model.toJson();
      expect(map['id'], 't1');
    });

    test('DeleteAssistant serialization', () {
      final json = {
        'deleted': true,
        'id': 'asst_123',
        'object': 'assistant.deleted',
      };
      final model = DeleteAssistant.fromJson(json);
      expect(model.deleted, true);
      expect(model.id, 'asst_123');
      expect(model.object, 'assistant.deleted');

      final map = model.toJson();
      expect(map['deleted'], true);
    });

    test('ThreadDeleteResponse serialization', () {
      final json = {
        'deleted': true,
        'id': 'thread_123',
        'object': 'thread.deleted',
      };
      final model = ThreadDeleteResponse.fromJson(json);
      expect(model.deleted, true);
      expect(model.id, 'thread_123');
      expect(model.object, 'thread.deleted');

      final map = model.toJson();
      expect(map['deleted'], true);
    });

    test('MessageDataResponse serialization', () {
      final json = {
        'first_id': 'msg_1',
        'last_id': 'msg_1',
        'has_more': false,
        'object': 'list',
        'data': [
          {
            'id': 'msg_123',
            'object': 'thread.message',
            'created_at': 12345,
            'thread_id': 't1',
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text': {'value': 'hello text v2', 'annotations': []},
              },
            ],
            'assistant_id': 'asst_1',
            'run_id': 'run_1',
            'attachments': [],
            'metadata': {},
          },
        ],
      };
      final model = MessageDataResponse.fromJson(json);
      expect(model.firstId, 'msg_1');
      expect(model.data.first.id, 'msg_123');

      final map = model.toJson();
      expect(map['first_id'], 'msg_1');
    });

    test('CreateRunResponse serialization', () {
      final json = {
        'id': 'run_123',
        'object': 'thread.run',
        'created_at': 12345,
        'assistant_id': 'asst_123',
        'thread_id': 't1',
        'status': 'queued',
        'started_at': 12345,
        'expires_at': 12345,
        'cancelled_at': 12345,
        'failed_at': 12345,
        'completed_at': 12345,
        'last_error': {},
        'model': 'gpt-4',
        'instructions': 'inst',
        'tools': [],
        'file_ids': [],
        'metadata': {},
        'usage': null,
        'required_action': {'type': 'submit_tool_outputs'},
        'incomplete_details': {'reason': 'max_tokens'},
        'temperature': 0.7,
        'top_p': 1.0,
        'max_prompt_tokens': 100,
        'max_completion_tokens': 100,
        'truncation_strategy': {'type': 'last_messages'},
        'tool_choice': 'auto',
        'response_format': 'auto',
        'tool_resources': {'code_interpreter': {}},
        'step_details': null,
      };
      final model = CreateRunResponse.fromJson(json);
      expect(model.id, 'run_123');
      expect(model.requiredAction?['type'], 'submit_tool_outputs');

      final map = model.toJson();
      expect(map['id'], 'run_123');
    });

    test('FineTuneList serialization', () {
      final json = {
        'training_file': 'file_123',
        'result_files': ['f1'],
        'finished_at': 12345,
        'fine_tuned_model': 'ft-model',
        'created_at': 12345,
        'organization_id': 'org_123',
        'hyperparameters': {'n_epochs': 4},
        'model': 'babbage-002',
        'id': 'ft-123',
        'trained_tokens': 100,
        'object': 'fine_tuning.job',
        'status': 'succeeded',
      };
      final model = FineTuneList.fromJson(json);
      expect(model.id, 'ft-123');
      expect(model.hyperparameters.nEpochs, 4);

      final map = model.toJson();
      expect(map['id'], 'ft-123');
    });

    test('FineTuneModelJob serialization', () {
      final json = {
        'training_file': 'file_123',
        'result_files': [],
        'organization_id': 'org_123',
        'created_at': 12345,
        'model': 'babbage-002',
        'id': 'ft-job-123',
        'object': 'fine_tuning.job',
        'status': 'pending',
      };
      final model = FineTuneModelJob.fromJson(json);
      expect(model.id, 'ft-job-123');

      final map = model.toJson();
      expect(map['id'], 'ft-job-123');
    });

    test('ListRun serialization', () {
      final json = {
        'first_id': 'r1',
        'last_id': 'r1',
        'has_more': false,
        'object': 'list',
        'data': [
          {
            'id': 'run_123',
            'object': 'thread.run',
            'created_at': 12345,
            'assistant_id': 'asst_123',
            'thread_id': 't1',
            'status': 'queued',
            'started_at': 12345,
            'expires_at': 12345,
            'cancelled_at': 12345,
            'failed_at': 12345,
            'completed_at': 12345,
            'last_error': {},
            'model': 'gpt-4',
            'instructions': 'inst',
            'tools': [],
            'file_ids': [],
            'metadata': {},
            'usage': null,
            'step_details': null,
          },
        ],
      };
      final model = ListRun.fromJson(json);
      expect(model.firstId, 'r1');
      expect(model.data.first.id, 'run_123');

      final map = model.toJson();
      expect(map['first_id'], 'r1');
    });

    test('Hyperparameter serialization', () {
      final json = {'n_epochs': 5};
      final model = Hyperparameter.fromJson(json);
      expect(model.nEpochs, 5);

      final model2 = Hyperparameter(nEpochs: 'auto', suffix: 'sfx');
      final map = model2.toJson();
      expect(map['n_epochs'], 'auto');
      expect(map['suffix'], 'sfx');
    });

    test('EmbedModel subclasses', () {
      expect(TextEmbeddingAda002EmbedModel().model, kEmbeddingAda002);
      expect(TextEmbedding3SmallModel().model, kTextEmbedding3Small);
      expect(TextEmbedding3LargeModel().model, kTextEmbedding3Large);
      expect(EmbedModelFromValue(model: 'custom').model, 'custom');
    });

    test('ChatModel subclasses', () {
      expect(cm.GptTurboChatModel().model, kChatGptTurboModel);
      expect(cm.GptTurbo0301ChatModel().model, kChatGptTurbo0301Model);
      expect(cm.ChatModelFromValue(model: 'custom').model, 'custom');
      expect(cm.Gpt4ChatModel().model, kChatGpt4);
      expect(cm.Gpt40314ChatModel().model, kChatGpt40314);
      expect(cm.Gpt432kChatModel().model, kChatGpt432k);
      expect(cm.Gpt432k0314ChatModel().model, kChatGpt432k0314);
      expect(cm.GptTurbo0631Model().model, kChatGptTurbo0613);
      expect(cm.GptTurbo1106Model().model, kChatGptTurbo1106);
      expect(cm.GptTurbo16k0631Model().model, kChatGptTurbo16k0613);
      expect(cm.Gpt40631ChatModel().model, kChatGpt40631);
      expect(cm.Gpt4VisionPreviewChatModel().model, kGpt4VisionPreview);
      expect(cm.Gpt4OChatModel().model, kGpt4o);
      expect(cm.Gpt4O2024ChatModel().model, kGpt4O2024);
      expect(cm.Gpt4oMiniChatModel().model, kGpt4oMini);
      expect(cm.Gpt4oMini2024ChatModel().model, kGpt4oMini2024);
      expect(cm.Gpt41ChatModel().model, kGpt41);
      expect(cm.Gpt41MiniChatModel().model, kGpt41Mini);
      expect(cm.Gpt41NanoChatModel().model, kGpt41Nano);
      expect(cm.Gpt41106PreviewChatModel().model, kGpt41106Preview);
      expect(cm.O1ChatModel().model, kO1);
      expect(cm.O12024ChatModel().model, kO120241217);
      expect(cm.O1PreviewChatModel().model, kO1Preview);
      expect(cm.O1Preview2024ChatModel().model, kO1Preview20240912);
      expect(cm.O1MiniChatModel().model, kO1Mini);
      expect(cm.O1Mini2024ChatModel().model, kO1Mini20240912);
      expect(cm.O3MiniChatModel().model, kO3Mini);
      expect(cm.O3Mini2025ChatModel().model, kO3Mini20250131);
      expect(cm.Gpt5ChatModel().model, kGpt5);
      expect(cm.Gpt5MiniChatModel().model, kGpt5Mini);
    });

    test('FineModel subclasses', () {
      expect(fm.GptTurbo0631Model().model, kChatGptTurbo0613);
      expect(fm.Babbage002FineModel().model, kBabbage002Model);
      expect(fm.FineModelFromValue(model: 'custom').model, 'custom');
    });

    test('GenerateImageModel subclasses', () {
      expect(DallE2().model, kDallE2);
      expect(DallE3().model, kDallE3);
    });

    test('FileInfo and EditImageRequest', () async {
      final fileInfo = FileInfo('dummy_path.png', 'dummy_name.png');
      expect(fileInfo.toString(), '[dummy_path.png,dummy_name.png]');

      final request = EditImageRequest(
        image: fileInfo,
        mask: FileInfo('mask_path.png', 'mask_name.png'),
        prompt: 'a cat',
        n: 1,
        size: ImageSize.size256,
        responseFormat: Format.b64Json,
        user: 'user123',
      );
      final jsonMap = request.toJson();
      expect(jsonMap['prompt'], 'a cat');
      expect(jsonMap['user'], 'user123');

      // Test convert with non-existent file
      final formData = await request.convert();
      expect(formData, isNotNull);
    });

    test('Variation serialization', () async {
      final fileInfo = FileInfo('dummy_path.png', 'dummy_name.png');
      final request = Variation(
        image: fileInfo,
        n: 1,
        size: ImageSize.size512,
        responseFormat: Format.url,
        user: 'user123',
      );
      final jsonMap = request.toJson();
      expect(jsonMap['user'], 'user123');

      final formData = await request.convert();
      expect(formData, isNotNull);
    });
  });
}

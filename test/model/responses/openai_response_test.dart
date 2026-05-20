import 'package:chat_gpt_sdk/src/model/responses/request/openai_response_request.dart';
import 'package:chat_gpt_sdk/src/model/responses/response/openai_response_data.dart';
import 'package:test/test.dart';

void main() {
  group('OpenAI Responses Request Tests', () {
    test('OpenAiResponseRequest serialization with single input string', () {
      final request = OpenAiResponseRequest(
        model: 'gpt-5.5',
        input: 'Write a quicksort function in Dart',
        background: true,
        reasoning: {'effort': 'high'},
        include: ['code_interpreter_call.outputs'],
        tools: [
          {'type': 'web_search'},
        ],
        toolChoice: 'auto',
      );

      final json = request.toJson();

      expect(json['model'], 'gpt-5.5');
      expect(json['input'], 'Write a quicksort function in Dart');
      expect(json['background'], true);
      expect(json['reasoning'], {'effort': 'high'});
      expect(json['include'], ['code_interpreter_call.outputs']);
      expect(json['tools'], isList);
      expect(json['tools'][0]['type'], 'web_search');
      expect(json['tool_choice'], 'auto');
    });

    test('OpenAiResponseRequest serialization with list input', () {
      final request = OpenAiResponseRequest(
        model: 'gpt-5.5',
        input: [
          {'role': 'user', 'content': 'Hello!'},
        ],
      );

      final json = request.toJson();

      expect(json['model'], 'gpt-5.5');
      expect(json['input'], isList);
      expect(json['input'][0]['role'], 'user');
      expect(json['input'][0]['content'], 'Hello!');
    });
  });

  group('OpenAI Responses Data Tests', () {
    test('OpenAiResponseData parsing from json with nested output and usage', () {
      final json = {
        'id': 'resp_123',
        'object': 'response',
        'status': 'completed',
        'model': 'gpt-5.5',
        'output': [
          {
            'id': 'msg_001',
            'type': 'message',
            'status': 'completed',
            'role': 'assistant',
            'content': [
              {
                'type': 'output_text',
                'text':
                    'Here is the quicksort implementation in Dart:\n```dart\n...\n```',
              },
            ],
          },
        ],
        'usage': {
          'prompt_tokens': 150,
          'completion_tokens': 200,
          'total_tokens': 350,
        },
      };

      final response = OpenAiResponseData.fromJson(json);

      expect(response.id, 'resp_123');
      expect(response.object, 'response');
      expect(response.status, 'completed');
      expect(response.model, 'gpt-5.5');
      expect(response.output, isNotNull);
      expect(response.output!.length, 1);
      expect(response.output![0].id, 'msg_001');
      expect(response.output![0].type, 'message');
      expect(response.output![0].role, 'assistant');
      expect(response.output![0].content, isNotNull);
      expect(response.output![0].content!.length, 1);
      expect(response.output![0].content![0].type, 'output_text');
      expect(response.output![0].content![0].text, contains('quicksort'));

      // Test convenience outputText getter
      expect(response.outputText, startsWith('Here is the quicksort'));

      // Test usage parsing
      expect(response.usage, isNotNull);
      expect(response.usage!.promptTokens, 150);
      expect(response.usage!.completionTokens, 200);
      expect(response.usage!.totalTokens, 350);
    });

    test(
      'OpenAiResponseData outputText returns empty when output is missing or empty',
      () {
        final responseEmptyOutput = OpenAiResponseData(output: []);
        final responseNullOutput = OpenAiResponseData(output: null);

        expect(responseEmptyOutput.outputText, '');
        expect(responseNullOutput.outputText, '');
      },
    );

    test('OpenAiResponseData serialization to json', () {
      final response = OpenAiResponseData(
        id: 'resp_456',
        object: 'response',
        status: 'in_progress',
        model: 'gpt-5.5',
        output: [
          ResponseOutputItem(
            id: 'item_1',
            type: 'message',
            role: 'assistant',
            content: [
              ResponseContentPart(
                type: 'output_text',
                text: 'Working on it...',
              ),
            ],
          ),
        ],
      );

      final json = response.toJson();

      expect(json['id'], 'resp_456');
      expect(json['object'], 'response');
      expect(json['status'], 'in_progress');
      expect(json['model'], 'gpt-5.5');
      expect(json['output'], isList);
      expect(json['output'][0]['id'], 'item_1');
      expect(json['output'][0]['content'][0]['text'], 'Working on it...');
    });
  });
}

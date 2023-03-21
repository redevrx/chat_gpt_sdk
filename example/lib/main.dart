import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

import 'package:chat_gpt_sdk/src/model/openai_model/openai_model_data.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter ChatGPTApi Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final openAI = OpenAI.instance.build(
      token: kWriteYorApiToken,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 30)),
      isLog: true);

  final _textEditingController =
      TextEditingController(text: 'What is Flutter?');

  var _imageUrls = <String>[];
  var _responseMessage = '';
  var _isWaitingResponse = false;
  var _numOfPicture = 1;
  var _imageSize = ImageSize.size256;

  late ModelData _selectedModel;

  late final _aiModel = openAI.listModel();

  Color get iconColor => _isWaitingResponse ? Colors.grey : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              key: const ObjectKey('prompt'),
              controller: _textEditingController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'prompt',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder<AiModel>(
                    future: _aiModel,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final models = snapshot.data!.data;

                      _selectedModel =
                          models.where((e) => e.id == kTextDavinci3).first;

                      return DropdownButton<ModelData>(
                        value: _selectedModel,
                        items: models.map((e) {
                          return DropdownMenuItem<ModelData>(
                            value: e,
                            child: Text(e.id),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedModel = newValue;
                            });
                          }
                        },
                      );
                    }),
                IconButton(
                    onPressed: _isWaitingResponse ? null : _onTapSendMessage,
                    icon: Icon(
                      Icons.send,
                      color: iconColor,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Text('Size:'),
                    DropdownButton<ImageSize>(
                      value: _imageSize,
                      items: ImageSize.values.map((imageSize) {
                        return DropdownMenuItem<ImageSize>(
                          value: imageSize,
                          child: Text(imageSize.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            _imageSize = newValue;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                const Text('Number:'),
                DropdownButton<int>(
                  value: _numOfPicture,
                  items: [1, 2, 4].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _numOfPicture = newValue;
                      });
                    }
                  },
                ),
                IconButton(
                    onPressed: _isWaitingResponse ? null : _onTapRequestImage,
                    icon: Icon(
                      Icons.image,
                      color: iconColor,
                    )),
              ],
            ),
            if (_isWaitingResponse) const CircularProgressIndicator(),
            if (_responseMessage.isNotEmpty)
              Expanded(
                  child: Text(
                key: const ObjectKey('responseMessage'),
                _responseMessage,
              )),
            if (_imageUrls.isNotEmpty)
              GridView.count(
                  key: const ObjectKey('responseImages'),
                  shrinkWrap: true,
                  crossAxisCount: _imageUrls.length == 1 ? 1 : 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: List.generate(_imageUrls.length, (index) {
                    return Image.network(_imageUrls[index]);
                  })),
          ],
        ),
      ),
    );
  }

  /// Handler for tap the send icon
  void _onTapSendMessage() async {
    _reset();
    _sendMessage(
      _textEditingController.text,
      modelName: _selectedModel.id,
    ).then((value) {
      setState(() {
        _responseMessage = value;
        _isWaitingResponse = false;
      });
    });
  }

  /// Handler for tap the image icon
  void _onTapRequestImage() async {
    _reset();
    _generateImage(_textEditingController.text, _numOfPicture, _imageSize)
        .then((value) => setState(() => _imageUrls = value.toList()))
        .catchError((e) => setState(() => _responseMessage = e.toString()))
        .whenComplete(() => setState(() => _isWaitingResponse = false));
  }

  void _reset() {
    setState(() {
      _isWaitingResponse = true;
      _responseMessage = '';
      _imageUrls = [];
    });
  }

  Future<String> _sendMessage(String message,
      {String modelName = kTextDavinci3}) async {
    final request = CompleteText(
      prompt: message,
      model: modelName,
      maxTokens: 200,
    );

    final response = await openAI.onCompletion(
      request: request,
    );
    return response!.choices.first.text;
  }

  Future<Iterable<String>> _generateImage(
      String message, int numOfImages, ImageSize imageSize) async {
    final request = GenerateImage(message, numOfImages, size: imageSize);
    final response = await openAI.generateImage(request);
    final imageUrls = response?.data
        ?.where((e) => e != null && e.url != null)
        .map((e) => e!.url!);
    if (imageUrls == null || imageUrls.isEmpty) {
      throw Exception('Image did not be generated.');
    }
    return imageUrls;
  }
}

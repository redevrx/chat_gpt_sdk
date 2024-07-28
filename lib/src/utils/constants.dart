/// Base ChatGPT Url
const kURL = "https://api.openai.com/v1/";

const kCompletion = 'completions';

///get list model
const kModelList = 'models';

///get list engine
const kEngineList = 'engines';

///generate image with prompt
const kGenerateImage = 'images/generations';

///chat completion
const kChatGptTurbo = 'chat/completions';

///edit prompt
const kEditPrompt = 'edits';

///image edit
const kImageEdit = 'images/edits';

///variation
const kVariation = 'images/variations';

///embeddings
const kEmbedding = 'embeddings';

///audio
const kTranscription = 'audio/transcriptions';
const kTranslations = 'audio/translations';
const kCreateSpeech = 'audio/speech';

///files
const kFile = 'files';

///fine tune
const kFineTune = 'fine-tunes';
const kFineTuneJob = '$kFineTune/jobs';

///threads
const kThread = 'threads';

/// fine tune model
const kFineTuneModel = 'models';

///moderation's
const kModeration = 'moderations';

///assistants
const kAssistants = 'assistants';

///messages
const kMessages = 'messages';

///runs
const kRuns = 'runs';

///model name
const kGpt3TurboInstruct = 'gpt-3.5-turbo-instruct';

///chat complete 3.5 and gpt-4
const kChatGptTurboModel = 'gpt-3.5-turbo'; // gpt 3.5
const kChatGptTurbo0301Model = 'gpt-3.5-turbo-0301';
const kChatGpt4 = 'gpt-4';
const kChatGpt40314 = 'gpt-4-0314';
const kChatGpt432k = 'gpt-4-32k';
const kChatGpt432k0314 = 'gpt-4-32k-0314';
const kChatGptTurbo0613 = 'gpt-3.5-turbo-0613';
const kChatGptTurbo1106 = 'gpt-3.5-turbo-1106';
const kChatGptTurbo16k0613 = 'gpt-3.5-turbo-16k-0613';
const kChatGpt40631 = 'gpt-4-0613';
const kGpt41106Preview = 'gpt-4-1106-preview';
const kGpt4VisionPreview = 'gpt-4-vision-preview';
const kGpt4o = 'gpt-4o';
const kGpt4O2024 = 'gpt-4o-2024-05-13';
const kGpt4oMini = 'gpt-4o-mini';
const kGpt4oMini2024 = 'gpt-4o-mini-2024-07-18';

///edits
// using gpt 4

///embeddings
const kEmbeddingAda002 = 'text-embedding-ada-002';
const kTextEmbedding3Small = 'text-embedding-3-small';
const kTextEmbedding3Large = 'text-embedding-3-large';

///fine tune models
const kBabbage002Model = 'babbage-002';
const kDavinci002Model = 'davinci-002';

///moderation model
const kTextMStable = 'text-moderation-stable';
const kTextMLast = 'text-moderation-latest';

///generate image model
const kDallE2 = 'dall-e-2';
const kDallE3 = 'dall-e-3';

///default header
Map<String, String> kHeader(
  String? token,
  String? orgId,
) {
  final headers = {'Content-Type': 'application/json'};

  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }

  if (orgId != null) {
    headers['OpenAI-Organization'] = orgId;
  }

  return headers;
}

Map<String, String> headersAssistants = {'OpenAI-Beta': 'assistants=v1'};
Map<String, String> headersAssistantsV2 = {'OpenAI-Beta': 'assistants=v2'};

///key data
const kTokenKey = 'token';
const kOrgIdKey = 'orgId';

String translateEngToThai({required String word}) =>
    "Translate this into thai : $word";
String translateThaiToEng({required String word}) =>
    "Translate this into English : $word";
String translateToJapanese({required String word}) =>
    "Translate this into Japanese : $word";

///
const kOpenAI = 'OpenAI';

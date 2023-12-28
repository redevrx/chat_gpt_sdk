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

///files
const kFile = 'files';

///fine tune
const kFineTune = 'fine-tunes';
const kFineTuneJob = '$kFineTune/jobs';

/// fine tune model
const kFineTuneModel = 'models';

///moderation's
const kModeration = 'moderations';

///model name
const kTextDavinci3 = 'text-davinci-003';
const kTextDavinci2 = 'text-davinci-002';
const kCodeDavinci2 = 'code-davinci-002';
const kTextCurie001 = 'text-curie-001';
const kTextBabbage001 = 'text-babbage-001';
const kTextAda001 = 'text-ada-001';

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

///edits
const kEditsTextModel = 'text-davinci-edit-001';
const kEditsCoedModel = 'code-davinci-edit-001';

///embeddings
const kEmbeddingAda002 = 'text-embedding-ada-002';
const kTextSearchAdaDoc001 = 'text-search-ada-doc-001';

///fine tune models
const kAdaModel = 'ada';
const kBabbageModel = 'babbage';
const kCurieModel = 'curie';
const kDavinciModel = 'davinci';

///moderation model
const kTextMStable = 'text-moderation-stable';
const kTextMLast = 'text-moderation-latest';

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

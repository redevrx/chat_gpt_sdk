
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
///edit promopt
const kEditPrompt = 'edits';



///model name
const kTextDavinci3 = 'text-davinci-003';
const kTextDavinci2 = 'text-davinci-002';
const kCodeDavinci2 = 'code-davinci-002';
///chat complete
const kChatGptTurboModel = 'gpt-3.5-turbo'; // gpt 3.5
const kChatGptTurbo0301Model = 'gpt-3.5-turbo-0301';
///edits
const kEditsTextModel = 'text-davinci-edit-001';
const kEditsCoedModel = 'code-davinci-edit-001';

Map<String, String> kHeader(String token, {String orgId = ""}) => {
      "Content-Type": 'application/json',
      "Authorization": "Bearer $token"
    };

Map<String, String> kHeaderOrg(String orgId) => {
  "Content-Type": 'application/json',
  "Authorization": "Bearer $orgId"
};



///key data
const kTokenKey = 'token';
const kOrgIdKey = 'orgId';

String translateEngToThai({required String word}) => "Translate this into thai : $word";
String translateThaiToEng({required String word}) => "Translate this into English : $word";
String translateToJapanese({required String word}) => "Translate this into Japanese : $word";
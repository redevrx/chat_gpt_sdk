
/// Base ChatGPT Url
const kURL = "https://api.openai.com/v1/";

const kCompletion = 'completions';
///get list model
const kModelList = 'models';
///get list engine
const kEngineList = 'engines';
///generate image with prompt
const kGenerateImage = 'images/generations';



///model name
const kTranslateModelV3 = 'text-davinci-003';
const kTranslateModelV2 = 'text-davinci-002';

const kCodeTranslateModelV2 = 'code-davinci-002';

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
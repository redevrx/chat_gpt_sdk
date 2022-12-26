
/// Base ChatGPT Url
const kURL = "https://api.openai.com/v1/";

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
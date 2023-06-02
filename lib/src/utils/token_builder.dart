class TokenBuilder {
  TokenBuilder._();

  static final _instance = TokenBuilder._();

  static TokenBuilder get build => _instance;

  ///token
  String _token = '';

  ///org
  String? _orgId;

  ///set token
  void setToken(String token) {
    _token = token;
  }

  ///set orgId
  void setOrgId(String? orgId) => _orgId = orgId;

  ///get token
  String? get token => _token;

  ///get orgID
  String? get orgId => _orgId;
}

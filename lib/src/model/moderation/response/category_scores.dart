class CategoryScores {
  CategoryScores({
    required this.hate,
    required this.hateThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualMinors,
    required this.violence,
    required this.violenceGraphic,
  });
  late final double hate;
  late final double hateThreatening;
  late final double selfHarm;
  late final double sexual;
  late final double sexualMinors;
  late final double violence;
  late final double violenceGraphic;

  CategoryScores.fromJson(Map<String, dynamic> json){
    hate = json['hate'];
    hateThreatening = json['hate/threatening'];
    selfHarm = json['self-harm'];
    sexual = json['sexual'];
    sexualMinors = json['sexual/minors'];
    violence = json['violence'];
    violenceGraphic = json['violence/graphic'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hate'] = hate;
    _data['hate/threatening'] = hateThreatening;
    _data['self-harm'] = selfHarm;
    _data['sexual'] = sexual;
    _data['sexual/minors'] = sexualMinors;
    _data['violence'] = violence;
    _data['violence/graphic'] = violenceGraphic;
    return _data;
  }
}
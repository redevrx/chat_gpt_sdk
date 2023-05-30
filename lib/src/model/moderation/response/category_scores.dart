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

  CategoryScores.fromJson(Map<String, dynamic> json) {
    hate = json['hate'];
    hateThreatening = json['hate/threatening'];
    selfHarm = json['self-harm'];
    sexual = json['sexual'];
    sexualMinors = json['sexual/minors'];
    violence = json['violence'];
    violenceGraphic = json['violence/graphic'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hate'] = hate;
    data['hate/threatening'] = hateThreatening;
    data['self-harm'] = selfHarm;
    data['sexual'] = sexual;
    data['sexual/minors'] = sexualMinors;
    data['violence'] = violence;
    data['violence/graphic'] = violenceGraphic;

    return data;
  }
}

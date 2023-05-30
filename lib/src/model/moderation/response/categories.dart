class Categories {
  Categories({
    required this.hate,
    required this.hateThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualMinors,
    required this.violence,
    required this.violenceGraphic,
  });
  late final bool hate;
  late final bool hateThreatening;
  late final bool selfHarm;
  late final bool sexual;
  late final bool sexualMinors;
  late final bool violence;
  late final bool violenceGraphic;

  Categories.fromJson(Map<String, dynamic> json) {
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

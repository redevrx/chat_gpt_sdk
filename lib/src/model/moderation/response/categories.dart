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
    hate = json['hate'] as bool? ?? false;
    hateThreatening = json['hate/threatening'] as bool? ?? false;
    selfHarm = json['self-harm'] as bool? ?? false;
    sexual = json['sexual'] as bool? ?? false;
    sexualMinors = json['sexual/minors'] as bool? ?? false;
    violence = json['violence'] as bool? ?? false;
    violenceGraphic = json['violence/graphic'] as bool? ?? false;
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

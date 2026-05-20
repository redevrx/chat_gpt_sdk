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
    hate = (json['hate'] as num?)?.toDouble() ?? 0.0;
    hateThreatening = (json['hate/threatening'] as num?)?.toDouble() ?? 0.0;
    selfHarm = (json['self-harm'] as num?)?.toDouble() ?? 0.0;
    sexual = (json['sexual'] as num?)?.toDouble() ?? 0.0;
    sexualMinors = (json['sexual/minors'] as num?)?.toDouble() ?? 0.0;
    violence = (json['violence'] as num?)?.toDouble() ?? 0.0;
    violenceGraphic = (json['violence/graphic'] as num?)?.toDouble() ?? 0.0;
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

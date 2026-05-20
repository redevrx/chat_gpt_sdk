import 'moderation_result.dart';

class ModerationData {
  ModerationData({
    required this.id,
    required this.model,
    required this.results,
  });

  late final String id;
  late final String model;
  late final List<ModerationResult> results;

  ModerationData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String? ?? '';
    model = json['model'] as String? ?? '';
    results = json['results'] == null
        ? []
        : (json['results'] as List? ?? [])
            .map((e) => ModerationResult.fromJson(Map<String, dynamic>.from(e)))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['results'] = results.map((e) => e.toJson()).toList();

    return data;
  }
}

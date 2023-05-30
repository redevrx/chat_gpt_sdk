class FineTuneDelete {
  final String id;
  final String object;
  final bool deleted;

  FineTuneDelete({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory FineTuneDelete.fromJson(Map<String, dynamic> json) => FineTuneDelete(
        id: json['id'],
        object: json['object'],
        deleted: json['deleted'],
      );
}

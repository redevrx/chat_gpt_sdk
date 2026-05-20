class DeleteAssistant {
  DeleteAssistant({
    required this.deleted,
    required this.id,
    required this.object,
  });

  bool deleted;
  String id;
  String object;

  factory DeleteAssistant.fromJson(Map<String, dynamic> json) =>
      DeleteAssistant(
        deleted: json["deleted"] as bool? ?? false,
        id: json["id"] as String? ?? '',
        object: json["object"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    "deleted": deleted,
    "id": id,
    "object": object,
  };
}

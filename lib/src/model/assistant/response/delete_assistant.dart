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
        deleted: json["deleted"],
        id: json["id"],
        object: json["object"],
      );

  Map<String, dynamic> toJson() => {
        "deleted": deleted,
        "id": id,
        "object": object,
      };
}

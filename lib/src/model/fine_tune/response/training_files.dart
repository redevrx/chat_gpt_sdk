class TrainingFiles {
  /// The id of the file.
  final String id;

  /// The number of bytes in the file.
  final int bytes;

  /// The time the file was created.
  final DateTime createdAt;

  /// The name of the file.
  final String filename;

  /// The purpose of the file.
  final String? purpose;

  const TrainingFiles({
    required this.id,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  factory TrainingFiles.fromJson(Map<String, dynamic> json) {
    return TrainingFiles(
      id: json['id'],
      bytes: json['bytes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        json['created_at'] == null ? 0 : json['created_at'] * 1000,
      ),
      filename: json['filename'],
      purpose: json['purpose'],
    );
  }
}

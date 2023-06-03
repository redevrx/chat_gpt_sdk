class FineTuneEvent {
  /// The date the event was created.
  final DateTime createdAt;

  /// The level of the event.
  final String? level;

  /// The message of the event.
  final String? message;

  const FineTuneEvent({
    required this.createdAt,
    required this.level,
    required this.message,
  });

  factory FineTuneEvent.fromJson(Map<String, dynamic> json) {
    return FineTuneEvent(
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        json['created_at'] == null ? 0 : json['created_at'] * 1000,
      ),
      level: json['level'],
      message: json['message'],
    );
  }
}

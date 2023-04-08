class AudioResponse {
  final String text;

  AudioResponse(this.text);

  factory AudioResponse.fromJson(Map<String, dynamic> json) =>
      AudioResponse(json["text"]);
}

///audio response format.[AudioFormat]
enum AudioFormat { json, text, srt, verboseJson, vtt }

extension AudioFormatExtension on AudioFormat {
  String getName() {
    switch (this) {
      case AudioFormat.json:
        return 'json';
      case AudioFormat.text:
        return 'text';
      case AudioFormat.srt:
        return 'srt';
      case AudioFormat.verboseJson:
        return 'verbose_json';
      case AudioFormat.vtt:
        return 'vtt';
      default:
        return '';
    }
  }
}

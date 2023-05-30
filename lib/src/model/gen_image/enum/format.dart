///The format in which the generated images are returned. Must be one of url or b64_json.
enum Format {
  url,
  b64Json;
}

extension FormatExtension on Format {
  String getName() {
    switch (this) {
      case Format.url:
        return 'url';
      case Format.b64Json:
        return 'b64_json';
      default:
        return '';
    }
  }
}

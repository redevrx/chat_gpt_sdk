import 'dart:convert';

extension JsonDecodeString on String? {
  Map<bool, dynamic> decode() {
    try {
      return Map.of({true: json.decode('$this')});
    } catch (err) {
      return Map.of({false: ""});
    }
  }
}

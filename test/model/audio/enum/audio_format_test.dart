import 'package:chat_gpt_sdk/src/model/audio/enum/audio_format.dart';
import 'package:test/test.dart';

void main() {
  group('audio format test', () {
    test('audio format test with text format', () {
      const text = AudioFormat.text;
      expect(text.getName(), 'text');
      expect(text, isA<AudioFormat>());
    });
    test('audio format test with json format', () {
      const json = AudioFormat.json;
      expect(json.getName(), 'json');
      expect(json, isA<AudioFormat>());
    });
    test('audio format test with srt format', () {
      const srt = AudioFormat.srt;
      expect(srt.getName(), 'srt');
      expect(srt, isA<AudioFormat>());
    });
    test('audio format test with verboseJson format', () {
      const verboseJson = AudioFormat.verboseJson;
      expect(verboseJson.getName(), 'verbose_json');
      expect(verboseJson, isA<AudioFormat>());
    });
    test('audio format test with verboseJson format', () {
      const vtt = AudioFormat.vtt;
      expect(vtt.getName(), 'vtt');
      expect(vtt, isA<AudioFormat>());
    });
  });
}

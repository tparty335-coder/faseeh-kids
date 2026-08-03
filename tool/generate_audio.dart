import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() async {
  final texts = [
    "مرحباً بكَ يا صديقي! سأكون مرشدك في واحات التعلم",
    "استمع جيداً — أيّ من هذه الكلمات تبدأ بصوت ( أَ )؟",
    "أَرْنَبٌ",
    "بَقَرَةٌ",
    "تِمْسَاحٌ",
    "ما هو الصوت المضبوط بالفتحة في بداية كلمة ( أَسَدٌ )؟",
    "أَسَدٌ",
    "إِ (كسرة)",
    "أَ (فتحة)",
    "أُ (ضمة)",
    "استمع للكلمة ( إِبِلٌ ) — ما الحركة في الحرف الأول؟",
    "إِبِلٌ",
    "الفتحة َ",
    "الكسرة ِ",
    "الضمة ُ",
    "هل يمكن نطق الحرف الساكن ْ وحده في أوّل الكلمة؟",
    "السكون لا يبدأ",
    "نعم",
    "لا، يسبقه حرف متحرك",
    "دمج المقطعين ( أَ + كَلَ ) ينتج كلمة:",
    "أَكَلَ",
    "سَأَلَ",
    "قَرَأَ",
    "خريطة المراحل الست. سنبدأ بالمرحلة الأولى: الأصوات القصيرة الفتحة والكسرة والضمة"
  ];

  final dir = Directory('../assets/audio');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }

  for (final text in texts) {
    final cleanText = text.trim();
    final bytes = utf8.encode(cleanText);
    final digest = md5.convert(bytes);
    final filename = '../assets/audio/$digest.mp3';

    if (!File(filename).existsSync()) {
      print('Generating audio for: $cleanText -> $digest.mp3');
      final result = await Process.run(
        'C:\\Users\\momta\\.local\\bin\\uv.exe',
        ['run', '--with', 'edge-tts', 'edge-tts', '--text', cleanText, '--voice', 'ar-EG-ShakirNeural', '--rate', '-10%', '--write-media', filename],
        runInShell: true,
      );
      
      if (result.exitCode != 0) {
        print('Error generating $cleanText: ${result.stderr}');
      }
    } else {
      print('Skipping (already exists): $cleanText');
    }
  }

  print('\\nAll audio files generated! Run "flutter pub get" and rebuild the app.');
}

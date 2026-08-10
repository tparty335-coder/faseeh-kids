import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const Map<String, Map<String, String>> letterSourceMap = {
  'ب': {'key': 'baa', 'exe': 'arabic_1Prim_t1_u2l2ب.exe'},
  'ت': {'key': 'taa', 'exe': 'arabic_1prim_t1U2_ت.exe'},
  'ث': {'key': 'thaa', 'exe': 'arabic_1prim_t1_ث.exe'},
  'ج': {'key': 'jeem', 'exe': 'arabic_1prim_t1_ج.exe'},
  'ح': {'key': 'haa_h', 'exe': 'arabic_1prim_t1U2_ح.exe'},
  'خ': {'key': 'khaa', 'exe': 'arabic_1prim_t1U2_خ.exe'},
  'د': {'key': 'daal', 'exe': 'arabic_1prim_t1U2_د.exe'},
  'ذ': {'key': 'dhaal', 'exe': 'arabic_1prim_t1U2_ذ.exe'},
  'ر': {'key': 'raa', 'exe': 'arabic_1prim_t1U2_ر.exe'},
  'ز': {'key': 'zaay', 'exe': 'arabic_1prim_t1U2_ز.exe'},
  'س': {'key': 'seen', 'exe': 'arabic_1prim_t1_س.exe'},
  'ش': {'key': 'sheen', 'exe': 'arabic_1prim_t1_ش.exe'},
  'ص': {'key': 'saad', 'exe': 'arabic_1prim_t1U2_L14ص.exe'},
  'ض': {'key': 'daad', 'exe': 'arabic_1prim_t1_ض.exe'},
  'ط': {'key': 'taa_t', 'exe': 'arabic_1prim_t1U2_ط.exe'},
  'ظ': {'key': 'dhaa_dh', 'exe': 'arabic_1prim_t1U2_ظ.exe'},
  'ع': {'key': 'ain', 'exe': 'arabic_1prim_t1U2_ع.exe'},
  'غ': {'key': 'ghain', 'exe': 'arabic_1prim_t1_غ.exe'},
  'ف': {'key': 'faa', 'exe': 'arabic_1prim_t1U2_ف ـ.exe'},
  'ق': {'key': 'qaaf', 'exe': 'arabic_1prim_t1_ق.exe'},
  'ك': {'key': 'kaaf', 'exe': 'arabic_1prim_t1_ك.exe'},
  'ل': {'key': 'laam', 'exe': 'arabic_1prim_t1_ل.exe'},
  'ن': {'key': 'noon', 'exe': 'arabic_1prim_t1_ن.exe'},
  'ه': {'key': 'haa', 'exe': 'arabic_1prim_t1U2_هـ.exe'},
  'و': {'key': 'waaw', 'exe': 'arabic_1prim_t1U2_و.exe'},
  'ي': {'key': 'yaa', 'exe': 'arabic_1prim_t1U2_ي.exe'},
};

final String baseSourceDir = r'D:\Education  vol2\مناهج 2026\ص1         ت1';

void main() async {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║  RAW MP3 SCANNER — EXTRACTING ALL MP3 AUDIO FROM ALL 26 EXEs      ║');
  print('╚════════════════════════════════════════════════════════════════════╝\n');

  final dstLettersDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\letters');
  await dstLettersDir.create(recursive: true);

  int totalExtracted = 0;

  for (final entry in letterSourceMap.entries) {
    final char = entry.key;
    final key = entry.value['key']!;
    final exeName = entry.value['exe']!;
    final exeFile = File('$baseSourceDir${Platform.pathSeparator}$exeName');

    if (!await exeFile.exists()) continue;

    final bytes = await exeFile.readAsBytes();
    final scratchDir = Directory('d:\\Projects\\faseeh_kids\\scratch\\extracted_$key');
    await scratchDir.create(recursive: true);

    // Scan for all MP3 sync headers: 0xFF 0xFB, 0xFF 0xF3, 0xFF 0xF2, or 'ID3'
    final mp3Streams = <Uint8List>[];

    for (int i = 0; i < bytes.length - 1000; i++) {
      final isMp3Header = (bytes[i] == 0xFF && (bytes[i + 1] == 0xFB || bytes[i + 1] == 0xF3 || bytes[i + 1] == 0xF2)) ||
          (bytes[i] == 0x49 && bytes[i + 1] == 0x44 && bytes[i + 2] == 0x33);

      if (isMp3Header) {
        int start = i;
        int len = 0;
        // Collect contiguous MP3 payload
        while (i + len < bytes.length - 2) {
          // Break on CWS magic or non-audio boundary
          if (bytes[i + len] == 0x43 && bytes[i + len + 1] == 0x57 && bytes[i + len + 2] == 0x53) break;
          if (len > 300000) break; // Cap at 300KB
          len++;
        }

        if (len > 3000) { // Only keep valid audio chunks (>3KB)
          mp3Streams.add(Uint8List.fromList(bytes.sublist(start, start + len)));
          i += len; // Jump past extracted payload
        }
      }
    }

    print('▶ Letter "$char" ($key): Extracted ${mp3Streams.length} MP3 audio streams.');

    // Save and map streams to AudioRegistry standards
    if (mp3Streams.isNotEmpty) {
      mp3Streams.sort((a, b) => a.length.compareTo(b.length));

      final variants = [
        'name', 'sound', 'fatha', 'kasra', 'damma', 'sukoon',
        'word', 'word2', 'word3', 'word4', 'sentence',
        'pos_start', 'pos_middle', 'pos_end',
        'fatha_demo', 'kasra_demo', 'damma_demo', 'madd_demo',
      ];

      for (int v = 0; v < variants.length && v < mp3Streams.length; v++) {
        final variant = variants[v];
        final outFile = File('${dstLettersDir.path}${Platform.pathSeparator}${key}_$variant.mp3');
        await outFile.writeAsBytes(mp3Streams[v]);
        totalExtracted++;
      }
    }
  }

  print('\n╔════════════════════════════════════════════════════════════════════╗');
  print('║  RAW MP3 SCAN COMPLETE! Total Files Integrated: $totalExtracted                  ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
}

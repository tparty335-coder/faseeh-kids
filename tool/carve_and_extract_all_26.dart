import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'extract_swf_assets.dart';

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
  print('║  ULTIMATE CARVER & EXTRACTOR FOR ALL 26 REMAINING LETTERS          ║');
  print('╚════════════════════════════════════════════════════════════════════╝\n');

  final dstLettersDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\letters');
  await dstLettersDir.create(recursive: true);

  int totalExtractedSoundsAcrossAllLetters = 0;
  final stopwatch = Stopwatch()..start();

  for (final entry in letterSourceMap.entries) {
    final char = entry.key;
    final key = entry.value['key']!;
    final exeName = entry.value['exe']!;
    final exePath = '$baseSourceDir${Platform.pathSeparator}$exeName';

    final exeFile = File(exePath);
    if (!await exeFile.exists()) {
      print('⚠️ Source EXE missing for letter $char ($key)');
      continue;
    }

    final scratchDir = Directory('d:\\Projects\\faseeh_kids\\scratch\\extracted_$key');
    await scratchDir.create(recursive: true);

    final bytes = await exeFile.readAsBytes();

    // 1. Find all CWS offsets
    final offsets = <int>[];
    for (int i = 0; i <= bytes.length - 8; i++) {
      if (bytes[i] == 0x43 && bytes[i + 1] == 0x57 && bytes[i + 2] == 0x53) {
        offsets.add(i);
      }
    }

    print('▶ Processing "$char" ($key): ${offsets.length} SWF modules found...');

    final audioOutDir = Directory('${scratchDir.path}${Platform.pathSeparator}audio');
    final imageOutDir = Directory('${scratchDir.path}${Platform.pathSeparator}images');
    await audioOutDir.create(recursive: true);
    await imageOutDir.create(recursive: true);

    int letterSoundsCount = 0;

    for (int idx = 0; idx < offsets.length; idx++) {
      final start = offsets[idx];
      final version = bytes[start + 3];
      if (version > 30) continue;

      final uncompressedLen = bytes[start + 4] | (bytes[start + 5] << 8) | (bytes[start + 6] << 16) | (bytes[start + 7] << 24);
      final endBound = (idx < offsets.length - 1) ? offsets[idx + 1] : bytes.length;
      final payload = bytes.sublist(start + 8, endBound);

      final decompressedBuilder = BytesBuilder();
      final sink = zlib.decoder.startChunkedConversion(
        ChunkedConversionSink<List<int>>.withCallback((chunks) {
          for (final chunk in chunks) decompressedBuilder.add(chunk);
        }),
      );

      try {
        sink.add(payload);
        sink.close();
      } catch (_) {}

      final decompressedBytes = decompressedBuilder.toBytes();
      if (decompressedBytes.length >= 8) {
        final fwsBuilder = BytesBuilder();
        fwsBuilder.add([0x46, 0x57, 0x53, version]);
        fwsBuilder.add([
          uncompressedLen & 0xFF,
          (uncompressedLen >> 8) & 0xFF,
          (uncompressedLen >> 16) & 0xFF,
          (uncompressedLen >> 24) & 0xFF,
        ]);
        fwsBuilder.add(decompressedBytes);

        // Save temporary FWS file and process SWF tags
        final tempSwf = File('${scratchDir.path}/mod_$idx.swf');
        await tempSwf.writeAsBytes(fwsBuilder.toBytes());

        try {
          final report = await processSwfFile(tempSwf, audioOutDir, imageOutDir);
          letterSoundsCount += report.totalSounds;
        } catch (_) {}
      }
    }

    print('   ✓ Extracted $letterSoundsCount sound tags for letter "$char" ($key).');
    totalExtractedSoundsAcrossAllLetters += letterSoundsCount;

    // Map extracted sound files to AudioRegistry standards
    final extractedSounds = audioOutDir.listSync().whereType<File>().toList();
    if (extractedSounds.isNotEmpty) {
      extractedSounds.sort((a, b) => a.lengthSync().compareTo(b.lengthSync()));

      final variants = [
        'name', 'sound', 'fatha', 'kasra', 'damma', 'sukoon',
        'word', 'word2', 'word3', 'word4', 'sentence',
        'pos_start', 'pos_middle', 'pos_end',
        'fatha_demo', 'kasra_demo', 'damma_demo', 'madd_demo',
      ];

      for (int i = 0; i < variants.length && i < extractedSounds.length; i++) {
        final targetFile = File('${dstLettersDir.path}${Platform.pathSeparator}${key}_${variants[i]}.mp3');
        await extractedSounds[i].copy(targetFile.path);
      }
    }
  }

  print('\n╔════════════════════════════════════════════════════════════════════╗');
  print('║  ULTIMATE CARVING COMPLETE IN ${stopwatch.elapsed.inSeconds}s!                                ║');
  print('║  Total Extracted DefineSound Tags: $totalExtractedSoundsAcrossAllLetters                          ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
}

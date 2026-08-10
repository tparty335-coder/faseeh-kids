import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Map of Arabic letter characters to registry keys and EXE filenames
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
  print('║  FASEEH KIDS — BATCH EXTRACTION & INTEGRATION PIPELINE           ║');
  print('║  Targeting 26 Letters from Official MOE Curriculum Bundles        ║');
  print('╚════════════════════════════════════════════════════════════════════╝\n');

  final dstLettersDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\letters');
  final dstFeedbackDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\feedback');
  final dstStoriesDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\stories');

  await dstLettersDir.create(recursive: true);
  await dstFeedbackDir.create(recursive: true);
  await dstStoriesDir.create(recursive: true);

  int totalLettersProcessed = 0;
  int totalAudioFilesGenerated = 0;

  for (final entry in letterSourceMap.entries) {
    final char = entry.key;
    final key = entry.value['key']!;
    final exeName = entry.value['exe']!;

    final exePath = '$baseSourceDir${Platform.pathSeparator}$exeName';
    final exeFile = File(exePath);

    if (!await exeFile.exists()) {
      print('⚠️ Source EXE missing for letter $char ($key): $exePath');
      continue;
    }

    print('\n▶ Processing Letter "$char" ($key) from $exeName [${(await exeFile.length() / 1024 / 1024).toStringAsFixed(1)} MB]...');
    final scratchDir = Directory('d:\\Projects\\faseeh_kids\\scratch\\extracted_$key');
    if (!await scratchDir.exists()) await scratchDir.create(recursive: true);

    final bytes = await exeFile.readAsBytes();

    // 1. Carve SWF chunks
    final offsets = <int>[];
    for (int i = 0; i <= bytes.length - 8; i++) {
      if (bytes[i] == 0x43 && bytes[i + 1] == 0x57 && bytes[i + 2] == 0x53) {
        offsets.add(i);
      }
    }

    print('   Found ${offsets.length} SWF modules in $exeName.');

    final extractedAudioFiles = <File>[];

    // Decompress SWFs and extract audio chunks
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
      if (decompressedBytes.isNotEmpty) {
        // Extract MP3/WAV streams from decompressed SWF byte payload
        final sounds = _extractMp3StreamsFromSwf(decompressedBytes, key, idx);
        for (final soundData in sounds) {
          final audioFile = File('${scratchDir.path}/sound_${idx}_${soundData.index}.mp3');
          await audioFile.writeAsBytes(soundData.bytes);
          extractedAudioFiles.add(audioFile);
        }
      }
    }

    print('   Extracted ${extractedAudioFiles.length} raw audio streams for letter $char.');

    // 2. Classify and map audio files to AudioRegistry standards
    int letterAudioCount = await _catalogAndIntegrateAudio(
      extractedAudioFiles,
      key,
      char,
      dstLettersDir,
      dstStoriesDir,
    );

    totalAudioFilesGenerated += letterAudioCount;
    totalLettersProcessed++;
  }

  print('\n╔════════════════════════════════════════════════════════════════════╗');
  print('║  BATCH EXTRACTION COMPLETE!                                       ║');
  print('║  Letters Processed: $totalLettersProcessed / 26                                 ║');
  print('║  Total Integrated MP3 Assets: $totalAudioFilesGenerated                          ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
}

class SoundStreamData {
  final int index;
  final Uint8List bytes;
  SoundStreamData(this.index, this.bytes);
}

/// Extracts MP3 audio payloads from decompressed SWF bytes by locating MP3 frame headers
List<SoundStreamData> _extractMp3StreamsFromSwf(Uint8List swfBytes, String letterKey, int moduleIdx) {
  final results = <SoundStreamData>[];
  int count = 0;

  // Search for MP3 sync word (0xFF 0xFB, 0xFF 0xF3, 0xFF 0xF2) or ID3 tag
  for (int i = 0; i < swfBytes.length - 4; i++) {
    if ((swfBytes[i] == 0xFF && (swfBytes[i + 1] & 0xE0) == 0xE0) ||
        (swfBytes[i] == 0x49 && swfBytes[i + 1] == 0x44 && swfBytes[i + 2] == 0x33)) {
      int start = i;
      // Scan forward to find audio block boundary
      int end = start + 500;
      while (end < swfBytes.length - 2) {
        if (swfBytes[end] == 0x43 && swfBytes[end + 1] == 0x57 && swfBytes[end + 2] == 0x53) break;
        if (end - start > 500000) break; // Cap at 500KB per stream
        end++;
      }

      final audioBytes = swfBytes.sublist(start, end);
      if (audioBytes.length > 2000) { // Filter out micro clicks
        results.add(SoundStreamData(count++, audioBytes));
        i = end; // Skip forward
      }
    }
  }

  return results;
}

/// Catalog extracted raw audio streams into AudioRegistry standard files
Future<int> _catalogAndIntegrateAudio(
  List<File> rawAudioFiles,
  String letterKey,
  String letterChar,
  Directory dstLetters,
  Directory dstStories,
) async {
  if (rawAudioFiles.isEmpty) return 0;

  // Sort files by size (duration proxy)
  rawAudioFiles.sort((a, b) => a.lengthSync().compareTo(b.lengthSync()));

  int integrated = 0;

  final variants = [
    'name', 'sound', 'fatha', 'kasra', 'damma', 'sukoon',
    'word', 'word2', 'word3', 'word4', 'sentence',
    'pos_start', 'pos_middle', 'pos_end',
    'fatha_demo', 'kasra_demo', 'damma_demo', 'madd_demo',
  ];

  for (int i = 0; i < variants.length && i < rawAudioFiles.length; i++) {
    final variant = variants[i];
    final targetFile = File('${dstLetters.path}${Platform.pathSeparator}${letterKey}_$variant.mp3');
    await rawAudioFiles[i].copy(targetFile.path);
    integrated++;
  }

  // If there are extra long files, integrate as story
  if (rawAudioFiles.length > variants.length) {
    final storyFile = File('${dstStories.path}${Platform.pathSeparator}story_$letterKey.mp3');
    await rawAudioFiles.last.copy(storyFile.path);
    integrated++;
  }

  print('   ✓ Integrated $integrated AudioRegistry MP3 files for "$letterChar" ($letterKey).');
  return integrated;
}

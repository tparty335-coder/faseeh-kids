import 'dart:io';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'extract_swf_assets.dart';

void main() async {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║  DEEP SWF TAG PARSER — EXTRACTING ALL DEFINESOUND TAGS (TAG 14)    ║');
  print('╚════════════════════════════════════════════════════════════════════╝\n');

  final scratchBase = Directory(r'd:\Projects\faseeh_kids\scratch');
  final dstLettersDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\letters');
  await dstLettersDir.create(recursive: true);

  int totalAudioTagsExtracted = 0;

  final scratchDirs = scratchBase.listSync().whereType<Directory>().where((d) => d.path.contains('extracted_'));

  for (final dir in scratchDirs) {
    final letterKey = dir.path.split('extracted_').last;
    final swfFiles = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.swf')).toList();

    if (swfFiles.isEmpty) continue;

    print('▶ Parsing ${swfFiles.length} SWF files in ${dir.path} for letter "$letterKey"...');

    final audioOutDir = Directory('${dir.path}${Platform.pathSeparator}audio');
    final imageOutDir = Directory('${dir.path}${Platform.pathSeparator}images');
    await audioOutDir.create(recursive: true);
    await imageOutDir.create(recursive: true);

    int letterAudioCount = 0;

    for (final swf in swfFiles) {
      try {
        final report = await processSwfFile(swf, audioOutDir, imageOutDir);
        letterAudioCount += report.totalSounds;
      } catch (e) {
        // Continue on uncompressed edge cases
      }
    }

    print('   ✓ Extracted $letterAudioCount DefineSound audio files for letter "$letterKey".');
    totalAudioTagsExtracted += letterAudioCount;

    // Map extracted sound files to AudioRegistry standards
    final extractedSounds = audioOutDir.listSync().whereType<File>().toList();
    if (extractedSounds.isNotEmpty) {
      extractedSounds.sort((a, b) => a.lengthSync().compareTo(b.lengthSync()));

      final variants = AudioRegistry.variants;
      for (int i = 0; i < variants.length && i < extractedSounds.length; i++) {
        final targetFile = File('${dstLettersDir.path}${Platform.pathSeparator}${letterKey}_${variants[i]}.mp3');
        await extractedSounds[i].copy(targetFile.path);
      }
    }
  }

  print('\n╔════════════════════════════════════════════════════════════════════╗');
  print('║  DEEP SWF PARSING COMPLETE!                                        ║');
  print('║  Total Extracted Sound Tags: $totalAudioTagsExtracted                               ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
}

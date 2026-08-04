import 'dart:io';
import 'dart:typed_data';

/// Deep SWF Inspector: Maps DefineSound character IDs to their usage context
/// by analyzing StartSound tags and frame labels surrounding them.
class SoundContext {
  final int characterId;
  final int sizeBytes;
  final int format; // 2=MP3
  final int sampleRate;
  final int sampleCount;
  final double durationSec;
  final List<String> nearbyFrameLabels;
  final int frameIndex; // Which frame this sound first appears in

  SoundContext({
    required this.characterId,
    required this.sizeBytes,
    required this.format,
    required this.sampleRate,
    required this.sampleCount,
    required this.durationSec,
    required this.nearbyFrameLabels,
    required this.frameIndex,
  });
}

List<SoundContext> analyzeSoundContexts(Uint8List swfBytes) {
  // Skip SWF header
  int bitOffset = 8 * 8;
  int nbits = (swfBytes[bitOffset >> 3] >> (8 - 5)) & 0x1F;
  bitOffset += 5 + 4 * nbits;
  int pos = (bitOffset + 7) >> 3;
  pos += 4;

  // Phase 1: Collect all DefineSound, StartSound, ShowFrame, FrameLabel
  final definedSounds = <int, SoundContext>{};
  final soundPlayOrder = <int>[]; // Character IDs in order of first StartSound
  final frameLabels = <int, String>{}; // frameIndex -> label
  int currentFrame = 0;
  String lastFrameLabel = '';

  while (pos < swfBytes.length - 2) {
    final tagHeader = swfBytes[pos] | (swfBytes[pos + 1] << 8);
    final tagCode = tagHeader >> 6;
    int tagLength = tagHeader & 0x3F;
    pos += 2;

    if (tagLength == 0x3F) {
      if (pos + 4 > swfBytes.length) break;
      tagLength = swfBytes[pos] |
          (swfBytes[pos + 1] << 8) |
          (swfBytes[pos + 2] << 16) |
          (swfBytes[pos + 3] << 24);
      pos += 4;
    }

    if (pos + tagLength > swfBytes.length) break;
    final tagBytes = swfBytes.sublist(pos, pos + tagLength);

    // ShowFrame
    if (tagCode == 1) {
      currentFrame++;
    }

    // FrameLabel
    if (tagCode == 43 && tagBytes.isNotEmpty) {
      int end = 0;
      while (end < tagBytes.length && tagBytes[end] != 0) end++;
      lastFrameLabel = String.fromCharCodes(tagBytes.sublist(0, end));
      frameLabels[currentFrame] = lastFrameLabel;
    }

    // DefineSound (tag 14)
    if (tagCode == 14 && tagBytes.length >= 7) {
      final charId = tagBytes[0] | (tagBytes[1] << 8);
      final soundFlags = tagBytes[2];
      final format = (soundFlags >> 4) & 0x0F;
      final rateCode = (soundFlags >> 2) & 0x03;
      final sampleRate = rateCode == 3 ? 44100 : (rateCode == 2 ? 22050 : (rateCode == 1 ? 11025 : 5512));
      final sampleCount = tagBytes[3] |
          (tagBytes[4] << 8) |
          (tagBytes[5] << 16) |
          (tagBytes[6] << 24);
      final audioPayload = tagBytes.sublist(7);
      final duration = sampleCount / sampleRate;

      definedSounds[charId] = SoundContext(
        characterId: charId,
        sizeBytes: audioPayload.length,
        format: format,
        sampleRate: sampleRate,
        sampleCount: sampleCount,
        durationSec: duration,
        nearbyFrameLabels: [],
        frameIndex: currentFrame,
      );
    }

    // StartSound (tag 15) or StartSound2 (tag 89)
    if ((tagCode == 15 || tagCode == 89) && tagBytes.length >= 2) {
      final charId = tagBytes[0] | (tagBytes[1] << 8);
      if (!soundPlayOrder.contains(charId)) {
        soundPlayOrder.add(charId);
        // Associate nearby frame label
        if (definedSounds.containsKey(charId)) {
          if (lastFrameLabel.isNotEmpty) {
            definedSounds[charId]!.nearbyFrameLabels.add(lastFrameLabel);
          }
          // Also check recent frame labels
          for (int f = currentFrame; f >= (currentFrame - 3).clamp(0, currentFrame); f--) {
            if (frameLabels.containsKey(f) && !definedSounds[charId]!.nearbyFrameLabels.contains(frameLabels[f])) {
              definedSounds[charId]!.nearbyFrameLabels.add(frameLabels[f]!);
            }
          }
        }
      }
    }

    pos += tagLength;
    if (tagCode == 0) break;
  }

  // Return sounds in play order
  final result = <SoundContext>[];
  for (final id in soundPlayOrder) {
    if (definedSounds.containsKey(id)) {
      result.add(definedSounds[id]!);
    }
  }
  // Add any defined but never played
  for (final entry in definedSounds.entries) {
    if (!soundPlayOrder.contains(entry.key)) {
      result.add(entry.value);
    }
  }
  return result;
}

Uint8List? decompressCws(Uint8List bytes) {
  final sig = String.fromCharCodes(bytes.sublist(0, 3));
  if (sig == 'CWS') {
    final version = bytes[3];
    final uncompressedLength = bytes[4] | (bytes[5] << 8) | (bytes[6] << 16) | (bytes[7] << 24);
    final decompressed = zlib.decode(bytes.sublist(8));
    final builder = BytesBuilder();
    builder.add([0x46, 0x57, 0x53, version]);
    builder.add([
      uncompressedLength & 0xFF,
      (uncompressedLength >> 8) & 0xFF,
      (uncompressedLength >> 16) & 0xFF,
      (uncompressedLength >> 24) & 0xFF,
    ]);
    builder.add(decompressed);
    return builder.toBytes();
  } else if (sig == 'FWS') {
    return bytes;
  }
  return null;
}

void main() async {
  final inDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif');
  final swfFiles = inDir.listSync().whereType<File>().where((f) => f.path.endsWith('.swf')).toList();
  swfFiles.sort((a, b) => a.path.compareTo(b.path));

  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║  DEEP CONTEXTUAL SOUND ANALYSIS — ALIF (حرف الألف)            ║');
  print('╚══════════════════════════════════════════════════════════════════╝\n');

  for (final file in swfFiles) {
    final bytes = await file.readAsBytes();
    final swfBase = file.uri.pathSegments.last.replaceAll('.swf', '');
    final swfBytes = decompressCws(bytes);
    if (swfBytes == null) continue;

    final contexts = analyzeSoundContexts(swfBytes);
    if (contexts.isEmpty) continue;

    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('📦 Module: $swfBase.swf (${contexts.length} sounds)');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    for (int i = 0; i < contexts.length; i++) {
      final c = contexts[i];
      final durStr = c.durationSec.toStringAsFixed(1);
      final sizeStr = (c.sizeBytes / 1024).toStringAsFixed(1);
      final labelsStr = c.nearbyFrameLabels.isNotEmpty ? c.nearbyFrameLabels.join(', ') : '—';

      // Classification heuristic
      String category;
      if (c.durationSec < 1.0) {
        category = '🔊 PHONEME/CLICK';
      } else if (c.durationSec < 3.0) {
        category = '🗣️ WORD/SHORT';
      } else if (c.durationSec < 8.0) {
        category = '📝 SENTENCE/INSTRUCTION';
      } else {
        category = '🎙️ NARRATION/STORY';
      }

      print('  [${(i+1).toString().padLeft(2)}] ID:${c.characterId.toString().padLeft(4)} | ${durStr.padLeft(5)}s | ${sizeStr.padLeft(6)} KB | Frame:${c.frameIndex.toString().padLeft(3)} | $category | Labels: $labelsStr');
    }
    print('');
  }
}

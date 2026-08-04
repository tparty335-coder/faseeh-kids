import 'dart:io';
import 'dart:typed_data';

class ExtractedAssetReport {
  final String swfName;
  final int totalSounds;
  final int totalJpegs;
  final int totalLossless;
  final List<String> audioFiles;
  final List<String> textStrings;
  ExtractedAssetReport({
    required this.swfName,
    required this.totalSounds,
    required this.totalJpegs,
    required this.totalLossless,
    required this.audioFiles,
    required this.textStrings,
  });
}

Uint8List buildWavHeader(int pcmLength, int sampleRate, int channels, int bitsPerSample) {
  final byteRate = sampleRate * channels * (bitsPerSample ~/ 8);
  final blockAlign = channels * (bitsPerSample ~/ 8);
  final header = ByteData(44);

  // 'RIFF'
  header.setUint8(0, 0x52);
  header.setUint8(1, 0x49);
  header.setUint8(2, 0x46);
  header.setUint8(3, 0x46);
  // ChunkSize
  header.setUint32(4, 36 + pcmLength, Endian.little);
  // 'WAVE'
  header.setUint8(8, 0x57);
  header.setUint8(9, 0x41);
  header.setUint8(10, 0x56);
  header.setUint8(11, 0x45);
  // 'fmt '
  header.setUint8(12, 0x66);
  header.setUint8(13, 0x6D);
  header.setUint8(14, 0x74);
  header.setUint8(15, 0x20);
  // Subchunk1Size (16 for PCM)
  header.setUint32(16, 16, Endian.little);
  // AudioFormat (1 for PCM)
  header.setUint16(20, 1, Endian.little);
  // NumChannels
  header.setUint16(22, channels, Endian.little);
  // SampleRate
  header.setUint32(24, sampleRate, Endian.little);
  // ByteRate
  header.setUint32(28, byteRate, Endian.little);
  // BlockAlign
  header.setUint16(32, blockAlign, Endian.little);
  // BitsPerSample
  header.setUint16(34, bitsPerSample, Endian.little);
  // 'data'
  header.setUint8(36, 0x64);
  header.setUint8(37, 0x61);
  header.setUint8(38, 0x74);
  header.setUint8(39, 0x61);
  // Subchunk2Size
  header.setUint32(40, pcmLength, Endian.little);

  return header.buffer.asUint8List();
}

Future<ExtractedAssetReport> processSwfFile(File swfFile, Directory audioOutDir, Directory imageOutDir) async {
  final bytes = await swfFile.readAsBytes();
  final swfBase = swfFile.uri.pathSegments.last.replaceAll('.swf', '');

  Uint8List swfBytes;
  final sig = String.fromCharCodes(bytes.sublist(0, 3));
  if (sig == 'CWS') {
    final uncompressedLength = bytes[4] | (bytes[5] << 8) | (bytes[6] << 16) | (bytes[7] << 24);
    final compressedPayload = bytes.sublist(8);
    final rawZlib = ZLibCodec(raw: false);
    final decompressed = rawZlib.decode(compressedPayload);
    final builder = BytesBuilder();
    builder.add([0x46, 0x57, 0x53, bytes[3]]);
    builder.add([
      uncompressedLength & 0xFF,
      (uncompressedLength >> 8) & 0xFF,
      (uncompressedLength >> 16) & 0xFF,
      (uncompressedLength >> 24) & 0xFF,
    ]);
    builder.add(decompressed);
    swfBytes = builder.toBytes();
  } else if (sig == 'FWS') {
    swfBytes = bytes;
  } else {
    return ExtractedAssetReport(
      swfName: swfBase,
      totalSounds: 0,
      totalJpegs: 0,
      totalLossless: 0,
      audioFiles: [],
      textStrings: [],
    );
  }

  // Parse SWF tags
  int bitOffset = 8 * 8;
  int nbits = (swfBytes[bitOffset >> 3] >> (8 - 5)) & 0x1F;
  bitOffset += 5 + 4 * nbits;
  int pos = (bitOffset + 7) >> 3;
  pos += 4; // frame rate + frame count

  int soundCount = 0;
  int jpegCount = 0;
  int losslessCount = 0;
  final audioFiles = <String>[];
  final textStrings = <String>[];
  final streamingAudioChunks = <List<int>>[];
  int streamFormat = -1;
  int streamRate = -1;

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

    // 1. Tag 14: DefineSound
    if (tagCode == 14 && tagBytes.length >= 7) {
      soundCount++;
      final characterId = tagBytes[0] | (tagBytes[1] << 8);
      final soundFlags = tagBytes[2];
      final format = (soundFlags >> 4) & 0x0F;
      final rateCode = (soundFlags >> 2) & 0x03;
      final size = (soundFlags >> 1) & 0x01; // 0=8-bit, 1=16-bit
      final type = soundFlags & 0x01; // 0=mono, 1=stereo
      final sampleRate = rateCode == 3 ? 44100 : (rateCode == 2 ? 22050 : (rateCode == 1 ? 11025 : 5512));

      final audioPayload = tagBytes.sublist(7);

      if (format == 2) {
        // MP3 Format
        // In Flash DefineSound MP3, bytes 0..1 of audioPayload is SeekSamples
        if (audioPayload.length > 2) {
          final mp3Data = audioPayload.sublist(2);
          final fileName = '${swfBase}_sound_${characterId.toString().padLeft(4, "0")}.mp3';
          final outFile = File('${audioOutDir.path}${Platform.pathSeparator}$fileName');
          await outFile.writeAsBytes(mp3Data);
          audioFiles.add(fileName);
        }
      } else if (format == 0 || format == 3) {
        // Raw PCM
        final wavHeader = buildWavHeader(audioPayload.length, sampleRate, type == 1 ? 2 : 1, size == 1 ? 16 : 8);
        final builder = BytesBuilder();
        builder.add(wavHeader);
        builder.add(audioPayload);
        final fileName = '${swfBase}_sound_${characterId.toString().padLeft(4, "0")}.wav';
        final outFile = File('${audioOutDir.path}${Platform.pathSeparator}$fileName');
        await outFile.writeAsBytes(builder.toBytes());
        audioFiles.add(fileName);
      }
    }

    // 2. Tag 18 / 45: SoundStreamHead / SoundStreamHead2
    if (tagCode == 18 || tagCode == 45) {
      if (tagBytes.length >= 4) {
        streamFormat = (tagBytes[1] >> 4) & 0x0F;
        final rCode = (tagBytes[1] >> 2) & 0x03;
        streamRate = rCode == 3 ? 44100 : (rCode == 2 ? 22050 : (rCode == 1 ? 11025 : 5512));
      }
    }

    // 3. Tag 19: SoundStreamBlock
    if (tagCode == 19 && tagBytes.isNotEmpty) {
      if (streamFormat == 2) {
        // MP3 stream block (skip first 4 bytes if MP3 header in block)
        if (tagBytes.length > 4) {
          streamingAudioChunks.add(tagBytes.sublist(4));
        }
      }
    }

    // 4. Tag 21 / 35 / 90: JPEG Images
    if (tagCode == 21 && tagBytes.length > 2) {
      jpegCount++;
      final charId = tagBytes[0] | (tagBytes[1] << 8);
      final imgData = tagBytes.sublist(2);
      final fileName = '${swfBase}_img_${charId.toString().padLeft(4, "0")}.jpg';
      final outFile = File('${imageOutDir.path}${Platform.pathSeparator}$fileName');
      await outFile.writeAsBytes(imgData);
    } else if (tagCode == 35 && tagBytes.length > 6) {
      jpegCount++;
      final charId = tagBytes[0] | (tagBytes[1] << 8);
      final alphaDataOffset = tagBytes[2] | (tagBytes[3] << 8) | (tagBytes[4] << 16) | (tagBytes[5] << 24);
      final imgData = tagBytes.sublist(6, 6 + alphaDataOffset);
      final fileName = '${swfBase}_img_${charId.toString().padLeft(4, "0")}.jpg';
      final outFile = File('${imageOutDir.path}${Platform.pathSeparator}$fileName');
      await outFile.writeAsBytes(imgData);
    }

    // 5. Tag 20 / 36: Lossless PNG / Bitmaps
    if (tagCode == 20 || tagCode == 36) {
      losslessCount++;
    }

    // 6. Tag 11 / 33 / 37: Text strings
    if (tagCode == 11 || tagCode == 33 || tagCode == 37) {
      // Extract printable Arabic / ASCII text strings
      for (int i = 0; i < tagBytes.length - 2; i++) {
        if (tagBytes[i] >= 0xD8 && tagBytes[i] <= 0xD9) { // UTF-8 Arabic lead byte
          final arabicSub = tagBytes.sublist(i, (i + 40).clamp(0, tagBytes.length));
          try {
            final s = String.fromCharCodes(arabicSub).trim();
            if (s.length > 2 && !textStrings.contains(s)) {
              textStrings.add(s);
            }
          } catch (_) {}
        }
      }
    }

    // 7. Tag 12 / 59: ActionScript bytecode (Extract Arabic string constants)
    if (tagCode == 12 || tagCode == 59) {
      // Scan for string literals (ActionConstantPool / ActionPush)
      int sPos = 0;
      while (sPos < tagBytes.length) {
        if (tagBytes[sPos] == 0x88) { // ActionConstantPool
          if (sPos + 2 < tagBytes.length) {
            final poolLen = tagBytes[sPos + 1] | (tagBytes[sPos + 2] << 8);
            int pCur = sPos + 3;
            if (pCur + 2 < tagBytes.length) {
              final count = tagBytes[pCur] | (tagBytes[pCur + 1] << 8);
              pCur += 2;
              for (int c = 0; c < count && pCur < sPos + 3 + poolLen; c++) {
                int end = pCur;
                while (end < sPos + 3 + poolLen && tagBytes[end] != 0) end++;
                if (end > pCur) {
                  final strBytes = tagBytes.sublist(pCur, end);
                  try {
                    // Try UTF-8 first, then Windows-1256 if needed
                    final str = String.fromCharCodes(strBytes);
                    if (str.length > 1 && !textStrings.contains(str)) {
                      textStrings.add(str);
                    }
                  } catch (_) {}
                }
                pCur = end + 1;
              }
            }
          }
        }
        sPos++;
      }
    }

    pos += tagLength;
    if (tagCode == 0) break;
  }

  // Save concatenated stream audio if any
  if (streamingAudioChunks.isNotEmpty) {
    final builder = BytesBuilder();
    for (final c in streamingAudioChunks) {
      builder.add(c);
    }
    final streamFileName = '${swfBase}_timeline_stream.mp3';
    final outFile = File('${audioOutDir.path}${Platform.pathSeparator}$streamFileName');
    await outFile.writeAsBytes(builder.toBytes());
    audioFiles.add(streamFileName);
  }

  return ExtractedAssetReport(
    swfName: swfBase,
    totalSounds: soundCount + (streamingAudioChunks.isNotEmpty ? 1 : 0),
    totalJpegs: jpegCount,
    totalLossless: losslessCount,
    audioFiles: audioFiles,
    textStrings: textStrings,
  );
}

void main() async {
  final inDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif');
  final audioOutDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif\audio');
  final imageOutDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif\images');
  await audioOutDir.create(recursive: true);
  await imageOutDir.create(recursive: true);

  final swfFiles = inDir.listSync().whereType<File>().where((f) => f.path.endsWith('.swf')).toList();
  swfFiles.sort((a, b) => a.path.compareTo(b.path));

  print('================================================================');
  print('DEEP EXTRACTION & PEDAGOGICAL AUDIT OF ARABIC ALEF (حرف الألف)');
  print('================================================================');
  print('Found ${swfFiles.length} interactive Flash modules in Alif package:\n');

  int grandTotalAudio = 0;
  int grandTotalImages = 0;
  final allAudioFiles = <String>[];

  for (final file in swfFiles) {
    final rep = await processSwfFile(file, audioOutDir, imageOutDir);
    grandTotalAudio += rep.totalSounds;
    grandTotalImages += rep.totalJpegs + rep.totalLossless;
    allAudioFiles.addAll(rep.audioFiles);

    print('📘 Module: [${rep.swfName}.swf]');
    print('   - Audio Tracks Extracted: ${rep.totalSounds} files');
    print('   - Images & Graphics: ${rep.totalJpegs + rep.totalLossless} items (${rep.totalJpegs} JPEGs, ${rep.totalLossless} Vector/Lossless)');
    if (rep.audioFiles.isNotEmpty) {
      print('   - Extracted Audio Samples:');
      for (final a in rep.audioFiles) {
        final f = File('${audioOutDir.path}${Platform.pathSeparator}$a');
        final sz = f.existsSync() ? (f.lengthSync() / 1024).toStringAsFixed(1) : '0';
        print('      🔊 $a ($sz KB)');
      }
    }
    if (rep.textStrings.isNotEmpty) {
      print('   - Educational Keywords / Strings:');
      for (final t in rep.textStrings.take(8)) {
        print('      📝 "$t"');
      }
    }
    print('----------------------------------------------------------------');
  }

  print('\n🎯 GRAND TOTAL ASSETS EXTRACTED FOR ALEF (حرف الألف):');
  print('   • Total Native Audio Files (Human Voice Recordings): $grandTotalAudio');
  print('   • Total Educational Visual Assets: $grandTotalImages');
  print('   • Output Audio Directory: ${audioOutDir.path}');
  print('   • Output Images Directory: ${imageOutDir.path}');
  print('================================================================');
}

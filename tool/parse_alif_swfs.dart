import 'dart:io';
import 'dart:typed_data';

class TagInfo {
  final int code;
  final String name;
  final int length;
  final int offset;
  TagInfo(this.code, this.name, this.length, this.offset);
}

final tagNames = <int, String>{
  0: 'End',
  1: 'ShowFrame',
  2: 'DefineShape',
  4: 'PlaceObject',
  5: 'RemoveObject',
  6: 'DefineBits',
  7: 'DefineButton',
  8: 'JPEGTables',
  9: 'SetBackgroundColor',
  10: 'DefineFont',
  11: 'DefineText',
  12: 'DoAction',
  13: 'DefineFontInfo',
  14: 'DefineSound',
  15: 'StartSound',
  18: 'SoundStreamHead',
  19: 'SoundStreamBlock',
  20: 'DefineBitsLossless',
  21: 'DefineBitsJPEG2',
  22: 'DefineShape2',
  24: 'Protect',
  26: 'PlaceObject2',
  28: 'RemoveObject2',
  32: 'DefineShape3',
  33: 'DefineText2',
  34: 'DefineButton2',
  35: 'DefineBitsJPEG3',
  36: 'DefineBitsLossless2',
  37: 'DefineEditText',
  39: 'DefineSprite',
  40: 'NameCharacter',
  41: 'ProductInfo',
  43: 'FrameLabel',
  45: 'SoundStreamHead2',
  46: 'DefineMorphShape',
  48: 'DefineFont2',
  56: 'ExportAssets',
  57: 'ImportAssets',
  58: 'EnableDebugger',
  59: 'DoInitAction',
  60: 'DefineVideoStream',
  61: 'VideoFrame',
  62: 'DefineFontInfo2',
  64: 'EnableDebugger2',
  65: 'ScriptLimits',
  66: 'SetTabIndex',
  69: 'FileAttributes',
  70: 'PlaceObject3',
  71: 'ImportAssets2',
  73: 'DefineFontAlignZones',
  74: 'CSMTextSettings',
  75: 'DefineFont3',
  76: 'SymbolClass',
  77: 'Metadata',
  78: 'DefineScalingGrid',
  82: 'DoABC',
  83: 'DefineShape4',
  84: 'DefineMorphShape2',
  86: 'DefineSceneAndFrameLabelData',
  87: 'DefineBinaryData',
  88: 'DefineFontName',
  89: 'StartSound2',
  90: 'DefineBitsJPEG4',
  91: 'DefineFont4',
};

class SoundData {
  final int characterId;
  final int format; // 0=Uncompressed, 1=ADPCM, 2=MP3, 3=Uncompressed LE, 6=Nellymoser
  final int rate;   // 0=5.5kHz, 1=11kHz, 2=22kHz, 3=44kHz
  final int size;   // 0=8bit, 1=16bit
  final int type;   // 0=mono, 1=stereo
  final int sampleCount;
  final Uint8List audioBytes;

  SoundData({
    required this.characterId,
    required this.format,
    required this.rate,
    required this.size,
    required this.type,
    required this.sampleCount,
    required this.audioBytes,
  });
}

class SwfReport {
  final int offset;
  final int version;
  final int uncompressedLength;
  final Map<String, int> tagCounts = {};
  final List<SoundData> sounds = [];
  final List<String> exportedSymbols = [];
  final List<String> frameLabels = [];
  final List<int> imageCharacterIds = [];
  final List<Uint8List> embeddedBinary = [];

  SwfReport(this.offset, this.version, this.uncompressedLength);
}

Uint8List? tryDecompressCws(Uint8List fullExeBytes, int offset) {
  try {
    final version = fullExeBytes[offset + 3];
    final uncompressedLength = fullExeBytes[offset + 4] |
        (fullExeBytes[offset + 5] << 8) |
        (fullExeBytes[offset + 6] << 16) |
        (fullExeBytes[offset + 7] << 24);

    if (uncompressedLength <= 0 || uncompressedLength > 50 * 1024 * 1024) {
      return null;
    }

    final compressedPayload = fullExeBytes.sublist(offset + 8);
    final decompressedPayload = zlib.decode(compressedPayload);

    final result = BytesBuilder();
    result.add([0x46, 0x57, 0x53, version]); // 'FWS' + version
    result.add([
      uncompressedLength & 0xFF,
      (uncompressedLength >> 8) & 0xFF,
      (uncompressedLength >> 16) & 0xFF,
      (uncompressedLength >> 24) & 0xFF,
    ]);
    result.add(decompressedPayload);
    return result.toBytes();
  } catch (e) {
    return null;
  }
}

SwfReport parseSwfBytes(Uint8List swfBytes, int sourceOffset) {
  final version = swfBytes[3];
  final fileLength = swfBytes[4] | (swfBytes[5] << 8) | (swfBytes[6] << 16) | (swfBytes[7] << 24);
  final report = SwfReport(sourceOffset, version, fileLength);

  // Skip RECT, FrameRate (2 bytes), FrameCount (2 bytes)
  int bitOffset = 8 * 8; // start at byte 8
  int nbits = (swfBytes[bitOffset >> 3] >> (8 - 5)) & 0x1F;
  bitOffset += 5 + 4 * nbits;
  int pos = (bitOffset + 7) >> 3; // align to byte
  pos += 4; // skip frame rate (2) and frame count (2)

  final symbolMap = <int, String>{};

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

    if (pos + tagLength > swfBytes.length) {
      break;
    }

    final tagName = tagNames[tagCode] ?? 'UnknownTag_$tagCode';
    report.tagCounts[tagName] = (report.tagCounts[tagName] ?? 0) + 1;

    final tagBytes = swfBytes.sublist(pos, pos + tagLength);

    // Parse DefineSound (tag 14)
    if (tagCode == 14 && tagBytes.length >= 7) {
      final characterId = tagBytes[0] | (tagBytes[1] << 8);
      final soundFlags = tagBytes[2];
      final format = (soundFlags >> 4) & 0x0F;
      final rate = (soundFlags >> 2) & 0x03;
      final size = (soundFlags >> 1) & 0x01;
      final type = soundFlags & 0x01;
      final sampleCount = tagBytes[3] |
          (tagBytes[4] << 8) |
          (tagBytes[5] << 16) |
          (tagBytes[6] << 24);
      
      final audioData = tagBytes.sublist(7);
      report.sounds.add(SoundData(
        characterId: characterId,
        format: format,
        rate: rate,
        size: size,
        type: type,
        sampleCount: sampleCount,
        audioBytes: audioData,
      ));
    }

    // Parse SymbolClass (tag 76)
    if (tagCode == 76 && tagBytes.length >= 2) {
      final numSymbols = tagBytes[0] | (tagBytes[1] << 8);
      int cur = 2;
      for (int i = 0; i < numSymbols && cur < tagBytes.length - 2; i++) {
        final charId = tagBytes[cur] | (tagBytes[cur + 1] << 8);
        cur += 2;
        int end = cur;
        while (end < tagBytes.length && tagBytes[end] != 0) end++;
        if (end <= tagBytes.length) {
          final symName = String.fromCharCodes(tagBytes.sublist(cur, end));
          report.exportedSymbols.add('ID $charId -> $symName');
          symbolMap[charId] = symName;
          cur = end + 1;
        }
      }
    }

    // Parse FrameLabel (tag 43)
    if (tagCode == 43) {
      int end = 0;
      while (end < tagBytes.length && tagBytes[end] != 0) end++;
      final label = String.fromCharCodes(tagBytes.sublist(0, end));
      report.frameLabels.add(label);
    }

    // Parse Images (tag 20, 21, 35, 36, 90)
    if (tagCode == 20 || tagCode == 21 || tagCode == 35 || tagCode == 36 || tagCode == 90) {
      if (tagBytes.length >= 2) {
        final charId = tagBytes[0] | (tagBytes[1] << 8);
        report.imageCharacterIds.add(charId);
      }
    }

    // Parse DefineBinaryData (tag 87)
    if (tagCode == 87 && tagBytes.length >= 6) {
      final data = tagBytes.sublist(6);
      report.embeddedBinary.add(data);
    }

    pos += tagLength;
    if (tagCode == 0) break; // End tag
  }

  return report;
}

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\Arabic_1Peim_T1_CharacterAlefأ.exe');
  final bytes = await file.readAsBytes();

  // Known CWS offsets from our first pass
  final offsets = [
    2043888, // Primary movie
    3007039,
    4989514,
    8801599,
    10105072,
    10931978,
    11969534,
    12726547,
    13244214,
    14080326,
    14950848,
  ];

  print('===============================================================');
  print('ANALYSIS OF ARABIC ALEF FLASH PROJECTOR (حرف الألف)');
  print('===============================================================');

  int totalSounds = 0;
  int totalImages = 0;

  for (final offset in offsets) {
    final swfBytes = tryDecompressCws(bytes, offset);
    if (swfBytes == null) {
      print('Offset 0x${offset.toRadixString(16)}: Failed to decompress (possibly embedded binary or non-zlib)');
      continue;
    }

    final report = parseSwfBytes(swfBytes, offset);
    print('\n-------------------------------------------------------------');
    print('📦 SWF Module at Offset 0x${offset.toRadixString(16).toUpperCase()} (Dec: $offset)');
    print('   - Flash Version: ${report.version}');
    print('   - Uncompressed Size: ${(report.uncompressedLength / 1024).toStringAsFixed(1)} KB');
    print('   - Tag Summary: ${report.tagCounts}');
    print('   - Sounds Count: ${report.sounds.length}');
    print('   - Images Count: ${report.imageCharacterIds.length}');
    print('   - Frame Labels: ${report.frameLabels}');
    if (report.exportedSymbols.isNotEmpty) {
      print('   - Exported Symbols (${report.exportedSymbols.length}):');
      for (final sym in report.exportedSymbols.take(10)) {
        print('      * $sym');
      }
      if (report.exportedSymbols.length > 10) {
        print('      ... and ${report.exportedSymbols.length - 10} more');
      }
    }

    for (int i = 0; i < report.sounds.length; i++) {
      final s = report.sounds[i];
      final fmtStr = s.format == 2 ? 'MP3' : (s.format == 0 ? 'PCM' : (s.format == 1 ? 'ADPCM' : 'Fmt ${s.format}'));
      final rateStr = s.rate == 3 ? '44.1kHz' : (s.rate == 2 ? '22kHz' : (s.rate == 1 ? '11kHz' : '5.5kHz'));
      print('      🔊 Sound [ID ${s.characterId}]: $fmtStr, $rateStr, ${s.type == 1 ? "Stereo" : "Mono"}, Samples: ${s.sampleCount}, Size: ${s.audioBytes.length} bytes');
    }

    totalSounds += report.sounds.length;
    totalImages += report.imageCharacterIds.length;
  }

  print('\n===============================================================');
  print('GRAND TOTAL IN ALEF (الألف):');
  print('Total Audio Tracks: $totalSounds');
  print('Total Visual Assets: $totalImages');
  print('===============================================================');
}

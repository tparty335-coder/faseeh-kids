import 'dart:io';
import 'dart:typed_data';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\arabic_1Prim_t1_u2l2ب.exe');
  final bytes = await file.readAsBytes();
  final outDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_baa');
  if (!await outDir.exists()) await outDir.create(recursive: true);

  final offsets = <int>[];
  for (int i = 0; i <= bytes.length - 8; i++) {
    if (bytes[i] == 0x43 && bytes[i + 1] == 0x57 && bytes[i + 2] == 0x53) {
      offsets.add(i);
    }
  }

  print('Found ${offsets.length} CWS offsets.');

  int extractedCount = 0;
  for (int idx = 0; idx < offsets.length; idx++) {
    final start = offsets[idx];
    final version = bytes[start + 3];
    if (version > 30) continue; // Skip invalid version numbers

    final uncompressedLen = bytes[start + 4] | (bytes[start + 5] << 8) | (bytes[start + 6] << 16) | (bytes[start + 7] << 24);

    // Try decompressing by feeding slice up to next offset or end of file
    final endBound = (idx < offsets.length - 1) ? offsets[idx + 1] : bytes.length;
    final payload = bytes.sublist(start + 8, endBound);

    // Inflate using ZLibDecoder stream / sync
    Uint8List? decompressedData;
    int compressedSizeUsed = 0;

    // Try finding exact zlib stream end by shrinking buffer if needed
    for (int testLen = payload.length; testLen >= 10; testLen -= 100) {
      try {
        final rawZlib = ZLibCodec(raw: false);
        final result = rawZlib.decode(payload.sublist(0, testLen));
        // Check if decompressed length matches uncompressedLen - 8
        if ((result.length + 8 - uncompressedLen).abs() < 1000) {
          decompressedData = Uint8List.fromList(result);
          compressedSizeUsed = testLen;
          break;
        }
      } catch (_) {}
    }

    // Fallback: binary search or fine iteration if coarse step skipped exact match
    if (decompressedData == null) {
      for (int testLen = payload.length; testLen >= 10; testLen--) {
        try {
          final rawZlib = ZLibCodec(raw: false);
          final result = rawZlib.decode(payload.sublist(0, testLen));
          decompressedData = Uint8List.fromList(result);
          compressedSizeUsed = testLen;
          break;
        } catch (_) {}
      }
    }

    if (decompressedData != null) {
      // Re-build standard CWS file
      final cwsHeaderAndData = bytes.sublist(start, start + 8 + compressedSizeUsed);
      final swfName = 'baa_module_${(extractedCount + 1).toString().padLeft(2, '0')}.swf';
      final outFile = File('${outDir.path}${Platform.pathSeparator}$swfName');
      await outFile.writeAsBytes(cwsHeaderAndData);
      print('  ✓ Extracted $swfName: [Compressed: ${(cwsHeaderAndData.length / 1024).toStringAsFixed(1)} KB | Decompressed: ${(decompressedData.length / 1024).toStringAsFixed(1)} KB]');
      extractedCount++;
    } else {
      print('  ❌ Could not decompress offset $start (v$version, uncompressed size: $uncompressedLen)');
    }
  }

  print('\nExtraction finished: $extractedCount SWFs extracted.');
}

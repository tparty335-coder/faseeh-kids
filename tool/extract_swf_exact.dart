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

  print('Found ${offsets.length} CWS offsets in EXE.');

  int extractedCount = 0;
  final stopwatch = Stopwatch()..start();

  for (int idx = 0; idx < offsets.length; idx++) {
    final start = offsets[idx];
    final version = bytes[start + 3];
    if (version > 30) continue;

    final uncompressedLen = bytes[start + 4] | (bytes[start + 5] << 8) | (bytes[start + 6] << 16) | (bytes[start + 7] << 24);
    final targetDecompressedLen = uncompressedLen - 8;

    final maxEnd = (idx < offsets.length - 1) ? offsets[idx + 1] : bytes.length;
    final maxCompLen = maxEnd - (start + 8);

    Uint8List? decompressedBytes;
    int exactCompLen = -1;

    // Search window: usually compressed size is 10% to 100% of uncompressed size
    int low = 10;
    int high = maxCompLen;

    // We search by checking chunks in steps, or using binary search
    // Since zlib stream requires exact end, we test range around estimated ratio ~0.5..0.9
    // Or we scan step of 1KB then binary search fine window!

    int foundValidChunkEnd = -1;
    // Step 1: Scan in 512-byte increments to find valid region
    for (int testLen = 512; testLen <= maxCompLen; testLen += 512) {
      try {
        final rawZlib = ZLibCodec(raw: false);
        final result = rawZlib.decode(bytes.sublist(start + 8, start + 8 + testLen));
        if (result.length == targetDecompressedLen) {
          decompressedBytes = Uint8List.fromList(result);
          exactCompLen = testLen;
          break;
        }
      } catch (_) {}
    }

    // Step 2: If coarse step missed exact byte boundary, search within fine 512-byte window around candidate
    if (decompressedBytes == null) {
      for (int len = maxCompLen; len >= 10; len--) {
        try {
          final rawZlib = ZLibCodec(raw: false);
          final result = rawZlib.decode(bytes.sublist(start + 8, start + 8 + len));
          if (result.length == targetDecompressedLen) {
            decompressedBytes = Uint8List.fromList(result);
            exactCompLen = len;
            break;
          }
        } catch (_) {}
      }
    }

    if (decompressedBytes != null) {
      final swfName = 'baa_module_${(extractedCount + 1).toString().padLeft(2, '0')}.swf';
      final outFile = File('${outDir.path}${Platform.pathSeparator}$swfName');

      final fws = BytesBuilder();
      fws.add([0x46, 0x57, 0x53, version]); // 'FWS'
      fws.add([
        uncompressedLen & 0xFF,
        (uncompressedLen >> 8) & 0xFF,
        (uncompressedLen >> 16) & 0xFF,
        (uncompressedLen >> 24) & 0xFF,
      ]);
      fws.add(decompressedBytes);

      await outFile.writeAsBytes(fws.toBytes());
      print('  ✓ Extracted $swfName: [Compressed: ${(exactCompLen / 1024).toStringAsFixed(1)} KB | Uncompressed FWS: ${(fws.length / 1024).toStringAsFixed(1)} KB]');
      extractedCount++;
    } else {
      print('  ❌ Failed offset $start (v$version, target decompressed: $targetDecompressedLen)');
    }
  }

  print('\nExtracted $extractedCount SWFs in ${stopwatch.elapsed.inSeconds}s. Directory: ${outDir.path}');
}

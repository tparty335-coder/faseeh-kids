import 'dart:async';
import 'dart:convert';
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

    final endBound = (idx < offsets.length - 1) ? offsets[idx + 1] : bytes.length;
    final payload = bytes.sublist(start + 8, endBound);

    final decompressedBuilder = BytesBuilder();

    final sink = zlib.decoder.startChunkedConversion(
      ChunkedConversionSink<List<int>>.withCallback((chunks) {
        for (final chunk in chunks) {
          decompressedBuilder.add(chunk);
        }
      }),
    );

    try {
      sink.add(payload);
      sink.close();
    } catch (_) {
      // Ignore trailing data error after valid decompressed payload
    }

    if (decompressedBuilder.length > 0) {
      final swfName = 'baa_module_${(extractedCount + 1).toString().padLeft(2, '0')}.swf';
      final outFile = File('${outDir.path}${Platform.pathSeparator}$swfName');

      // Build valid uncompressed FWS file
      final fwsBuilder = BytesBuilder();
      fwsBuilder.add([0x46, 0x57, 0x53, version]); // 'FWS' + version
      fwsBuilder.add([
        uncompressedLen & 0xFF,
        (uncompressedLen >> 8) & 0xFF,
        (uncompressedLen >> 16) & 0xFF,
        (uncompressedLen >> 24) & 0xFF,
      ]);
      fwsBuilder.add(decompressedBuilder.toBytes());

      await outFile.writeAsBytes(fwsBuilder.toBytes());
      print('  ✓ Extracted $swfName: [Decompressed size: ${(fwsBuilder.length / 1024).toStringAsFixed(1)} KB | Target: ${(uncompressedLen / 1024).toStringAsFixed(1)} KB]');
      extractedCount++;
    } else {
      print('  ❌ Could not decompress offset $start (v$version, uncompressed size: $uncompressedLen)');
    }
  }

  print('\nExtraction finished: $extractedCount SWF files saved to ${outDir.path}');
}

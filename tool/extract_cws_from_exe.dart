import 'dart:io';
import 'dart:typed_data';

void main(List<String> args) async {
  final exePath = args.isNotEmpty ? args[0] : r'D:\Education  vol2\مناهج 2026\ص1         ت1\arabic_1Prim_t1_u2l2ب.exe';
  final outDir = Directory(args.length > 1 ? args[1] : r'd:\Projects\faseeh_kids\scratch\extracted_baa');

  if (!await outDir.exists()) {
    await outDir.create(recursive: true);
  }

  final file = File(exePath);
  final bytes = await file.readAsBytes();
  print('Read ${bytes.length} bytes from $exePath');

  // Find all 'CWS' occurrences
  final offsets = <int>[];
  for (int i = 0; i <= bytes.length - 8; i++) {
    if (bytes[i] == 0x43 && bytes[i + 1] == 0x57 && bytes[i + 2] == 0x53) {
      offsets.add(i);
    }
  }

  print('Found ${offsets.length} SWF (CWS) files in EXE.');

  int count = 0;
  for (int i = 0; i < offsets.length; i++) {
    final start = offsets[i];
    final version = bytes[start + 3];
    final uncompressedLen = bytes[start + 4] | (bytes[start + 5] << 8) | (bytes[start + 6] << 16) | (bytes[start + 7] << 24);

    // End is either next CWS offset or end of file
    final end = (i < offsets.length - 1) ? offsets[i + 1] : bytes.length;
    final cwsSlice = bytes.sublist(start, end);

    // Test decompressing zlib payload
    try {
      final zlibPayload = bytes.sublist(start + 8, end);
      final rawZlib = ZLibCodec(raw: false);
      final decompressed = rawZlib.decode(zlibPayload);

      final totalUncompressed = 8 + decompressed.length;
      final swfName = 'baa_module_${(count + 1).toString().padLeft(2, '0')}.swf';
      final outFile = File('${outDir.path}${Platform.pathSeparator}$swfName');

      await outFile.writeAsBytes(cwsSlice);
      print('  ✓ Extracted $swfName: [Compressed: ${(cwsSlice.length / 1024).toStringAsFixed(1)} KB | Expected Uncompressed: ${(uncompressedLen / 1024).toStringAsFixed(1)} KB | Actual Decompressed: ${(totalUncompressed / 1024).toStringAsFixed(1)} KB]');
      count++;
    } catch (e) {
      // Try incremental slice up to uncompressed length or end
      print('  ⚠️ Error decompressing chunk at offset $start (version $version, expected $uncompressedLen bytes): $e');
    }
  }

  print('\nSuccessfully extracted $count SWF modules to: ${outDir.path}');
}

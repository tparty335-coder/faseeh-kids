import 'dart:io';
import 'dart:typed_data';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\Arabic_1Peim_T1_CharacterAlefأ.exe');
  final bytes = await file.readAsBytes();
  final outDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif');
  if (!await outDir.exists()) {
    await outDir.create(recursive: true);
  }

  print('Searching for ZIP Local File Headers (PK\\x03\\x04) in EXE...');
  final localHeaders = <int>[];
  for (int i = 0; i < bytes.length - 30; i++) {
    if (bytes[i] == 0x50 &&
        bytes[i + 1] == 0x4B &&
        bytes[i + 2] == 0x03 &&
        bytes[i + 3] == 0x04) {
      localHeaders.add(i);
    }
  }

  print('Found ${localHeaders.length} ZIP entries in the Zinc bundle:');

  for (final offset in localHeaders) {
    final version = bytes[offset + 4] | (bytes[offset + 5] << 8);
    final flags = bytes[offset + 6] | (bytes[offset + 7] << 8);
    final method = bytes[offset + 8] | (bytes[offset + 9] << 8); // 0 = store, 8 = deflate
    final crc32 = bytes[offset + 14] | (bytes[offset + 15] << 8) | (bytes[offset + 16] << 16) | (bytes[offset + 17] << 24);
    final compSize = bytes[offset + 18] | (bytes[offset + 19] << 8) | (bytes[offset + 20] << 16) | (bytes[offset + 21] << 24);
    final uncompSize = bytes[offset + 22] | (bytes[offset + 23] << 8) | (bytes[offset + 24] << 16) | (bytes[offset + 25] << 24);
    final fileNameLen = bytes[offset + 26] | (bytes[offset + 27] << 8);
    final extraFieldLen = bytes[offset + 28] | (bytes[offset + 29] << 8);

    final fileNameBytes = bytes.sublist(offset + 30, offset + 30 + fileNameLen);
    final fileName = String.fromCharCodes(fileNameBytes);

    final dataStart = offset + 30 + fileNameLen + extraFieldLen;
    final dataEnd = dataStart + compSize;

    if (dataEnd > bytes.length) {
      print('Warning: File $fileName overflows total byte buffer!');
      continue;
    }

    final compressedData = bytes.sublist(dataStart, dataEnd);
    Uint8List uncompressedData;

    if (method == 0) {
      // Store
      uncompressedData = compressedData;
    } else if (method == 8) {
      // Deflate
      try {
        final rawZlib = ZLibCodec(raw: true);
        uncompressedData = Uint8List.fromList(rawZlib.decode(compressedData));
      } catch (e) {
        print('Error decompressing $fileName: $e');
        continue;
      }
    } else {
      print('Unsupported compression method: $method for $fileName');
      continue;
    }

    // Write file
    final outFile = File('${outDir.path}${Platform.pathSeparator}$fileName');
    await outFile.parent.create(recursive: true);
    await outFile.writeAsBytes(uncompressedData);

    print('  ✓ Extracted: $fileName [${(uncompressedData.length / 1024).toStringAsFixed(1)} KB] (Method: ${method == 8 ? "Deflate" : "Store"})');
  }

  print('\nExtraction complete! Files saved to: ${outDir.path}');
}

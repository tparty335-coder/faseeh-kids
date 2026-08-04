import 'dart:io';
import 'dart:typed_data';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\Arabic_1Peim_T1_CharacterAlefأ.exe');
  if (!await file.exists()) {
    print('File does not exist!');
    return;
  }

  final bytes = await file.readAsBytes();
  print('Total EXE Size: ${(bytes.length / (1024 * 1024)).toStringAsFixed(2)} MB (${bytes.length} bytes)');

  // Search for SWF signatures: FWS (uncompressed), CWS (zlib compressed), ZWS (lzma compressed)
  final signatures = <int>[];
  for (int i = 0; i < bytes.length - 8; i++) {
    if ((bytes[i] == 0x46 || bytes[i] == 0x43 || bytes[i] == 0x5A) && // F, C, Z
        bytes[i + 1] == 0x57 && // W
        bytes[i + 2] == 0x53) { // S
      final version = bytes[i + 3];
      final fileLength = bytes[i + 4] | (bytes[i + 5] << 8) | (bytes[i + 6] << 16) | (bytes[i + 7] << 24);
      final sigName = String.fromCharCode(bytes[i]) + 'WS';
      print('Found SWF Signature: $sigName (version: $version) at offset: $i (0x${i.toRadixString(16).toUpperCase()}), Stated Uncompressed Length: $fileLength bytes (${(fileLength / 1024).toStringAsFixed(1)} KB)');
      signatures.add(i);
    }
  }

  print('Total SWF candidates found: ${signatures.length}');
}

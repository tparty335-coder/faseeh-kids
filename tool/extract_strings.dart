import 'dart:io';
import 'dart:typed_data';

void main() async {
  final inDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif');
  final swfFiles = inDir.listSync().whereType<File>().where((f) => f.path.endsWith('.swf')).toList();
  swfFiles.sort((a, b) => a.path.compareTo(b.path));

  print('================================================================');
  print('PEDAGOGICAL STRINGS & TAXONOMY EXTRACTED FROM ALEF MODULES');
  print('================================================================');

  for (final file in swfFiles) {
    final bytes = await file.readAsBytes();
    final swfBase = file.uri.pathSegments.last;

    Uint8List swfBytes;
    final sig = String.fromCharCodes(bytes.sublist(0, 3));
    if (sig == 'CWS') {
      final decompressed = zlib.decode(bytes.sublist(8));
      swfBytes = Uint8List.fromList(decompressed);
    } else {
      swfBytes = bytes;
    }

    final strings = <String>{};
    // Extract strings longer than 3 chars (UTF-8 and Windows-1256 / ASCII)
    int i = 0;
    while (i < swfBytes.length - 3) {
      if (swfBytes[i] >= 0xD8 && swfBytes[i] <= 0xD9) { // UTF-8 Arabic
        int start = i;
        while (i < swfBytes.length - 1 &&
            ((swfBytes[i] >= 0xD8 && swfBytes[i] <= 0xD9) ||
             (swfBytes[i] >= 0x20 && swfBytes[i] <= 0x7E) ||
             (swfBytes[i] == 0x0A || swfBytes[i] == 0x0D))) {
          i += (swfBytes[i] >= 0xD8 && swfBytes[i] <= 0xD9) ? 2 : 1;
        }
        try {
          final s = String.fromCharCodes(swfBytes.sublist(start, i)).trim();
          if (s.length > 2 && s.codeUnits.any((c) => c > 128)) {
            strings.add(s);
          }
        } catch (_) {}
      }
      i++;
    }

    print('\n📦 Module: $swfBase');
    print('   Found ${strings.length} pedagogical text markers / instructions:');
    for (final s in strings.take(15)) {
      print('     • $s');
    }
  }
}

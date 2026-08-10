import 'dart:io';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\arabic_1Prim_t1_u2l2ب.exe');
  final bytes = await file.readAsBytes();
  print('Total bytes: ${bytes.length}');

  // Search signatures
  final signatures = {
    'SWF (FWS)': [0x46, 0x57, 0x53],
    'SWF (CWS)': [0x43, 0x57, 0x53],
    'SWF (ZWS)': [0x5A, 0x57, 0x53],
    '7-Zip': [0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C],
    'WinRAR': [0x52, 0x61, 0x72, 0x21],
    'ZIP (PK)': [0x50, 0x4B, 0x03, 0x04],
  };

  for (final entry in signatures.entries) {
    final sig = entry.value;
    final matches = <int>[];
    for (int i = 0; i <= bytes.length - sig.length; i++) {
      bool match = true;
      for (int j = 0; j < sig.length; j++) {
        if (bytes[i + j] != sig[j]) {
          match = false;
          break;
        }
      }
      if (match) matches.add(i);
    }
    print('Signature ${entry.key}: found ${matches.length} matches at offsets: ${matches.take(10).toList()}');
  }
}

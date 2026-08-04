import 'dart:io';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\Arabic_1Peim_T1_CharacterAlefأ.exe');
  final bytes = await file.readAsBytes();

  // Search for interesting keywords
  final keywords = [
    'Macromedia',
    'Adobe',
    'Flash',
    'Director',
    'Shockwave',
    '.swf',
    '.mp3',
    '.wav',
    'Sound',
    'Audio',
    'alef',
    'ألف',
    'اسد',
    'أرنب',
    'AutoPlay',
    'MBuilder',
  ];

  print('Searching keywords in EXE...');
  for (final kw in keywords) {
    int count = 0;
    int firstOffset = -1;
    for (int i = 0; i < bytes.length - kw.length; i++) {
      bool match = true;
      for (int k = 0; k < kw.length; k++) {
        if (bytes[i + k] != kw.codeUnitAt(k)) {
          match = false;
          break;
        }
      }
      if (match) {
        count++;
        if (firstOffset == -1) firstOffset = i;
      }
    }
    print('  Keyword "$kw": $count matches (first at offset 0x${firstOffset.toRadixString(16).toUpperCase()})');
  }

  // Look at the last 1024 bytes of the EXE (projector footer)
  print('\nInspecting EXE Tail (last 512 bytes):');
  final tailStart = bytes.length - 512;
  final tailBytes = bytes.sublist(tailStart);
  final str = String.fromCharCodes(tailBytes.map((b) => (b >= 32 && b <= 126) ? b : 46));
  print(str);
}

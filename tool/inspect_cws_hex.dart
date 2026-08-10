import 'dart:io';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\arabic_1Prim_t1_u2l2ب.exe');
  final bytes = await file.readAsBytes();

  final offset = 2568705;
  print('Hex at offset $offset:');
  final slice = bytes.sublist(offset, offset + 32);
  final hexStr = slice.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
  print(hexStr);
  print('ASCII: ${String.fromCharCodes(slice.map((b) => (b >= 32 && b <= 126) ? b : 46))}');
}

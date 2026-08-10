import 'dart:io';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\arabic_1Prim_t1_u2l2ب.exe');
  final len = await file.length();
  final raf = await file.open();
  await raf.setPosition(len - 64);
  final tail = await raf.read(64);
  await raf.close();

  print('Total EXE size: $len bytes');
  print('Tail hex:');
  print(tail.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' '));
  print('Tail ASCII: ${String.fromCharCodes(tail.map((b) => (b >= 32 && b <= 126) ? b : 46))}');
}

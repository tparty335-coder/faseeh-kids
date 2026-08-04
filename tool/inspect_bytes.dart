import 'dart:io';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\Arabic_1Peim_T1_CharacterAlefأ.exe');
  final bytes = await file.readAsBytes();

  final offset = 2043888;
  print('Header at offset $offset:');
  for (int i = 0; i < 32; i++) {
    final b = bytes[offset + i];
    stdout.write('${b.toRadixString(16).padLeft(2, "0")} ');
  }
  print('');

  // Let's test with ZLibCodec(raw: true) and ZLibCodec(raw: false)
  final rawZlib = ZLibCodec(raw: true);
  final stdZlib = ZLibCodec(raw: false);

  for (int testOff in [offset, offset + 8]) {
    try {
      final sub = bytes.sublist(testOff);
      final dec = stdZlib.decode(sub);
      print('stdZlib decode from $testOff success! Decompressed: ${dec.length} bytes');
    } catch (e) {
      print('stdZlib decode from $testOff failed: $e');
    }

    try {
      final sub = bytes.sublist(testOff);
      final dec = rawZlib.decode(sub);
      print('rawZlib decode from $testOff success! Decompressed: ${dec.length} bytes');
    } catch (e) {
      print('rawZlib decode from $testOff failed: $e');
    }
  }
}

import 'dart:io';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\arabic_1Prim_t1_u2l2ب.exe');
  final bytes = await file.readAsBytes();

  final start = 2568705;
  final nextStart = 3633751;

  print('Header bytes: ${bytes.sublist(start, start + 12)}');

  // Try raw zlib without header (offset 8 or offset 10)
  for (int offsetOffset = 8; offsetOffset <= 12; offsetOffset++) {
    for (bool raw in [false, true]) {
      final payload = bytes.sublist(start + offsetOffset, nextStart);
      for (int trim = 0; trim <= 100; trim++) {
        final slice = payload.sublist(0, payload.length - trim);
        try {
          final decompressed = ZLibCodec(raw: raw).decode(slice);
          print('  🎉 SUCCESS with offsetOffset=$offsetOffset, raw=$raw, trim=$trim! Decompressed length: ${decompressed.length}');
          return;
        } catch (_) {}
      }
    }
  }

  print('Failed all combinations.');
}

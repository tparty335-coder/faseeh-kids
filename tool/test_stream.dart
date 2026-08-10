import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\arabic_1Prim_t1_u2l2ب.exe');
  final bytes = await file.readAsBytes();

  final start = 2568705;
  final uncompressedLen = bytes[start + 4] | (bytes[start + 5] << 8) | (bytes[start + 6] << 16) | (bytes[start + 7] << 24);
  final targetLen = uncompressedLen - 8;

  final zlibData = bytes.sublist(start + 8);

  for (int testLen = 260000; testLen <= zlibData.length; testLen += 50000) {
    final decompressed = <int>[];
    final sink = zlib.decoder.startChunkedConversion(
      ChunkedConversionSink<List<int>>.withCallback((chunks) {
        for (final chunk in chunks) {
          decompressed.addAll(chunk);
        }
      }),
    );

    try {
      sink.add(zlibData.sublist(0, testLen));
      sink.close();
      print('testLen=$testLen → decompressed=${decompressed.length} / $targetLen');
      if (decompressed.length >= targetLen) {
        print('🎉 REACHED TARGET at testLen=$testLen!');
        return;
      }
    } catch (e) {
      // Ignored
    }
  }
}

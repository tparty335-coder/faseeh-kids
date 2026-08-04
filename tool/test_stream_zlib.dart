import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

Future<Uint8List?> decompressZlibStream(Uint8List bytes, int offset, int targetLength) async {
  try {
    final streamController = StreamController<List<int>>();
    final decompressedChunks = <List<int>>[];
    final completer = Completer<Uint8List?>();

    streamController.stream
        .transform(zlib.decoder)
        .listen(
          (chunk) {
            decompressedChunks.add(chunk);
          },
          onDone: () {
            final builder = BytesBuilder();
            for (final c in decompressedChunks) {
              builder.add(c);
            }
            completer.complete(builder.toBytes());
          },
          onError: (e) {
            if (decompressedChunks.isNotEmpty) {
              final builder = BytesBuilder();
              for (final c in decompressedChunks) {
                builder.add(c);
              }
              completer.complete(builder.toBytes());
            } else {
              completer.complete(null);
            }
          },
          cancelOnError: false,
        );

    // Feed bytes in chunks
    final slice = bytes.sublist(offset + 8);
    // feed up to 2MB at a time
    streamController.add(slice);
    await streamController.close();

    return await completer.future;
  } catch (e) {
    return null;
  }
}

void main() async {
  final file = File(r'D:\Education  vol2\مناهج 2026\ص1         ت1\Arabic_1Peim_T1_CharacterAlefأ.exe');
  final bytes = await file.readAsBytes();

  final offset = 2043888;
  final version = bytes[offset + 3];
  final statedLen = bytes[offset + 4] | (bytes[offset + 5] << 8) | (bytes[offset + 6] << 16) | (bytes[offset + 7] << 24);

  print('Decompressing SWF at offset $offset, stated len: $statedLen...');
  final dec = await decompressZlibStream(bytes, offset, statedLen);
  if (dec != null) {
    print('SUCCESS! Decompressed ${dec.length} bytes (Expected: $statedLen - 8 = ${statedLen - 8})');
  } else {
    print('Failed.');
  }
}

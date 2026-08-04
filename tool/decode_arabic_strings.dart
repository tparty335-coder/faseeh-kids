import 'dart:io';
import 'dart:convert';

void main() async {
  final inDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif');
  final swfFiles = inDir.listSync().whereType<File>().where((f) => f.path.endsWith('.swf')).toList();
  swfFiles.sort((a, b) => a.path.compareTo(b.path));

  for (final file in swfFiles) {
    final bytes = await file.readAsBytes();
    final swfBase = file.uri.pathSegments.last;

    List<int> uncompressed;
    final sig = String.fromCharCodes(bytes.sublist(0, 3));
    if (sig == 'CWS') {
      uncompressed = zlib.decode(bytes.sublist(8));
    } else {
      uncompressed = bytes;
    }

    final text = utf8.decode(uncompressed, allowMalformed: true);
    final arabicWords = <String>{};
    final regex = RegExp(r'[\u0600-\u06FF]{3,}');
    for (final match in regex.allMatches(text)) {
      arabicWords.add(match.group(0)!);
    }

    print('\n📘 $swfBase: ${arabicWords.length} Arabic terms found:');
    print(arabicWords.take(20).join(' ، '));
  }
}

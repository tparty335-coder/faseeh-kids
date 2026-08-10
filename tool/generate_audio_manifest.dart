import 'dart:io';
import 'dart:convert';

void main() {
  final baseDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\letters');
  final outPath = r'd:\Projects\faseeh_kids\lib\core\constants\audio_manifest.dart';
  
  final outDir = Directory(r'd:\Projects\faseeh_kids\lib\core\constants');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  final files = baseDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.mp3')).toList();
  
  final buffer = StringBuffer();
  buffer.writeln('// AUTO-GENERATED FILE. DO NOT MODIFY.');
  buffer.writeln('// Generated on ${DateTime.now().toIso8601String()}');
  buffer.writeln('');
  buffer.writeln('class AudioManifest {');
  buffer.writeln('  static const Set<String> availableAssets = {');
  
  for (final file in files) {
    // Convert path to relative asset path
    // e.g., d:\Projects\faseeh_kids\assets\audio\letters\short_vowels\baa_fatha.mp3
    // -> assets/audio/letters/short_vowels/baa_fatha.mp3
    final relativePath = file.path
        .split('faseeh_kids\\').last
        .replaceAll('\\', '/');
    buffer.writeln("    '$relativePath',");
  }
  
  buffer.writeln('  };');
  buffer.writeln('}');
  
  File(outPath).writeAsStringSync(buffer.toString());
  print('✅ Generated audio_manifest.dart with ${files.length} entries.');
}

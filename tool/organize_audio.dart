import 'dart:io';

void main() {
  final baseDir = Directory(r'd:\Projects\faseeh_kids\assets\audio\letters');
  
  final shortVowelsDir = Directory('${baseDir.path}\\short_vowels');
  final longVowelsDir = Directory('${baseDir.path}\\long_vowels');
  final wordsDir = Directory('${baseDir.path}\\words');
  final phrasesDir = Directory('${baseDir.path}\\phrases');
  final coreDir = Directory('${baseDir.path}\\core'); // names, sounds, positions
  
  for (final dir in [shortVowelsDir, longVowelsDir, wordsDir, phrasesDir, coreDir]) {
    if (!dir.existsSync()) dir.createSync(recursive: true);
  }

  int movedCount = 0;
  
  for (final file in baseDir.listSync().whereType<File>()) {
    if (!file.path.endsWith('.mp3')) continue;
    
    final fileName = file.uri.pathSegments.last;
    String targetPath = '';
    
    if (fileName.contains('_fatha.mp3') || fileName.contains('_kasra.mp3') || fileName.contains('_damma.mp3') || fileName.contains('_sukoon.mp3')) {
      targetPath = '${shortVowelsDir.path}\\$fileName';
    } else if (fileName.contains('_madd')) {
      targetPath = '${longVowelsDir.path}\\$fileName';
    } else if (fileName.contains('_word')) {
      targetPath = '${wordsDir.path}\\$fileName';
    } else if (fileName.contains('_sentence') || fileName.contains('_demo')) {
      targetPath = '${phrasesDir.path}\\$fileName';
    } else {
      targetPath = '${coreDir.path}\\$fileName';
    }
    
    if (targetPath.isNotEmpty) {
      file.renameSync(targetPath);
      movedCount++;
    }
  }
  
  print('✅ Successfully organized $movedCount files into categorized subfolders.');
}

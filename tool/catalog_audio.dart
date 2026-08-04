import 'dart:io';

void main() {
  final audioDir = Directory(r'd:\Projects\faseeh_kids\scratch\extracted_alif\audio');
  final files = audioDir.listSync().whereType<File>().toList();
  files.sort((a, b) => a.path.compareTo(b.path));

  final groups = <String, List<File>>{};
  for (final f in files) {
    final name = f.uri.pathSegments.last;
    final prefix = name.split('_sound_').first;
    groups.putIfAbsent(prefix, () => []).add(f);
  }

  print('================================================================');
  print('AUDIO ASSET INVENTORY FOR ARABIC ALEF (حرف الألف):');
  print('Total Audio Tracks: ${files.length}');
  print('================================================================');

  for (final entry in groups.entries) {
    final list = entry.value;
    final totalBytes = list.map((f) => f.lengthSync()).reduce((a, b) => a + b);
    print('\n📁 Module: ${entry.key} (${list.length} tracks, total: ${(totalBytes / 1024).toStringAsFixed(1)} KB)');
    
    // Categorize by file size:
    // Long narration (> 50KB): Intro, story, full instructions
    // Medium sound (10KB - 50KB): Words, sentences, feedback
    // Short sound (< 10KB): Letter sounds (أَ، أُ، إِ، أْ), clicks, effects
    final longTracks = list.where((f) => f.lengthSync() >= 50 * 1024).toList();
    final medTracks = list.where((f) => f.lengthSync() >= 10 * 1024 && f.lengthSync() < 50 * 1024).toList();
    final shortTracks = list.where((f) => f.lengthSync() < 10 * 1024).toList();

    print('   • Long Narrations & Stories (>50KB): ${longTracks.length} tracks');
    for (final t in longTracks) {
      print('      🎙️ ${t.uri.pathSegments.last} (${(t.lengthSync() / 1024).toStringAsFixed(1)} KB)');
    }
    print('   • Words & Feedback (10KB-50KB): ${medTracks.length} tracks');
    for (final t in medTracks.take(5)) {
      print('      🗣️ ${t.uri.pathSegments.last} (${(t.lengthSync() / 1024).toStringAsFixed(1)} KB)');
    }
    if (medTracks.length > 5) print('      ... and ${medTracks.length - 5} more');

    print('   • Phonemes, Letters & Clicks (<10KB): ${shortTracks.length} tracks');
    for (final t in shortTracks.take(5)) {
      print('      🔊 ${t.uri.pathSegments.last} (${(t.lengthSync() / 1024).toStringAsFixed(1)} KB)');
    }
    if (shortTracks.length > 5) print('      ... and ${shortTracks.length - 5} more');
  }
}

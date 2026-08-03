import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/services/audio_registry.dart';

void main() {
  group('AudioRegistry', () {
    test('should have exactly 28 letter keys', () {
      expect(AudioRegistry.letterKeys.length, 28);
    });

    test('should have 7 variants', () {
      expect(AudioRegistry.variants.length, 7);
    });

    test('should have 196 letter entries (28 × 7)', () {
      final letterEntryCount = AudioRegistry.letterKeys.length *
          AudioRegistry.variants.length;
      expect(letterEntryCount, 196);
    });

    test('should have 10 feedback entries', () {
      final feedbackKeys = AudioRegistry.audioMap.keys
          .where((k) => k.startsWith('feedback_'))
          .length;
      expect(feedbackKeys, 10);
    });

    test('should have 8 SFX entries', () {
      final sfxKeys = AudioRegistry.audioMap.keys
          .where((k) => k.startsWith('sfx_'))
          .length;
      expect(sfxKeys, 8);
    });

    test('should have at least 214 total entries (196+10+8)', () {
      expect(AudioRegistry.totalEntries, greaterThanOrEqualTo(214));
    });

    test('all letter keys should have entries for all variants', () {
      for (final letter in AudioRegistry.letterKeys) {
        for (final variant in AudioRegistry.variants) {
          final key = '${letter}_$variant';
          expect(
            AudioRegistry.hasKey(key),
            true,
            reason: 'Missing key: $key',
          );
        }
      }
    });

    test('all paths should start with assets/audio/', () {
      for (final entry in AudioRegistry.audioMap.entries) {
        expect(
          entry.value.startsWith('assets/audio/'),
          true,
          reason: 'Invalid path for ${entry.key}: ${entry.value}',
        );
      }
    });

    test('all paths should end with .mp3', () {
      for (final entry in AudioRegistry.audioMap.entries) {
        expect(
          entry.value.endsWith('.mp3'),
          true,
          reason: 'Non-mp3 path for ${entry.key}: ${entry.value}',
        );
      }
    });

    test('keysForLetter should return 7 keys', () {
      final keys = AudioRegistry.keysForLetter('alif');
      expect(keys.length, 7);
      expect(keys, contains('alif_name'));
      expect(keys, contains('alif_sound'));
      expect(keys, contains('alif_fatha'));
      expect(keys, contains('alif_kasra'));
      expect(keys, contains('alif_damma'));
      expect(keys, contains('alif_word'));
      expect(keys, contains('alif_sentence'));
    });

    test('letterNamesArabic should have 28 entries', () {
      expect(AudioRegistry.letterNamesArabic.length, 28);
    });

    test('letterCharsArabic should have 28 entries', () {
      expect(AudioRegistry.letterCharsArabic.length, 28);
    });

    test('exampleWords should have 28 entries', () {
      expect(AudioRegistry.exampleWords.length, 28);
    });

    test('getPath returns null for unknown key', () {
      expect(AudioRegistry.getPath('nonexistent'), isNull);
    });

    test('getPath returns valid path for known key', () {
      final path = AudioRegistry.getPath('alif_name');
      expect(path, isNotNull);
      expect(path, 'assets/audio/letters/alif_name.mp3');
    });
  });
}

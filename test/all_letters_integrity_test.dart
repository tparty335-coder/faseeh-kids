import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

// Manifests
import 'package:faseeh_kids/features/lessons/data/manifests/taa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/thaa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/jeem_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/ha_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/kha_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/dal_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/dhaal_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/raa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/zaay_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/seen_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final manifests = <LetterUnitManifest>[
    taaManifest,
    thaaManifest,
    jeemManifest,
    haManifest,
    khaManifest,
    dalManifest,
    dhaalManifest,
    raaManifest,
    zaayManifest,
    seenManifest,
  ];

  group('All Letters Manifests & Data Integrity Tests', () {
    test('Arabic letters catalogue contains 28 letters', () {
      expect(arabicLetters.length, 28);
      expect(arabicLetters.first.letter, 'أ');
      expect(arabicLetters.last.letter, 'ي');
    });

    for (final m in manifests) {
      group('Manifest for Letter: ${m.letter} (${m.unitTitle})', () {
        test('Basic properties are valid', () {
          expect(m.letter.isNotEmpty, isTrue);
          expect(m.unitTitle.isNotEmpty, isTrue);
          expect(m.topBarColor.a, greaterThan(0));
          expect(m.highlightColor.a, greaterThan(0));
          expect(m.mascotEmoji.isNotEmpty, isTrue);
          expect(m.unitIndex, greaterThan(2));
          expect(m.nextLetter?.isNotEmpty, isTrue);
        });

        test('Objectives specification is complete', () {
          expect(m.objectives.audioPath.isNotEmpty, isTrue);
          expect(m.objectives.objectives.length, greaterThanOrEqualTo(5));
          for (final obj in m.objectives.objectives) {
            expect(obj.isNotEmpty, isTrue);
          }
        });

        test('Story specification has scenes + nasheed', () {
          expect(m.story.scenes.length, greaterThanOrEqualTo(2));
          expect(m.story.scenes.any((s) => s.isNasheed), isTrue);
          for (final s in m.story.scenes) {
            expect(s.imagePath.isNotEmpty, isTrue);
            expect(s.audioPath.isNotEmpty, isTrue);
          }
        });

        test('Vowels specification has valid short vowels audio', () {
          expect(m.vowels.letterChar, m.letter);
          expect(m.vowels.items.isNotEmpty, isTrue);
          for (final v in m.vowels.items) {
            expect(v.displayChar.isNotEmpty, isTrue);
            expect(v.fathaAudio.isNotEmpty, isTrue);
            expect(v.dammaAudio.isNotEmpty, isTrue);
            expect(v.kasraAudio.isNotEmpty, isTrue);
          }
        });

        test('Madd specification has 3 items (Alif, Waw, Yaa)', () {
          expect(m.madd.letterChar, m.letter);
          expect(m.madd.items.length, 3);
          for (final item in m.madd.items) {
            expect(item.displayChar.isNotEmpty, isTrue);
            expect(item.audioPath.isNotEmpty, isTrue);
            expect(item.imagePath.isNotEmpty, isTrue);
          }
        });

        test('Tracing specification has at least 4 steps and intro', () {
          expect(m.tracing.letterChar, m.letter);
          expect(m.tracing.audioIntroPath.isNotEmpty, isTrue);
          expect(m.tracing.stepImagePaths.length, greaterThanOrEqualTo(4));
          for (final step in m.tracing.stepImagePaths) {
            expect(step.isNotEmpty, isTrue);
          }
        });

        test('Words bank has 4-5 pages with 4 words each', () {
          expect(m.words.pages.length, inInclusiveRange(4, 5));
          int totalWords = 0;
          for (final page in m.words.pages) {
            expect(page.listImagePath.isNotEmpty, isTrue);
            expect(page.words.length, 4);
            totalWords += page.words.length;
            for (final word in page.words) {
              expect(word.word.isNotEmpty, isTrue);
              expect(word.cardImagePath.isNotEmpty, isTrue);
              expect(word.audioPath.isNotEmpty, isTrue);
            }
          }
          expect(totalWords, m.words.pages.length * 4);
        });

        test('Games specification has all games configured', () {
          expect(m.games.fishing.length, greaterThanOrEqualTo(3));
          for (final f in m.games.fishing) {
            expect(f.word.isNotEmpty, isTrue);
            expect(f.imagePath.isNotEmpty, isTrue);
            expect(f.audioPath.isNotEmpty, isTrue);
          }

          expect(m.games.beehive.length, greaterThanOrEqualTo(3));
          for (final b in m.games.beehive) {
            expect(b.word.isNotEmpty, isTrue);
            expect(b.imagePath.isNotEmpty, isTrue);
            expect(b.audioPath.isNotEmpty, isTrue);
          }

          expect(m.games.circus.length, greaterThanOrEqualTo(3));
          for (final c in m.games.circus) {
            expect(c.word.isNotEmpty, isTrue);
            expect(c.imagePath.isNotEmpty, isTrue);
            expect(c.audioPath.isNotEmpty, isTrue);
          }

          expect(m.games.wordsMatch.length, greaterThanOrEqualTo(3));
          for (final wm in m.games.wordsMatch) {
            expect(wm.word.isNotEmpty, isTrue);
            expect(wm.imagePath.isNotEmpty, isTrue);
            expect(wm.audioPath.isNotEmpty, isTrue);
          }

          expect(m.games.coloring.length, greaterThanOrEqualTo(1));
          for (final col in m.games.coloring) {
            expect(col.word.isNotEmpty, isTrue);
            expect(col.bgImagePath.isNotEmpty, isTrue);
            expect(col.wordRevealImagePath.isNotEmpty, isTrue);
            expect(col.introAudioPath.isNotEmpty, isTrue);
            expect(col.revealAudioPath.isNotEmpty, isTrue);
            expect(col.slices.length, greaterThanOrEqualTo(1));
            for (final slice in col.slices) {
              expect(slice.maskImagePath.isNotEmpty, isTrue);
            }
          }
        });

        test('Disk assets exist for all manifest references', () {
          final root = r'd:\Projects\faseeh_kids';

          void verifyDiskFile(String path) {
            final fullPath = path.startsWith('assets/')
                ? '$root\\${path.replaceAll('/', '\\')}'
                : '$root\\assets\\${path.replaceAll('/', '\\')}';
            expect(
              File(fullPath).existsSync(),
              isTrue,
              reason: 'Missing file on disk: $path for letter ${m.letter}',
            );
          }

          // Objectives
          verifyDiskFile(m.objectives.audioPath);

          // Story
          for (final s in m.story.scenes) {
            verifyDiskFile(s.imagePath);
            verifyDiskFile(s.audioPath);
          }

          // Vowels
          for (final v in m.vowels.items) {
            verifyDiskFile(v.fathaAudio);
            verifyDiskFile(v.dammaAudio);
            verifyDiskFile(v.kasraAudio);
          }

          // Madd
          for (final item in m.madd.items) {
            verifyDiskFile(item.audioPath);
            verifyDiskFile(item.imagePath);
          }

          // Tracing
          verifyDiskFile(m.tracing.audioIntroPath);
          for (final st in m.tracing.stepImagePaths) {
            verifyDiskFile(st);
          }

          // Words
          for (final page in m.words.pages) {
            verifyDiskFile(page.listImagePath);
            for (final word in page.words) {
              verifyDiskFile(word.cardImagePath);
              verifyDiskFile(word.audioPath);
            }
          }

          // Games
          for (final f in m.games.fishing) {
            verifyDiskFile(f.imagePath);
            verifyDiskFile(f.audioPath);
          }
          for (final b in m.games.beehive) {
            verifyDiskFile(b.imagePath);
            verifyDiskFile(b.audioPath);
          }
          for (final c in m.games.circus) {
            verifyDiskFile(c.imagePath);
            verifyDiskFile(c.audioPath);
          }
          for (final wm in m.games.wordsMatch) {
            verifyDiskFile(wm.imagePath);
            verifyDiskFile(wm.audioPath);
          }
          for (final col in m.games.coloring) {
            verifyDiskFile(col.bgImagePath);
            verifyDiskFile(col.wordRevealImagePath);
            verifyDiskFile(col.introAudioPath);
            verifyDiskFile(col.revealAudioPath);
            for (final sl in col.slices) {
              verifyDiskFile(sl.maskImagePath);
            }
          }
        });
      });
    }

    test('All hardcoded image and audio paths in game & lesson screen files exist on disk', () {
      final dirs = [
        Directory('lib/features/games/screens'),
        Directory('lib/features/lessons/screens'),
      ];
      final assetRegex = RegExp(r'''['"]((?:assets/|audio/)[^'"\$]+\.(?:png|jpg|jpeg|webp|mp3|wav))['"]''');
      final missing = <String>[];

      for (final dir in dirs) {
        if (!dir.existsSync()) continue;
        for (final entity in dir.listSync(recursive: true)) {
          if (entity is File && entity.path.endsWith('.dart')) {
            final content = entity.readAsStringSync();
            for (final match in assetRegex.allMatches(content)) {
              final rawPath = match.group(1)!;
              final diskPath = rawPath.startsWith('assets/') ? rawPath : 'assets/$rawPath';
              if (!File(diskPath).existsSync()) {
                missing.add('${entity.path}: $diskPath');
              }
            }
          }
        }
      }

      expect(missing, isEmpty, reason: 'Missing assets referenced in screen code:\n${missing.join('\n')}');
    });
  });
}

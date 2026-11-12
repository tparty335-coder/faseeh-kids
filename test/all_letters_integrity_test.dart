import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

// Manifests
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final manifests = allCurriculumManifests;

  group('All Letters Manifests & Data Integrity Tests', () {
    test('Arabic letters catalogue contains 28 letters', () {
      expect(arabicLetters.length, 28);
      expect(arabicLetters.first.letter, 'أ');
      expect(arabicLetters.last.letter, 'ي');
    });

    test('All 26 curriculum manifests (ت through ي) are registered and lookup works', () {
      expect(manifests.length, 26);
      expect(manifests.first.letter, 'ت');
      expect(manifests.last.letter, 'ي');
      for (final m in manifests) {
        expect(findManifestForLetter(m.letter), same(m));
      }
      expect(findManifestForLetter('هـ'), same(findManifestForLetter('ه')));
    });

    for (final m in manifests) {
      group('Manifest for Letter: ${m.letter} (${m.unitTitle})', () {
        test('Basic properties are valid', () {
          expect(m.letter.isNotEmpty, isTrue);
          expect(m.unitTitle.isNotEmpty, isTrue);
          expect(m.topBarColor.a, greaterThan(0));
          expect(m.highlightColor.a, greaterThan(0));
          expect(m.mascotEmoji.isNotEmpty, isTrue);
          expect(m.unitIndex, inInclusiveRange(3, 28));
          if (m.letter == 'ي') {
            expect(m.nextLetter, isNull);
          } else {
            expect(m.nextLetter?.isNotEmpty, isTrue);
          }
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
          final root = Directory.current.path;
          final sep = Platform.pathSeparator;

          void verifyDiskFile(String path) {
            final fullPath = path.startsWith('assets/')
                ? '$root$sep${path.replaceAll('/', sep)}'
                : '$root${sep}assets$sep${path.replaceAll('/', sep)}';
            expect(
              File(fullPath).existsSync(),
              isTrue,
              reason: 'Missing file on disk: $path for letter ${m.letter}',
            );
          }

          void verifyOptDiskFile(String? path) {
            if (path != null) verifyDiskFile(path);
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
          if (m.vowels.cards != null) {
            expect(m.vowels.cards!.length, greaterThanOrEqualTo(3));
            for (final c in m.vowels.cards!) {
              verifyDiskFile(c.vowelAudio);
              verifyDiskFile(c.fullRuleAudio);
              verifyOptDiskFile(c.wordAudio);
              verifyOptDiskFile(c.slideImagePath);
              if (c.vowelName.contains('السُّكُون')) {
                expect(c.vowelAudio, contains('sukoon'));
                expect(c.fullRuleAudio, contains('sukoon'));
                if (c.slideImagePath != null) {
                  expect(c.slideImagePath!, contains('sukoon'));
                }
              }
            }
          }

          // Madd
          for (final item in m.madd.items) {
            verifyDiskFile(item.audioPath);
            verifyDiskFile(item.imagePath);
            verifyOptDiskFile(item.wordAudioPath);
          }
          if (m.madd.useManifestMadd && m.madd.items.length == 3) {
            expect(m.madd.items[0].imagePath, contains('_madd_aa.'));
            expect(m.madd.items[0].audioPath, contains('_alif.'));
            expect(m.madd.items[1].imagePath, contains('_madd_uu.'));
            expect(m.madd.items[1].audioPath, contains('_waw.'));
            expect(m.madd.items[2].imagePath, contains('_madd_ii.'));
            expect(m.madd.items[2].audioPath, contains('_yaa.'));
          }

          // Tracing
          verifyDiskFile(m.tracing.audioIntroPath);
          for (final st in m.tracing.stepImagePaths) {
            verifyDiskFile(st);
            if (m.unitIndex >= 13) {
              final full = '$root$sep${st.replaceAll('/', sep)}';
              expect(
                File(full).lengthSync(),
                greaterThanOrEqualTo(50000),
                reason: 'Tracing step image appears blank/incomplete: $st',
              );
            }
          }
          if (m.tracing.positions != null) {
            for (final pos in m.tracing.positions!) {
              verifyDiskFile(pos.audioPath);
              verifyOptDiskFile(pos.imagePath);
              if (m.unitIndex >= 13 && pos.imagePath != null) {
                final full = '$root$sep${pos.imagePath!.replaceAll('/', sep)}';
                expect(
                  File(full).lengthSync(),
                  greaterThanOrEqualTo(50000),
                  reason: 'Tracing position image appears blank/incomplete: ${pos.imagePath}',
                );
              }
            }
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
          verifyOptDiskFile(m.games.fishingIntroAudio);
          verifyOptDiskFile(m.games.fishingPromptAudio);
          verifyOptDiskFile(m.games.fishingWrongAudio);
          verifyOptDiskFile(m.games.beehivePromptAudio);
          verifyOptDiskFile(m.games.beehiveWrongAudio);
          verifyOptDiskFile(m.games.circusPromptAudio);
          verifyOptDiskFile(m.games.circusWrongAudio);
          verifyOptDiskFile(m.games.wordsMatchPromptAudio);
          verifyOptDiskFile(m.games.wordsMatchWrongAudio);
          verifyOptDiskFile(m.games.coloringIntroAudio);
          verifyOptDiskFile(m.games.coloringStep1Audio);
          verifyOptDiskFile(m.games.coloringStep2Audio);
          verifyOptDiskFile(m.games.coloringWrongAudio);
          verifyOptDiskFile(m.games.praiseFinishAudio);
          for (final f in m.games.fishing) {
            verifyDiskFile(f.imagePath);
            verifyDiskFile(f.audioPath);
            verifyOptDiskFile(f.correctPraiseAudio);
            verifyOptDiskFile(f.roundEndPraiseAudio);
          }
          for (final b in m.games.beehive) {
            verifyDiskFile(b.imagePath);
            verifyDiskFile(b.audioPath);
            verifyOptDiskFile(b.praiseAudio);
          }
          for (final c in m.games.circus) {
            verifyDiskFile(c.imagePath);
            verifyDiskFile(c.audioPath);
            verifyOptDiskFile(c.praiseAudio);
            if (c.zones != null) {
              for (final z in c.zones!) {
                verifyOptDiskFile(z.wordAudio);
              }
            }
          }
          for (final wm in m.games.wordsMatch) {
            verifyDiskFile(wm.imagePath);
            verifyDiskFile(wm.audioPath);
            verifyOptDiskFile(wm.praiseAudio);
          }
          for (final col in m.games.coloring) {
            verifyDiskFile(col.bgImagePath);
            verifyDiskFile(col.wordRevealImagePath);
            verifyDiskFile(col.introAudioPath);
            verifyDiskFile(col.revealAudioPath);
            verifyOptDiskFile(col.wrongRevealAudioPath);
            verifyOptDiskFile(col.wordAudioPath);
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

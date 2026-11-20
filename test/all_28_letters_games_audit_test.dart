import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';

/// Parses pixel (width, height) directly from a RIFF/WEBP file header
/// (supports VP8, VP8L, and VP8X chunks without external packages).
(int, int) _readWebpDimensions(File file) {
  final bytes = file.readAsBytesSync();
  final data = ByteData.sublistView(bytes);
  expect(bytes.length, greaterThanOrEqualTo(30), reason: 'Too small WebP: ${file.path}');
  final riff = String.fromCharCodes(bytes.sublist(0, 4));
  final webp = String.fromCharCodes(bytes.sublist(8, 12));
  expect(riff, 'RIFF', reason: 'Not RIFF: ${file.path}');
  expect(webp, 'WEBP', reason: 'Not WEBP: ${file.path}');

  final chunk = String.fromCharCodes(bytes.sublist(12, 16));
  if (chunk == 'VP8X') {
    final w = 1 + (bytes[24] | (bytes[25] << 8) | (bytes[26] << 16));
    final h = 1 + (bytes[27] | (bytes[28] << 8) | (bytes[29] << 16));
    return (w, h);
  }
  if (chunk == 'VP8L') {
    final bits = data.getUint32(21, Endian.little);
    final w = (bits & 0x3FFF) + 1;
    final h = ((bits >> 14) & 0x3FFF) + 1;
    return (w, h);
  }
  if (chunk == 'VP8 ') {
    final w = data.getUint16(26, Endian.little) & 0x3FFF;
    final h = data.getUint16(28, Endian.little) & 0x3FFF;
    return (w, h);
  }
  fail('Unknown WebP chunk "$chunk" in ${file.path}');
}

String _normalizeArabicForLetterMatch(String text) {
  // Strip tashkeel & tatweel for letter-containment checks
  return text.replaceAll(RegExp(r'[\u064B-\u065F\u0670\u0640]'), '');
}

int? _extractTargetDiacritic(String word, String letter) {
  final base = letter.replaceAll('ـ', '').trim();
  final target = base.isEmpty ? letter : base[0];
  for (int i = 0; i < word.length; i++) {
    if (word[i] == target) {
      for (int j = i + 1; j < word.length && j <= i + 2; j++) {
        final code = word.codeUnitAt(j);
        if (code == 0x064E || code == 0x064F || code == 0x0650 || code == 0x0652) {
          return code;
        }
      }
    }
  }
  return null;
}

int? _extractCellDiacritic(String label) {
  for (int i = 0; i < label.length; i++) {
    final code = label.codeUnitAt(i);
    if (code == 0x064E || code == 0x064F || code == 0x0650 || code == 0x0652) {
      return code;
    }
  }
  return null;
}

File _assetFile(String relPath) {
  final normalized = relPath.startsWith('assets/') ? relPath : 'assets/$relPath';
  return File(normalized);
}

void main() {
  // 200%-zoom visually verified Left/Right Fatha vs Kasra polarity per letter
  // true  => Fatha (َ) is on the LEFT hexagon (px < 650), Kasra (ِ) on RIGHT
  // false => Kasra (ِ) is on the LEFT hexagon (px < 650), Fatha (َ) on RIGHT
  const Map<String, bool> fathaOnLeftPolarity = {
    'ث': true,
    'ج': false,
    'ح': false,
    'خ': false,
    'د': true,
    'ذ': true,
    'ر': false,
    'ز': true,
    'س': true,
    'ش': true,
    'ص': true,
    'ض': false,
    'ط': true,
    'ظ': true,
    'ع': false,
    'غ': false,
    'ف': true,
    'ق': false,
    'ك': false,
    'ل': false,
    'م': true,
    'ن': true,
    'ه': true,
    'و': true,
  };

  group('Zero-Defect Games Audit Across All 26 Curriculum Manifests (ت → ي)', () {
    for (final m in allCurriculumManifests) {
      group('Letter ${m.letter} (Unit ${m.unitIndex})', () {
        test('GamesSpec shared audio assets exist on disk', () {
          final g = m.games;
          final optionalAudios = <String?>[
            g.fishingIntroAudio,
            g.fishingPromptAudio,
            g.fishingWrongAudio,
            g.beehivePromptAudio,
            g.beehiveWrongAudio,
            g.circusPromptAudio,
            g.circusWrongAudio,
            g.wordsMatchPromptAudio,
            g.wordsMatchWrongAudio,
            g.coloringIntroAudio,
            g.coloringStep1Audio,
            g.coloringStep2Audio,
            g.coloringWrongAudio,
            g.praiseFinishAudio,
          ];
          for (final p in optionalAudios) {
            if (p != null && p.isNotEmpty) {
              expect(_assetFile(p).existsSync(), isTrue, reason: '${m.letter}: missing shared audio $p');
            }
          }
        });

        test('Beehive: explicit cells, exact dims, diacritic & L/R polarity verified', () {
          expect(m.games.beehive, isNotEmpty);
          for (int i = 0; i < m.games.beehive.length; i++) {
            final rd = m.games.beehive[i];
            final imgFile = _assetFile(rd.imagePath);
            expect(imgFile.existsSync(), isTrue, reason: '${m.letter} BH R${i + 1}: missing ${rd.imagePath}');
            expect(_assetFile(rd.audioPath).existsSync(), isTrue, reason: '${m.letter} BH R${i + 1}: missing ${rd.audioPath}');
            if (rd.praiseAudio != null) {
              expect(_assetFile(rd.praiseAudio!).existsSync(), isTrue);
            }

            final (aw, ah) = _readWebpDimensions(imgFile);
            expect((aw - rd.imgW).abs(), lessThanOrEqualTo(2), reason: '${m.letter} BH R${i + 1}: imgW mismatch (actual=$aw, decl=${rd.imgW})');
            expect((ah - rd.imgH).abs(), lessThanOrEqualTo(2), reason: '${m.letter} BH R${i + 1}: imgH mismatch (actual=$ah, decl=${rd.imgH})');

            final cells = rd.cells;
            expect(cells, isNotNull, reason: '${m.letter} BH R${i + 1}: must have explicit cells (no fallback)');
            final expectedCount = m.letter == 'ي' ? 3 : 4;
            expect(cells!.length, expectedCount, reason: '${m.letter} BH R${i + 1}: expected $expectedCount cells');

            final correctCells = cells.where((c) => c.isCorrect).toList();
            expect(correctCells.length, 1, reason: '${m.letter} BH R${i + 1}: must have strictly 1 correct cell');

            // Bounds & uniqueness check
            final seenCoords = <String>{};
            for (final c in cells) {
              expect(c.px, inInclusiveRange(0, rd.imgW), reason: '${m.letter} BH R${i + 1}: cell px out of bounds');
              expect(c.py, inInclusiveRange(0, rd.imgH), reason: '${m.letter} BH R${i + 1}: cell py out of bounds');
              expect(seenCoords.add('${c.px.round()},${c.py.round()}'), isTrue, reason: '${m.letter} BH R${i + 1}: duplicate cell coord');
            }

            // Arabic diacritic matches word's target letter diacritic
            final wordDiac = _extractTargetDiacritic(rd.word, m.letter);
            final cellDiac = _extractCellDiacritic(correctCells.first.label);
            if (wordDiac != null) {
              expect(
                cellDiac,
                wordDiac,
                reason: '${m.letter} BH R${i + 1} (${rd.word}): correct cell "${correctCells.first.label}" diacritic does not match word',
              );
            }

            // Ground-truth Left/Right polarity guard (prevents Fatha/Kasra swap regressions forever!)
            if (fathaOnLeftPolarity.containsKey(m.letter)) {
              final fathaLeft = fathaOnLeftPolarity[m.letter]!;
              final fathaCell = cells.firstWhere((c) => _extractCellDiacritic(c.label) == 0x064E);
              final kasraCell = cells.firstWhere((c) => _extractCellDiacritic(c.label) == 0x0650);
              if (fathaLeft) {
                expect(fathaCell.px, lessThan(kasraCell.px),
                    reason: '${m.letter} BH R${i + 1}: Fatha must be LEFT of Kasra');
              } else {
                expect(kasraCell.px, lessThan(fathaCell.px),
                    reason: '${m.letter} BH R${i + 1}: Kasra must be LEFT of Fatha');
              }
            }
          }
        });

        test('Fishing: explicit zones, exact dims, winning fish contains target letter', () {
          expect(m.games.fishing, isNotEmpty);
          final targetLetter = _normalizeArabicForLetterMatch(m.letter);
          for (int i = 0; i < m.games.fishing.length; i++) {
            final rd = m.games.fishing[i];
            final imgFile = _assetFile(rd.imagePath);
            expect(imgFile.existsSync(), isTrue, reason: '${m.letter} FI R${i + 1}: missing ${rd.imagePath}');
            expect(_assetFile(rd.audioPath).existsSync(), isTrue, reason: '${m.letter} FI R${i + 1}: missing ${rd.audioPath}');
            final (aw, ah) = _readWebpDimensions(imgFile);
            expect((aw - rd.imgW).abs(), lessThanOrEqualTo(2), reason: '${m.letter} FI R${i + 1}: imgW mismatch');
            expect((ah - rd.imgH).abs(), lessThanOrEqualTo(2), reason: '${m.letter} FI R${i + 1}: imgH mismatch');

            final zones = rd.zones;
            expect(zones, isNotNull, reason: '${m.letter} FI R${i + 1}: must have explicit zones');
            expect(zones!.length, 3, reason: '${m.letter} FI R${i + 1}: expected 3 fish zones');
            final corr = zones.where((z) => z.isCorrect).toList();
            expect(corr.length, 1, reason: '${m.letter} FI R${i + 1}: strictly 1 correct fish');

            final normalizedWinning = _normalizeArabicForLetterMatch(corr.first.label);
            expect(
              normalizedWinning.contains(targetLetter),
              isTrue,
              reason: '${m.letter} FI R${i + 1}: winning fish "${corr.first.label}" does not contain "${m.letter}"',
            );
            for (final z in zones) {
              expect(z.px, inInclusiveRange(0, rd.imgW));
              expect(z.py, inInclusiveRange(0, rd.imgH));
            }
          }
        });

        test('Circus: explicit zones, exact dims, strictly 1 correct target', () {
          expect(m.games.circus, isNotEmpty);
          for (int i = 0; i < m.games.circus.length; i++) {
            final rd = m.games.circus[i];
            final imgFile = _assetFile(rd.imagePath);
            expect(imgFile.existsSync(), isTrue, reason: '${m.letter} CI R${i + 1}: missing ${rd.imagePath}');
            expect(_assetFile(rd.audioPath).existsSync(), isTrue, reason: '${m.letter} CI R${i + 1}: missing ${rd.audioPath}');
            final (aw, ah) = _readWebpDimensions(imgFile);
            expect((aw - rd.imgW).abs(), lessThanOrEqualTo(2), reason: '${m.letter} CI R${i + 1}: imgW mismatch');
            expect((ah - rd.imgH).abs(), lessThanOrEqualTo(2), reason: '${m.letter} CI R${i + 1}: imgH mismatch');

            final zones = rd.zones;
            expect(zones, isNotNull, reason: '${m.letter} CI R${i + 1}: must have explicit zones');
            expect(zones!.length, 3);
            final corr = zones.where((z) => z.isCorrect).toList();
            expect(corr.length, 1, reason: '${m.letter} CI R${i + 1}: strictly 1 correct target');
            for (final z in zones) {
              expect(z.px, inInclusiveRange(0, rd.imgW));
              expect(z.py, inInclusiveRange(0, rd.imgH));
              if (z.wordAudio != null && z.wordAudio!.isNotEmpty) {
                expect(_assetFile(z.wordAudio!).existsSync(), isTrue, reason: '${m.letter} CI R${i + 1}: missing ${z.wordAudio}');
              }
            }
          }
        });

        test('WordsMatch: explicit cards, exact dims, winning card matches word', () {
          expect(m.games.wordsMatch, isNotEmpty);
          for (int i = 0; i < m.games.wordsMatch.length; i++) {
            final rd = m.games.wordsMatch[i];
            final imgFile = _assetFile(rd.imagePath);
            expect(imgFile.existsSync(), isTrue, reason: '${m.letter} WM R${i + 1}: missing ${rd.imagePath}');
            expect(_assetFile(rd.audioPath).existsSync(), isTrue, reason: '${m.letter} WM R${i + 1}: missing ${rd.audioPath}');
            final (aw, ah) = _readWebpDimensions(imgFile);
            expect((aw - rd.imgW).abs(), lessThanOrEqualTo(2), reason: '${m.letter} WM R${i + 1}: imgW mismatch');
            expect((ah - rd.imgH).abs(), lessThanOrEqualTo(2), reason: '${m.letter} WM R${i + 1}: imgH mismatch');

            final cards = rd.cards;
            expect(cards, isNotNull, reason: '${m.letter} WM R${i + 1}: must have explicit cards');
            expect(cards!.length, 3);
            final corr = cards.where((c) => c.isCorrect).toList();
            expect(corr.length, 1, reason: '${m.letter} WM R${i + 1}: strictly 1 correct card');
            expect(
              _normalizeArabicForLetterMatch(corr.first.label),
              _normalizeArabicForLetterMatch(rd.word),
              reason: '${m.letter} WM R${i + 1}: winning card "${corr.first.label}" != rd.word "${rd.word}"',
            );
          }
        });

        test('Coloring: explicit options, exact dims, all masks & audios exist', () {
          expect(m.games.coloring, isNotEmpty);
          for (int i = 0; i < m.games.coloring.length; i++) {
            final rd = m.games.coloring[i];
            final bgFile = _assetFile(rd.bgImagePath);
            expect(bgFile.existsSync(), isTrue, reason: '${m.letter} CO R${i + 1}: missing ${rd.bgImagePath}');
            expect(_assetFile(rd.wordRevealImagePath).existsSync(), isTrue, reason: '${m.letter} CO R${i + 1}: missing ${rd.wordRevealImagePath}');
            expect(_assetFile(rd.introAudioPath).existsSync(), isTrue, reason: '${m.letter} CO R${i + 1}: missing ${rd.introAudioPath}');
            expect(_assetFile(rd.revealAudioPath).existsSync(), isTrue, reason: '${m.letter} CO R${i + 1}: missing ${rd.revealAudioPath}');
            if (rd.wrongRevealAudioPath != null) {
              expect(_assetFile(rd.wrongRevealAudioPath!).existsSync(), isTrue);
            }
            if (rd.wordAudioPath != null) {
              expect(_assetFile(rd.wordAudioPath!).existsSync(), isTrue);
            }
            expect(rd.slices, isNotEmpty);
            for (final s in rd.slices) {
              expect(_assetFile(s.maskImagePath).existsSync(), isTrue, reason: '${m.letter} CO R${i + 1}: missing slice ${s.maskImagePath}');
            }

            final (aw, ah) = _readWebpDimensions(bgFile);
            expect((aw - rd.imgW).abs(), lessThanOrEqualTo(2), reason: '${m.letter} CO R${i + 1}: imgW mismatch');
            expect((ah - rd.imgH).abs(), lessThanOrEqualTo(2), reason: '${m.letter} CO R${i + 1}: imgH mismatch');

            final opts = rd.options;
            expect(opts, isNotNull, reason: '${m.letter} CO R${i + 1}: must have explicit options');
            expect(opts!.length, 3);
            final corr = opts.where((o) => o.isCorrect).toList();
            expect(corr.length, 1, reason: '${m.letter} CO R${i + 1}: strictly 1 correct option');
            expect(
              _normalizeArabicForLetterMatch(corr.first.label),
              _normalizeArabicForLetterMatch(rd.word),
              reason: '${m.letter} CO R${i + 1}: winning option "${corr.first.label}" != rd.word "${rd.word}"',
            );
          }
        });
      });
    }
  });

  group('Alif & Baa Custom Games Integrity', () {
    test('Alif custom game screens declare accurate native dimensions (not 1270x950)', () {
      for (final path in [
        'lib/features/games/screens/beehive_game.dart',
        'lib/features/games/screens/word_fishing_game.dart',
        'lib/features/games/screens/circus_game.dart',
        'lib/features/games/screens/words_match_game.dart',
      ]) {
        final content = File(path).readAsStringSync();
        expect(content.contains('1270'), isFalse, reason: '$path still uses drifted 1270x950 dims');
      }
    });

    test('GenericWordFishingGame does not hardcode ha_fatha.mp3 fallback', () {
      final content = File('lib/features/games/screens/universal/generic_word_fishing_game.dart').readAsStringSync();
      expect(content.contains("ha_fatha.mp3"), isFalse);
    });
  });
}

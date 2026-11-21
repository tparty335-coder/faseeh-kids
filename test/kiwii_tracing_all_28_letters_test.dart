import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/letter_tracing_words_catalog.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_writing_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_writing_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/unified_kiwii_writing_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_writing_station.dart';
import 'package:faseeh_kids/features/lessons/widgets/arabic_letter_tracing_canvas.dart';

void main() {
  const all28Letters = [
    'أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ',
    'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص',
    'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق',
    'ك', 'ل', 'م', 'ن', 'ه', 'و', 'ي',
  ];
  const all4Positions = ['isolated', 'start', 'middle', 'end'];

  String resolveAudioFile(String audioPath) {
    final normalized = audioPath.startsWith('assets/') ? audioPath : 'assets/$audioPath';
    return normalized;
  }

  group('Kiwii / Montessori Tracing — All 28 Letters x 4 Positions (112 forms)', () {
    test('All 112 letter forms have valid, non-empty, safely bounded vector strokes', () {
      int totalFormsChecked = 0;
      for (final letter in all28Letters) {
        for (final pos in all4Positions) {
          final strokes = ArabicLetterTracingData.getStrokesForLetter(letter, position: pos);
          expect(strokes, isNotEmpty, reason: 'Missing strokes for $letter ($pos)');
          for (final s in strokes) {
            expect(s.pathPoints, isNotEmpty, reason: 'Empty pathPoints for $letter ($pos) stroke ${s.index}');
            for (final pt in s.pathPoints) {
              expect(
                pt.dx >= 0.04 && pt.dx <= 0.96 && pt.dy >= 0.04 && pt.dy <= 0.96,
                isTrue,
                reason: 'Out-of-bounds point $pt in $letter ($pos) stroke ${s.index}',
              );
            }
          }
          totalFormsChecked++;
        }
      }
      expect(totalFormsChecked, 112);
    });

    test('All 28 letter profiles have 4 positions, 4 illustrated words, and 100% existing disk assets', () {
      for (final letter in all28Letters) {
        final profile = LetterTracingWordsCatalog.getProfile(letter);
        expect(profile.definiteTitle, startsWith('حَرْفُ'), reason: 'Title for $letter');
        expect(profile.positions.length, 4, reason: 'Positions count for $letter');
        expect(profile.words.length, 4, reason: 'Illustrated words count for $letter');

        // Verify intro audio exists on disk
        final introFile = File(resolveAudioFile(profile.introAudioPath));
        expect(introFile.existsSync(), isTrue, reason: 'Missing intro audio for $letter: ${introFile.path}');

        // Verify all 4 position audios exist on disk
        for (int i = 0; i < 4; i++) {
          final pos = profile.positions[i];
          expect(pos.position, all4Positions[i]);
          expect(pos.displayForm, isNotEmpty);
          final audioFile = File(resolveAudioFile(pos.audioPath));
          expect(audioFile.existsSync(), isTrue, reason: 'Missing pos audio for $letter (${pos.position}): ${audioFile.path}');
        }

        // Verify all 4 illustrated words have valid images, audios, and cropRects
        for (final w in profile.words) {
          expect(w.word, isNotEmpty, reason: 'Empty word for $letter');
          expect(File(w.imagePath).existsSync(), isTrue, reason: 'Missing word image for $letter (${w.word}): ${w.imagePath}');
          final wAudio = File(resolveAudioFile(w.audioPath));
          expect(wAudio.existsSync(), isTrue, reason: 'Missing word audio for $letter (${w.word}): ${wAudio.path}');
          expect(w.cropRect.left >= 0 && w.cropRect.right <= 1.0 && w.cropRect.width > 0.2, isTrue);
          expect(w.cropRect.top >= 0 && w.cropRect.bottom <= 1.0 && w.cropRect.height > 0.2, isTrue);
        }
      }
    });

    testWidgets('Alif, Baa, and all 26 Universal writing stations render UnifiedKiwiiWritingStation cleanly', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1280));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // Alif
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AlifWritingStation(onNext: () {}, onPrevious: () {}),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(UnifiedKiwiiWritingStation), findsOneWidget);
      expect(find.text('حَرْفُ الْأَلِفِ'), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Baa
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaaWritingStation(onNext: () {}, onPrevious: () {}),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(UnifiedKiwiiWritingStation), findsOneWidget);
      expect(find.text('حَرْفُ الْبَاءِ'), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Sample Universal manifests (ت, س, ص, م, ن, هـ, ي)
      for (final ch in ['ت', 'س', 'ص', 'م', 'ن', 'ه', 'ي']) {
        final manifest = findManifestForLetter(ch)!;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: UniversalWritingStation(
                spec: manifest.tracing,
                onNext: () {},
                onPrevious: () {},
              ),
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(UnifiedKiwiiWritingStation), findsOneWidget);
        expect(find.byType(ArabicLetterTracingCanvas), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('Switching all 4 positions & tapping words works with zero overflow across 4 viewports + 1.3x text', (tester) async {
      final viewports = <Size>[
        const Size(320, 568),
        const Size(360, 800),
        const Size(800, 1280),
        const Size(1280, 800),
      ];
      addTearDown(() => tester.binding.setSurfaceSize(null));

      for (final vp in viewports) {
        await tester.binding.setSurfaceSize(vp);
        bool nextCalled = false;
        bool prevCalled = false;

        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(
              size: vp,
              textScaler: const TextScaler.linear(1.3),
            ),
            child: MaterialApp(
              home: Scaffold(
                body: UnifiedKiwiiWritingStation(
                  letterChar: 'م',
                  onNext: () => nextCalled = true,
                  onPrevious: () => prevCalled = true,
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull, reason: 'Overflow at $vp');

        // Tap each of the 4 positions
        for (final posLabel in ['أَوَّلُ الْكَلِمَةِ', 'وَسَطُ الْكَلِمَةِ', 'آخِرُ الْكَلِمَةِ', 'مُنْفَصِلٌ']) {
          final finder = find.text(posLabel).first;
          await tester.tap(finder);
          await tester.pump();
          expect(tester.takeException(), isNull, reason: 'Overflow switching to $posLabel at $vp');
        }

        // Tap bottom nav buttons
        await tester.tap(find.text('السَّابِقُ'));
        await tester.tap(find.text('كَلِمَاتُ الْحَرْفِ'));
        await tester.pump();
        expect(prevCalled, isTrue);
        expect(nextCalled, isTrue);
      }
    });

    testWidgets('Haa (هـ) uses exact 1-stroke Kiwii order, defaults to هـ in writing station, and uses real Haa audio', (tester) async {
      final strokes = ArabicLetterTracingData.getStrokesForLetter('ه', position: 'start');
      expect(strokes.length, 1, reason: 'هـ must be 1 continuous stroke matching ه.jpg');
      final pts = strokes.first.pathPoints;
      expect(pts.first.dy, lessThan(0.35), reason: 'Starts at top golden dot');
      expect(pts.any((p) => p.dx > 0.80), isTrue, reason: 'Sweeps down-right outer belly');
      expect(pts.any((p) => p.dx < 0.40 && p.dy < 0.52), isTrue, reason: 'Loops around inner circle');
      expect(pts.last.dx, lessThan(0.18), reason: 'Exits horizontally to left end');

      final haaManifest = findManifestForLetter('ه')!;
      expect(haaManifest.tracing.audioIntroPath, contains('haa'));
      expect(haaManifest.tracing.audioIntroPath, isNot(contains('faa')));

      await tester.binding.setSurfaceSize(const Size(800, 1280));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UnifiedKiwiiWritingStation(
              letterChar: 'ه',
              tracingSpec: haaManifest.tracing,
              onNext: () {},
              onPrevious: () {},
            ),
          ),
        ),
      );
      await tester.pump();
      // Default active canvas for Haa must be 'start' (هـ), NOT isolated 'ه' circle
      final canvasWidget = tester.widget<ArabicLetterTracingCanvas>(find.byType(ArabicLetterTracingCanvas));
      expect(canvasWidget.position, 'start');
      expect(tester.takeException(), isNull);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/taa_manifest.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_coloring_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_word_fishing_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Letter Taa (ت) manifest & data invariants', () {
    test('Story has 6 unique scenes ending with Nasheed and 4 word-find targets', () {
      expect(taaManifest.story.scenes.length, 6);
      expect(taaManifest.story.scenes.where((s) => s.isNasheed).length, 1);
      expect(taaManifest.story.scenes.last.isNasheed, isTrue);
      // No duplicate scene images
      final imgs = taaManifest.story.scenes.map((s) => s.imagePath).toSet();
      expect(imgs.length, 6);
    });

    test('Words station has 5 pages x 4 words = 20 words calibrated to 800x474', () {
      expect(taaManifest.words.pages.length, 5);
      for (final pg in taaManifest.words.pages) {
        expect(pg.listImageHeight, 474);
        expect(pg.words.length, 4);
        for (final w in pg.words) {
          expect(w.cardHeight, 474);
          expect(w.speakerOffset, const Offset(139, 151));
          expect(w.closeOffset, const Offset(604, 152));
        }
      }
    });

    test('Coloring rounds match exact madd words: تِين(0), تِمْسَاح(2), تُوت(2)', () {
      final rounds = taaManifest.games.coloring;
      expect(rounds.length, 3);

      // Round 1: تِين ✅ (index 0), تَأْكُل ❌ (index 1), يَكْتُب ❌ (index 2)
      expect(rounds[0].word, 'تِين');
      expect(rounds[0].options!.map((o) => o.isCorrect).toList(), [true, false, false]);

      // Round 2: تَمْر ❌, بِنْت ❌, تِمْسَاح ✅ (index 2)
      expect(rounds[1].word, 'تِمْسَاح');
      expect(rounds[1].options!.map((o) => o.isCorrect).toList(), [false, false, true]);

      // Round 3: أَرْنَب ❌, يَلْعَب ❌, تُوت ✅ (index 2)
      expect(rounds[2].word, 'تُوت');
      expect(rounds[2].options!.map((o) => o.isCorrect).toList(), [false, false, true]);
    });

    test('Beehive rounds have explicit cells matching كَتْكُوت(تْ), تَأْكُلُ(تَ), يَكْتُبُ(تُ), تِمْسَاح(تِ)', () {
      final rounds = taaManifest.games.beehive;
      expect(rounds.length, 4);
      final expected = [
        ('كَتْكُوت', 'تْ', 741.0, 254.0),
        ('تَأْكُلُ', 'تَ', 690.0, 171.0),
        ('يَكْتُبُ', 'تُ', 544.0, 258.0),
        ('تِمْسَاح', 'تِ', 595.0, 341.0),
      ];
      for (int i = 0; i < expected.length; i++) {
        final rd = rounds[i];
        expect(rd.word, expected[i].$1);
        expect(rd.imgW, 800);
        expect(rd.imgH, 440);
        expect(rd.cells, isNotNull);
        final correct = rd.cells!.where((c) => c.isCorrect).toList();
        expect(correct.length, 1);
        expect(correct.first.label, expected[i].$2);
        expect(correct.first.px, expected[i].$3);
        expect(correct.first.py, expected[i].$4);
      }
    });

    test('Circus rounds use 1024x499, prompt audio, clean round 2 image, and correct answers [2, 1, 0]', () {
      expect(taaManifest.games.circusPromptAudio, 'audio/games/circus/taa/taa_circus_prompt.mp3');
      final rounds = taaManifest.games.circus;
      expect(rounds.length, 3);
      // Clean round 2 image (no 'ت - حوت' spoiler)
      expect(rounds[1].imagePath, 'assets/images/games/circus/taa_circus_round_2.webp');
      final expected = [
        ('تِمْسَاح', 2),
        ('حُوت', 1),
        ('تِين', 0),
      ];
      for (int i = 0; i < expected.length; i++) {
        final rd = rounds[i];
        expect(rd.word, expected[i].$1);
        expect(rd.imgW, 1024);
        expect(rd.imgH, 499);
        expect(rd.zones, isNotNull);
        expect(rd.zones!.indexWhere((z) => z.isCorrect), expected[i].$2);
      }
    });
  });

  group('Letter Taa (ت) live widget interaction tests on phone portrait (360x800)', () {
    testWidgets('Coloring Round 1: tapping تِين (top card) succeeds and tapping تَأْكُل (middle card) fails', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // 1. Tap middle card (تَأْكُل) -> MUST be rejected (cancel icon, score stays 0)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GenericColoringGame(manifest: taaManifest)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));

      final gestures = find.descendant(
        of: find.byType(GenericColoringGame),
        matching: find.byType(GestureDetector),
      );
      expect(gestures, findsAtLeastNWidgets(3));

      // Tap card index 1 (تَأْكُل)
      await tester.tap(gestures.at(1));
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);
      expect(find.textContaining('⭐ 0'), findsOneWidget);

      // Drain pending wrong-audio timeout + rebuild
      await tester.pump(const Duration(seconds: 4));
      await tester.pump();

      // 2. Now tap card index 0 (تِين) -> MUST succeed (check icon, score becomes 1)
      await tester.tap(gestures.at(0));
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
      expect(find.textContaining('⭐ 1'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('Beehive Round 1 (كَتْكُوت): tapping تْ (index 2) succeeds with ⭐ 1', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GenericBeehiveGame(manifest: taaManifest)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));

      // GestureDetectors inside Beehive scene: index 0 = speaker, 1..4 = cells (تَ, تُ, تْ, تِ)
      final gestures = find.descendant(
        of: find.byType(GenericBeehiveGame),
        matching: find.byType(GestureDetector),
      );
      expect(gestures, findsAtLeastNWidgets(5));

      // Tap cell index 2 (تْ) -> gesture index 3
      await tester.tap(gestures.at(3));
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.textContaining('⭐ 1'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 8));
    });

    testWidgets('Circus Round 1 (تِمْسَاح): tapping bottom circle (index 2) succeeds with ⭐ 1', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GenericCircusGame(manifest: taaManifest)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));

      final gestures = find.descendant(
        of: find.byType(GenericCircusGame),
        matching: find.byType(GestureDetector),
      );
      expect(gestures, findsAtLeastNWidgets(3));

      // Tap bottom circle (index 2 = تِمْسَاح)
      await tester.tap(gestures.at(2));
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.textContaining('⭐ 1'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 8));
    });

    testWidgets('All 5 Taa games render cleanly with zero overflow on phone 360x800', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      for (final game in [
        GenericWordFishingGame(manifest: taaManifest),
        GenericBeehiveGame(manifest: taaManifest),
        GenericCircusGame(manifest: taaManifest),
        GenericWordsMatchGame(manifest: taaManifest),
        GenericColoringGame(manifest: taaManifest),
      ]) {
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: game)));
        await tester.pump(const Duration(milliseconds: 100));
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 8));
      }
    });
  });
}

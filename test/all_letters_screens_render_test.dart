import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Data & Providers
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';

// Hub & Lesson Shell Screens
import 'package:faseeh_kids/features/lessons/screens/universal_letter_hub_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/lesson_sequence_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/games_activity_screen.dart';

// Sequence Widgets
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/words_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/story_sequence_widget.dart';

// Manifests
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/seen_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/yaa_manifest.dart';

// Universal Games (ش → ي)
import 'package:faseeh_kids/features/games/screens/universal/generic_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_coloring_game.dart';

// Game Screens — Alif (5)
import 'package:faseeh_kids/features/games/screens/word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/circus_game.dart';
import 'package:faseeh_kids/features/games/screens/words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/coloring_madd_game.dart';

// Game Screens — Baa (5)
import 'package:faseeh_kids/features/games/screens/baa/baa_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/baa/baa_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/baa/baa_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/baa/baa_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/baa/baa_coloring_game.dart';

// Game Screens — Taa (5)
import 'package:faseeh_kids/features/games/screens/taa/taa_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/taa/taa_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/taa/taa_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/taa/taa_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/taa/taa_coloring_game.dart';

// Game Screens — Thaa (5)
import 'package:faseeh_kids/features/games/screens/thaa/thaa_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/thaa/thaa_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/thaa/thaa_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/thaa/thaa_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/thaa/thaa_coloring_game.dart';

// Game Screens — Jeem (5)
import 'package:faseeh_kids/features/games/screens/jeem/jeem_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_coloring_game.dart';

// Game Screens — Ha (5)
import 'package:faseeh_kids/features/games/screens/ha/ha_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/ha/ha_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/ha/ha_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/ha/ha_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/ha/ha_coloring_game.dart';

// Game Screens — Kha (5)
import 'package:faseeh_kids/features/games/screens/kha/kha_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/kha/kha_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/kha/kha_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/kha/kha_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/kha/kha_coloring_game.dart';

// Game Screens — Dal (5)
import 'package:faseeh_kids/features/games/screens/dal/dal_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/dal/dal_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/dal/dal_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/dal/dal_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/dal/dal_coloring_game.dart';

// Game Screens — Dhaal (5)
import 'package:faseeh_kids/features/games/screens/dhaal/dhaal_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/dhaal/dhaal_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/dhaal/dhaal_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/dhaal/dhaal_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/dhaal/dhaal_coloring_game.dart';

// Game Screens — Raa (5)
import 'package:faseeh_kids/features/games/screens/raa/raa_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/raa/raa_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/raa/raa_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/raa/raa_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/raa/raa_coloring_game.dart';

// Game Screens — Zaay (5)
import 'package:faseeh_kids/features/games/screens/zaay/zaay_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/zaay/zaay_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/zaay/zaay_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/zaay/zaay_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/zaay/zaay_coloring_game.dart';

// Game Screens — Seen (5)
import 'package:faseeh_kids/features/games/screens/seen/seen_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_coloring_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = false;

  Widget buildTestApp(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: Material(child: child),
      ),
    );
  }

  Future<void> pumpAndVerifyScreen(WidgetTester tester, Widget screen) async {
    await tester.pumpWidget(buildTestApp(screen));
    await tester.pump(const Duration(seconds: 2));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 2));
  }

  group('1. UniversalLetterHubScreen Render Tests for ALL 28 Arabic Letters', () {
    for (final letterObj in arabicLetters) {
      final char = letterObj.letter;
      testWidgets('Renders UniversalLetterHubScreen safely for letter $char', (tester) async {
        await pumpAndVerifyScreen(tester, UniversalLetterHubScreen(letterChar: char));
      });
    }
  });

  group('2. Alif and Baa Dedicated Screens Render Tests Across All 7 Stations', () {
    for (int station = 0; station < 7; station++) {
      testWidgets('Letter أ (AlifLessonScreen) renders Station $station safely', (tester) async {
        await pumpAndVerifyScreen(tester, AlifLessonScreen(initialStationIndex: station));
      });
    }

    for (int station = 0; station < 7; station++) {
      testWidgets('Letter ب (BaaLessonScreen) renders Station $station safely', (tester) async {
        await pumpAndVerifyScreen(tester, BaaLessonScreen(initialStationIndex: station));
      });
    }
  });

  group('3. LetterLessonShellScreen Render Tests for All 26 Manifests Across All 7 Stations', () {
    final manifests = allCurriculumManifests;

    for (final m in manifests) {
      for (int station = 0; station < 7; station++) {
        testWidgets('Letter ${m.letter} renders Station $station safely', (tester) async {
          await pumpAndVerifyScreen(
            tester,
            LetterLessonShellScreen(
              manifest: m,
              initialStationIndex: station,
            ),
          );
        });
      }
    }
  });

  group('4. Interactive Sub-Page Progression Across All 12 Letters (Vowels, Madd, Tracing, Words)', () {
    const letters = ['أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س'];

    Future<void> tapAndAdvance(WidgetTester tester, Finder finder) async {
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
    }

    for (final char in letters) {
      testWidgets('ShortVowelsSequenceWidget ($char) steps through all 4 vowels safely', (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            ShortVowelsSequenceWidget(
              letterChar: char,
              onNext: () {},
              onPrevious: () {},
            ),
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        expect(tester.takeException(), isNull);

        // Advance through damma, kasra, sukoon
        for (int step = 0; step < 3; step++) {
          await tapAndAdvance(tester, find.text('التالي'));
        }
        // On last vowel (sukoon), button label changes to 'التالي: الْمُدُود'
        expect(find.text('التالي: الْمُدُود'), findsOneWidget);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
      });

      testWidgets('LongVowelsSequenceWidget ($char) steps through intro and all 3 madd examples safely', (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            LongVowelsSequenceWidget(
              letterChar: char,
              onNext: () {},
              onPrevious: () {},
            ),
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        expect(tester.takeException(), isNull);

        // Page 0 -> Page 1 (madd alif)
        await tapAndAdvance(tester, find.text('أَمْثِلَةُ الْمَدِّ'));

        // Page 1 -> Page 2 (madd waw)
        await tapAndAdvance(tester, find.text('الْمَدُّ التَّالِي'));

        // Page 2 -> Page 3 (madd yaa)
        await tapAndAdvance(tester, find.text('الْمَدُّ التَّالِي'));

        // On Page 3 (madd yaa), button label changes to 'التالي: الْكَلِمَات'
        expect(find.text('التالي: الْكَلِمَات'), findsOneWidget);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
      });

      testWidgets('TraceSequenceWidget ($char) steps through all letter positions safely', (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            TraceSequenceWidget(
              letterChar: char,
              onNext: () {},
              onPrevious: () {},
            ),
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        expect(tester.takeException(), isNull);

        final totalTransitions = char == 'ب' ? 5 : 3;
        for (int step = 0; step < totalTransitions; step++) {
          await tapAndAdvance(tester, find.text('التالي'));
        }
        // On last step, button label changes to 'التالي: ألعاب الحرف 🎮'
        expect(find.text('التالي: ألعاب الحرف 🎮'), findsOneWidget);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
      });
    }
  });

  group('5. Sequence Screens & All 80 Universal Games Render Tests (ش through ي)', () {
    testWidgets('LessonSequenceScreen renders safely', (tester) async {
      await pumpAndVerifyScreen(tester, const LessonSequenceScreen());
    });

    testWidgets('GamesActivityScreen renders safely', (tester) async {
      await pumpAndVerifyScreen(tester, const GamesActivityScreen());
    });

    for (final char in ['ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'هـ', 'و', 'ي']) {
      testWidgets('Sequence widgets render safely for letter $char', (tester) async {
        await pumpAndVerifyScreen(
          tester,
          ShortVowelsSequenceWidget(letterChar: char, onNext: () {}, onPrevious: () {}),
        );
        await pumpAndVerifyScreen(
          tester,
          LongVowelsSequenceWidget(letterChar: char, onNext: () {}, onPrevious: () {}),
        );
        await pumpAndVerifyScreen(
          tester,
          TraceSequenceWidget(letterChar: char, onNext: () {}, onPrevious: () {}),
        );
        await pumpAndVerifyScreen(
          tester,
          WordsSequenceWidget(letterChar: char, onNext: () {}, onPrevious: () {}),
        );
        await pumpAndVerifyScreen(
          tester,
          StorySequenceWidget(letterChar: char, onNext: () {}),
        );
      });
    }

    final batch16Manifests = allCurriculumManifests.where((m) => m.unitIndex >= 13).toList();
    for (final m in batch16Manifests) {
      testWidgets('Universal games (5 games) render safely for ${m.letter}', (tester) async {
        await pumpAndVerifyScreen(tester, Scaffold(body: GenericWordFishingGame(manifest: m)));
        await pumpAndVerifyScreen(tester, Scaffold(body: GenericBeehiveGame(manifest: m)));
        await pumpAndVerifyScreen(tester, Scaffold(body: GenericCircusGame(manifest: m)));
        await pumpAndVerifyScreen(tester, Scaffold(body: GenericWordsMatchGame(manifest: m)));
        await pumpAndVerifyScreen(tester, Scaffold(body: GenericColoringGame(manifest: m)));
      });
    }
  });

  group('6. All 60 Game Screens Render Tests Across All 12 Letters (5 Games x 12 Letters)', () {
    final gameScreens = <String, Widget Function()>{
      // Alif (أ)
      'أ - Fishing': () => const WordFishingGame(),
      'أ - Beehive': () => const BeehiveGame(),
      'أ - Circus': () => const CircusGame(),
      'أ - WordsMatch': () => const WordsMatchGame(),
      'أ - Coloring': () => const ColoringMaddGame(),
      // Baa (ب)
      'ب - Fishing': () => const BaaWordFishingGame(),
      'ب - Beehive': () => const BaaBeeHiveGame(),
      'ب - Circus': () => const BaaCircusGame(),
      'ب - WordsMatch': () => const BaaWordsMatchGame(),
      'ب - Coloring': () => const BaaColoringGame(),
      // Taa (ت)
      'ت - Fishing': () => const TaaWordFishingGame(),
      'ت - Beehive': () => const TaaBeeHiveGame(),
      'ت - Circus': () => const TaaCircusGame(),
      'ت - WordsMatch': () => const TaaWordsMatchGame(),
      'ت - Coloring': () => const TaaColoringGame(),
      // Thaa (ث)
      'ث - Fishing': () => const ThaaWordFishingGame(),
      'ث - Beehive': () => const ThaaBeeHiveGame(),
      'ث - Circus': () => const ThaaCircusGame(),
      'ث - WordsMatch': () => const ThaaWordsMatchGame(),
      'ث - Coloring': () => const ThaaColoringGame(),
      // Jeem (ج)
      'ج - Fishing': () => const JeemWordFishingGame(),
      'ج - Beehive': () => const JeemBeeHiveGame(),
      'ج - Circus': () => const JeemCircusGame(),
      'ج - WordsMatch': () => const JeemWordsMatchGame(),
      'ج - Coloring': () => const JeemColoringGame(),
      // Ha (ح)
      'ح - Fishing': () => const HaWordFishingGame(),
      'ح - Beehive': () => const HaBeeHiveGame(),
      'ح - Circus': () => const HaCircusGame(),
      'ح - WordsMatch': () => const HaWordsMatchGame(),
      'ح - Coloring': () => const HaColoringGame(),
      // Kha (خ)
      'خ - Fishing': () => const KhaWordFishingGame(),
      'خ - Beehive': () => const KhaBeeHiveGame(),
      'خ - Circus': () => const KhaCircusGame(),
      'خ - WordsMatch': () => const KhaWordsMatchGame(),
      'خ - Coloring': () => const KhaColoringGame(),
      // Dal (د)
      'د - Fishing': () => const DalWordFishingGame(),
      'د - Beehive': () => const DalBeeHiveGame(),
      'د - Circus': () => const DalCircusGame(),
      'د - WordsMatch': () => const DalWordsMatchGame(),
      'د - Coloring': () => const DalColoringGame(),
      // Dhaal (ذ)
      'ذ - Fishing': () => const DhaalWordFishingGame(),
      'ذ - Beehive': () => const DhaalBeeHiveGame(),
      'ذ - Circus': () => const DhaalCircusGame(),
      'ذ - WordsMatch': () => const DhaalWordsMatchGame(),
      'ذ - Coloring': () => const DhaalColoringGame(),
      // Raa (ر)
      'ر - Fishing': () => const RaaWordFishingGame(),
      'ر - Beehive': () => const RaaBeeHiveGame(),
      'ر - Circus': () => const RaaCircusGame(),
      'ر - WordsMatch': () => const RaaWordsMatchGame(),
      'ر - Coloring': () => const RaaColoringGame(),
      // Zaay (ز)
      'ز - Fishing': () => const ZaayWordFishingGame(),
      'ز - Beehive': () => const ZaayBeeHiveGame(),
      'ز - Circus': () => const ZaayCircusGame(),
      'ز - WordsMatch': () => const ZaayWordsMatchGame(),
      'ز - Coloring': () => const ZaayColoringGame(),
      // Seen (س)
      'س - Fishing': () => const SeenWordFishingGame(),
      'س - Beehive': () => const SeenBeeHiveGame(),
      'س - Circus': () => const SeenCircusGame(),
      'س - WordsMatch': () => const SeenWordsMatchGame(),
      'س - Coloring': () => const SeenColoringGame(),
    };

    for (final entry in gameScreens.entries) {
      testWidgets('Renders game screen [${entry.key}] safely', (tester) async {
        await pumpAndVerifyScreen(tester, entry.value());
      });
    }
  });

  group('7. Phone Portrait (360x800) Narrow Viewport & Interactive Words/Story Progression', () {
    Future<void> pumpPhoneScreen(WidgetTester tester, Widget screen) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0; // 360x800 logical pixels (HVA63BT9)
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestApp(screen));
      await tester.pump(const Duration(seconds: 1));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
    }

    testWidgets('UniversalLetterHubScreen renders without overflow on 360x800 phone', (tester) async {
      for (final char in ['أ', 'ب', 'ت', 'س', 'ي']) {
        await pumpPhoneScreen(tester, UniversalLetterHubScreen(letterChar: char));
      }
    });

    testWidgets('AlifLessonScreen & BaaLessonScreen render all 7 stations on 360x800 phone', (tester) async {
      for (int s = 0; s < 7; s++) {
        await pumpPhoneScreen(tester, AlifLessonScreen(initialStationIndex: s));
        await pumpPhoneScreen(tester, BaaLessonScreen(initialStationIndex: s));
      }
    });

    testWidgets('LetterLessonShellScreen renders all 7 stations & advances all 5 Words pages on 360x800 phone', (tester) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      for (int s = 0; s < 7; s++) {
        await tester.pumpWidget(
          buildTestApp(
            LetterLessonShellScreen(
              manifest: seenManifest,
              initialStationIndex: s,
            ),
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        expect(tester.takeException(), isNull);

        if (s == 5) {
          // Step through all pages of UniversalWordsStation up to 'الألعاب' button
          for (int p = 0; p < seenManifest.words.pages.length - 1; p++) {
            await tester.tap(find.text('الصفحة التالية'));
            await tester.pump(const Duration(milliseconds: 300));
            expect(tester.takeException(), isNull);
          }
          expect(find.widgetWithText(ElevatedButton, 'الألعاب'), findsOneWidget);
        }

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
      }
    });

    testWidgets('Yaa (ي) final unit renders all 7 stations & 4 Words pages on 360x800 phone', (tester) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      for (int s = 0; s < 7; s++) {
        await tester.pumpWidget(
          buildTestApp(
            LetterLessonShellScreen(
              manifest: yaaManifest,
              initialStationIndex: s,
            ),
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        expect(tester.takeException(), isNull);

        if (s == 5) {
          for (int p = 0; p < yaaManifest.words.pages.length - 1; p++) {
            await tester.tap(find.text('الصفحة التالية'));
            await tester.pump(const Duration(milliseconds: 300));
            expect(tester.takeException(), isNull);
          }
          expect(find.widgetWithText(ElevatedButton, 'الألعاب'), findsOneWidget);
        }

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
      }
    });

    testWidgets('All 26 curriculum manifests render all 7 stations without overflow on 360x800 phone', (tester) async {
      for (final m in allCurriculumManifests) {
        for (int s = 0; s < 7; s++) {
          await pumpPhoneScreen(
            tester,
            LetterLessonShellScreen(
              manifest: m,
              initialStationIndex: s,
            ),
          );
        }
      }
    });

    testWidgets('Universal interactive stations & GenericColoringGame palette fit on 360x800 and 320x568', (tester) async {
      // 320x568 extra-narrow phone viewport for GenericColoringGame palette
      tester.view.physicalSize = const Size(640, 1136);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestApp(
          Scaffold(body: GenericColoringGame(manifest: yaaManifest)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 500));

      // 360x800 interactive ChoiceChips across Sounds, Madd, Writing & opening a Universal game
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;

      for (final s in [2, 3, 4]) {
        await tester.pumpWidget(
          buildTestApp(
            LetterLessonShellScreen(
              manifest: yaaManifest,
              initialStationIndex: s,
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));
        expect(tester.takeException(), isNull);

        final chips = find.byType(ChoiceChip);
        final count = tester.widgetList(chips).length;
        for (int i = 0; i < count; i++) {
          await tester.tap(chips.at(i));
          await tester.pump(const Duration(milliseconds: 250));
          expect(tester.takeException(), isNull);
        }

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(milliseconds: 500));
      }

      // Station 6: open a game card and return to menu
      await tester.pumpWidget(
        buildTestApp(
          LetterLessonShellScreen(
            manifest: yaaManifest,
            initialStationIndex: 6,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('التلوين'));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);

      await tester.tap(find.byTooltip('العودة للألعاب'));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 500));
    });
  });
}

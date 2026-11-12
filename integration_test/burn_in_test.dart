import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';

import 'package:faseeh_kids/features/games/screens/universal/generic_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_coloring_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_words_match_game.dart';
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/dal/dal_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/dhaal/dhaal_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/ha/ha_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/jeem/jeem_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/kha/kha_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/raa/raa_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/seen/seen_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/taa/taa_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/thaa/thaa_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/universal_letter_hub_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/zaay/zaay_games_station.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// اختبار الحرق الشامل على الجهاز الحقيقي:
/// - صوت حقيقي (audioplayers على Android) + خط حقيقي + تسرب الذاكرة (RSS per cycle)
/// - الحروف الـ 28 (Hub)
/// - شاشات أ وب المخصصة (14 محطة) + كل شاشات Shell الـ 26 × 7 محطات = 182 محطة
/// - الـ 12 محطة ألعاب السابقة (أ → س) + الـ 80 لعبة موحدة (ش → ي)
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const cycles = int.fromEnvironment('BURN_CYCLES', defaultValue: 3);
  final failures = <String>[];
  final timings = <String, int>{};
  final rssMb = <int>[];

  setUpAll(() async {
    PaintingBinding.instance.imageCache.maximumSizeBytes = 40 << 20;
    PaintingBinding.instance.imageCache.maximumSize = 120;
    final tmp = await Directory.systemTemp.createTemp('faseeh_burn_hive_');
    Hive.init(tmp.path);
  });

  Widget app(Widget child) => ProviderScope(
        child: MaterialApp(
          builder: (c, w) => Directionality(
            textDirection: TextDirection.rtl,
            child: w!,
          ),
          home: Material(child: child),
        ),
      );

  var visitedCount = 0;

  Future<void> visit(WidgetTester tester, String label, Widget screen) async {
    final sw = Stopwatch()..start();
    try {
      await tester.pumpWidget(app(screen));
      await tester.pump(const Duration(milliseconds: 300));
      final ex = tester.takeException();
      if (ex != null) {
        failures.add('$label -> $ex');
        debugPrint('BURN_EX $label -> $ex');
      }
    } catch (e) {
      failures.add('$label -> THROW $e');
      debugPrint('BURN_THROW $label -> $e');
    } finally {
      await AudioService.instance.stop().timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          failures.add('$label -> AudioService.stop TIMEOUT');
          debugPrint('BURN_AUDIO_TIMEOUT $label');
        },
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 80));
      // تصريف أي استثناء غير متزامن بعد تفريغ الشاشة حتى لا يسقط الاختبار وسط الدورة
      final postEx = tester.takeException();
      if (postEx != null) {
        failures.add('$label [post] -> $postEx');
        debugPrint('BURN_POST_EX $label -> $postEx');
      }
      sw.stop();
      timings[label] = sw.elapsedMilliseconds;
      visitedCount++;
      if (sw.elapsedMilliseconds > 2500 || visitedCount % 25 == 0) {
        final rss = ProcessInfo.currentRss ~/ (1024 * 1024);
        debugPrint('BURN_PROG #$visitedCount [$label] ${sw.elapsedMilliseconds}ms rss=${rss}MB fail=${failures.length}');
      }
    }
  }

  testWidgets('BURN-IN: all 28 letters, stations and games on device', (tester) async {
    void noop() {}
    final legacyStations = <MapEntry<String, Widget>>[
      MapEntry('أ', AlifGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ب', BaaGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ت', TaaGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ث', ThaaGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ج', JeemGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ح', HaGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('خ', KhaGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('د', DalGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ذ', DhaalGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ر', RaaGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('ز', ZaayGamesStation(onNext: noop, onPrevious: noop)),
      MapEntry('س', SeenGamesStation(onNext: noop, onPrevious: noop)),
    ];

    for (var c = 0; c < cycles; c++) {
      for (final l in arabicLetters) {
        await visit(tester, 'c$c hub ${l.letter}',
            UniversalLetterHubScreen(letterChar: l.letter));
      }
      for (var s = 0; s < 7; s++) {
        await visit(tester, 'c$c alif st$s', AlifLessonScreen(initialStationIndex: s));
        await visit(tester, 'c$c baa st$s', BaaLessonScreen(initialStationIndex: s));
      }
      for (final m in allCurriculumManifests) {
        for (var s = 0; s < 7; s++) {
          await visit(
            tester,
            'c$c shell ${m.letter} st$s',
            LetterLessonShellScreen(manifest: m, initialStationIndex: s),
          );
        }
      }
      for (final entry in legacyStations) {
        await visit(tester, 'c$c legacy_games ${entry.key}', entry.value);
      }
      for (final m in allCurriculumManifests.where((m) => m.unitIndex >= 13)) {
        await visit(tester, 'c$c fishing ${m.letter}', GenericWordFishingGame(manifest: m));
        await visit(tester, 'c$c beehive ${m.letter}', GenericBeehiveGame(manifest: m));
        await visit(tester, 'c$c circus ${m.letter}', GenericCircusGame(manifest: m));
        await visit(tester, 'c$c match ${m.letter}', GenericWordsMatchGame(manifest: m));
        await visit(tester, 'c$c coloring ${m.letter}', GenericColoringGame(manifest: m));
      }
      final cycleRss = ProcessInfo.currentRss ~/ (1024 * 1024);
      final imgMb = PaintingBinding.instance.imageCache.currentSizeBytes ~/ (1024 * 1024);
      rssMb.add(cycleRss);
      debugPrint('BURN_CYCLE c$c done visited=$visitedCount rss=${cycleRss}MB imgCache=${imgMb}MB fail=${failures.length}');
    }

    final slow = timings.entries.where((e) => e.value > 2000).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    binding.reportData = <String, dynamic>{
      'cycles': cycles,
      'screens_visited': timings.length,
      'failures': failures,
      'rss_mb_per_cycle': rssMb,
      'slowest': {for (final e in slow.take(15)) e.key: e.value},
    };
    // ignore: avoid_print
    print('BURN_RESULT screens=${timings.length} failures=${failures.length} rssMB=$rssMb');
    for (final f in failures) {
      // ignore: avoid_print
      print('BURN_FAIL $f');
    }
    expect(failures, isEmpty);
  }, timeout: const Timeout(Duration(minutes: 40)));
}

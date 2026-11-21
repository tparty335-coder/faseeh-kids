import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/core/audio_clip_durations.dart';
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/seen_manifest.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_madd_station.dart';

void main() {
  String toAssetFile(String p) => p.startsWith('assets/') ? p : 'assets/$p';

  group('Seen & Universal Madd Station — Audio, Visuals & Zero-Overflow Verification', () {
    test('Seen Madd uses verified audio clips (no swapped/broken files) and all disk assets exist', () {
      expect(seenManifest.madd.useManifestMadd, isTrue);
      expect(seenManifest.madd.items.length, 3);

      // Shared Madd concept & types audio exist and have accurate >6s durations registered
      expect(File('assets/audio/lessons/baa/sounds/baa_madd_def.mp3').existsSync(), isTrue);
      expect(File('assets/audio/lessons/taa/madd/taa_madd_types.mp3').existsSync(), isTrue);
      expect(kAudioClipDurationsMs['audio/lessons/baa/sounds/baa_madd_def.mp3']!, greaterThan(10000));
      expect(kAudioClipDurationsMs['audio/lessons/taa/madd/taa_madd_types.mp3']!, greaterThan(5000));
      expect(kAudioClipDurationsMs['audio/lessons/seen/madd/seen_madd_waw.mp3']!, greaterThan(8000));

      // Verify Seen tracing & fishing intro audio are genuine Seen clips (not Laam/Ha)
      expect(seenManifest.tracing.audioIntroPath, contains('seen'));
      expect(seenManifest.games.fishingIntroAudio, contains('seen'));

      final expected = [
        ('سَا', 'تِمْسَاح'),
        ('سُو', 'نُسُور'),
        ('سِي', 'بِرْسِيم'),
      ];
      for (int i = 0; i < 3; i++) {
        final item = seenManifest.madd.items[i];
        expect(item.displayChar, expected[i].$1);
        expect(item.exampleWord, expected[i].$2);
        expect(item.audioPath, isNot(contains('seen_madd_def.mp3')));
        expect(File(toAssetFile(item.audioPath)).existsSync(), isTrue, reason: item.audioPath);
        expect(item.wordAudioPath, isNotNull);
        expect(File(toAssetFile(item.wordAudioPath!)).existsSync(), isTrue, reason: item.wordAudioPath);
        expect(File(item.imagePath).existsSync(), isTrue, reason: item.imagePath);
        expect(item.imageCropRect, isNotNull);
      }

      // Verify short vowel comparison audios for Seen exist on disk
      for (final suffix in ['fatha', 'damma', 'kasra']) {
        expect(
          File('assets/audio/letters/short_vowels/seen_$suffix.mp3').existsSync(),
          isTrue,
        );
      }
    });

    testWidgets('UniversalMaddStation renders all 4 tabs for Seen & other manifests with zero overflow across 4 viewports + 1.3x text', (tester) async {
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
            data: MediaQueryData(size: vp, textScaler: const TextScaler.linear(1.3)),
            child: MaterialApp(
              home: Scaffold(
                body: UniversalMaddStation(
                  spec: seenManifest.madd,
                  onNext: () => nextCalled = true,
                  onPrevious: () => prevCalled = true,
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull, reason: 'Intro overflow at $vp');
        expect(find.text('مَا هُوَ الْمَدُّ؟'), findsAtLeastNWidgets(1));

        // Step through all 3 Madd examples via bottom button
        await tester.tap(find.text('أَمْثِلَةُ الْمَدِّ'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull, reason: 'Alif Madd overflow at $vp');
        expect(find.text('سَا'), findsAtLeastNWidgets(1));

        await tester.tap(find.text('الْمَدُّ التَّالِي'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull, reason: 'Waw Madd overflow at $vp');
        expect(find.text('سُو'), findsAtLeastNWidgets(1));

        await tester.tap(find.text('الْمَدُّ التَّالِي'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull, reason: 'Yaa Madd overflow at $vp');
        expect(find.text('سِي'), findsAtLeastNWidgets(1));

        // Final next triggers onNext
        await tester.tap(find.text('الْكِتَابَةُ'));
        await tester.pump();
        expect(nextCalled, isTrue);

        // Return to tab 0 and tap previous triggers onPrevious
        await tester.tap(find.text('مَا هُوَ الْمَدُّ؟').first);
        await tester.pump();
        await tester.tap(find.text('السَّابِقُ'));
        await tester.pump();
        expect(prevCalled, isTrue);

        // Clean dispose so zero pending timers remain
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      }

      // Also smoke-verify other manifests using UniversalMaddStation (ش، م، هـ)
      await tester.binding.setSurfaceSize(const Size(800, 1280));
      for (final ch in ['ش', 'م', 'ه']) {
        final m = findManifestForLetter(ch)!;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: UniversalMaddStation(
                spec: m.madd,
                onNext: () {},
                onPrevious: () {},
              ),
            ),
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull, reason: 'Exception on $ch Madd');
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      }
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/features/lessons/screens/universal_letter_hub_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UniversalLetterHubScreen world-class UX & responsive checks', () {
    testWidgets('Renders grammatically correct Arabic, 7 stations, 3 vowels, no 0/11, no double gamepad icon', (tester) async {
      tester.view.physicalSize = const Size(800, 1340);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UniversalLetterHubScreen(letterChar: 'ب'),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      // Grammatical correctness with 'ال' التعريف
      expect(find.text('حَرْفُ الْبَاءِ'), findsOneWidget);
      expect(find.textContaining('حَرْفُ بَاء'), findsNothing);

      // No broken legacy 0/11 counter
      expect(find.textContaining('/11'), findsNothing);

      // No duplicate gamepad emoji inside Games button
      expect(find.textContaining('🎮'), findsNothing);
      expect(find.text('أَلْعَابُ وَأَسْئِلَةُ الْحَرْفِ'), findsOneWidget);
      expect(find.text('ابْدَأْ دَرْسَ حَرْفِ الْبَاءِ'), findsOneWidget);

      // Interactive short vowels present
      expect(find.text('بَ'), findsOneWidget);
      expect(find.text('بُ'), findsOneWidget);
      expect(find.text('بِ'), findsOneWidget);

      // All 7 lesson stations present
      for (final title in [
        'الْأَهْدَافُ',
        'الْقِصَّةُ',
        'الْأَصْوَاتُ',
        'الْمُدُودُ',
        'الْكِتَابَةُ',
        'الْكَلِمَاتُ',
        'الْأَلْعَابُ',
      ]) {
        expect(find.text(title), findsOneWidget);
      }

      // Tap a vowel pill without crashing
      await tester.tap(find.text('بَ'));
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('Zero overflow across phone SE, phone portrait, tablet portrait, tablet landscape, and 1.3x textScaler', (tester) async {
      final sizes = [
        const Size(320, 568),
        const Size(360, 800),
        const Size(800, 1340),
        const Size(1340, 800),
      ];

      for (final sz in sizes) {
        tester.view.physicalSize = sz;
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              builder: (ctx, child) => MediaQuery(
                data: MediaQuery.of(ctx).copyWith(
                  textScaler: const TextScaler.linear(1.3),
                ),
                child: child!,
              ),
              home: const UniversalLetterHubScreen(letterChar: 'أ'),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));
        expect(tester.takeException(), isNull, reason: 'Overflow at $sz');

        // Alif orthography uses إِ for kasra
        expect(find.text('أَ'), findsOneWidget);
        expect(find.text('أُ'), findsOneWidget);
        expect(find.text('إِ'), findsOneWidget);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 4));
      }

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}

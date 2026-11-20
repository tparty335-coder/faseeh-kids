import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/features/lessons/screens/universal_letter_hub_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UniversalLetterHubScreen world-class UX across all 28 Arabic letters', () {
    testWidgets('All 28 letters (أ → ي) render with definite Arabic title, 7 stations, 3 vowels, no 0/11, no double icon, zero overflow', (tester) async {
      tester.view.physicalSize = const Size(800, 1340);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      const expectedTitles = {
        'أ': 'حَرْفُ الْأَلِفِ',
        'ب': 'حَرْفُ الْبَاءِ',
        'ت': 'حَرْفُ التَّاءِ',
        'ث': 'حَرْفُ الثَّاءِ',
        'ج': 'حَرْفُ الْجِيمِ',
        'ح': 'حَرْفُ الْحَاءِ',
        'خ': 'حَرْفُ الْخَاءِ',
        'د': 'حَرْفُ الدَّالِ',
        'ذ': 'حَرْفُ الذَّالِ',
        'ر': 'حَرْفُ الرَّاءِ',
        'ز': 'حَرْفُ الزَّايِ',
        'س': 'حَرْفُ السِّينِ',
        'ش': 'حَرْفُ الشِّينِ',
        'ص': 'حَرْفُ الصَّادِ',
        'ض': 'حَرْفُ الضَّادِ',
        'ط': 'حَرْفُ الطَّاءِ',
        'ظ': 'حَرْفُ الظَّاءِ',
        'ع': 'حَرْفُ الْعَيْنِ',
        'غ': 'حَرْفُ الْغَيْنِ',
        'ف': 'حَرْفُ الْفَاءِ',
        'ق': 'حَرْفُ الْقَافِ',
        'ك': 'حَرْفُ الْكَافِ',
        'ل': 'حَرْفُ اللَّامِ',
        'م': 'حَرْفُ الْمِيمِ',
        'ن': 'حَرْفُ النُّونِ',
        'ه': 'حَرْفُ الْهَاءِ',
        'و': 'حَرْفُ الْوَاوِ',
        'ي': 'حَرْفُ الْيَاءِ',
      };

      expect(arabicLetters.length, 28);

      for (final item in arabicLetters) {
        final ch = item.letter;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: UniversalLetterHubScreen(letterChar: ch),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(tester.takeException(), isNull, reason: 'Exception on letter $ch');

        // Exact grammatically definite title
        final expectedTitle = expectedTitles[ch]!;
        expect(find.text(expectedTitle), findsOneWidget, reason: 'Title mismatch on $ch');

        // No broken 0/11 or duplicate gamepad emoji
        expect(find.textContaining('/11'), findsNothing, reason: 'Legacy /11 on $ch');
        expect(find.textContaining('🎮'), findsNothing, reason: 'Duplicate emoji on $ch');

        // Interactive short vowels present
        final isAlif = ch == 'أ';
        expect(find.text(isAlif ? 'أَ' : '$chَ'), findsOneWidget);
        expect(find.text(isAlif ? 'أُ' : '$chُ'), findsOneWidget);
        expect(find.text(isAlif ? 'إِ' : '$chِ'), findsOneWidget);

        // All 7 stations present
        for (final st in const [
          'الْأَهْدَافُ',
          'الْقِصَّةُ',
          'الْأَصْوَاتُ',
          'الْمُدُودُ',
          'الْكِتَابَةُ',
          'الْكَلِمَاتُ',
          'الْأَلْعَابُ',
        ]) {
          expect(find.text(st), findsOneWidget, reason: 'Missing station $st on $ch');
        }

        // Clean dispose & drain timers
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 3));
      }
    });

    testWidgets('Zero overflow across phone SE, phone portrait, tablet portrait, tablet landscape, and 1.3x textScaler', (tester) async {
      final sizes = [
        const Size(320, 568),
        const Size(360, 800),
        const Size(800, 1340),
        const Size(1340, 800),
      ];
      final sampleLetters = ['أ', 'ب', 'ت', 'م', 'ه', 'ي'];

      for (final ch in sampleLetters) {
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
                home: UniversalLetterHubScreen(letterChar: ch),
              ),
            ),
          );
          await tester.pump(const Duration(milliseconds: 400));
          expect(tester.takeException(), isNull, reason: 'Overflow on $ch at $sz');

          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pump(const Duration(seconds: 3));
        }
      }

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}

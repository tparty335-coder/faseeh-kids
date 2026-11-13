import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/noon_manifest.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_madd_station.dart';

void main() {
  testWidgets('UniversalMaddStation starts on Madd intro before letter examples',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: UniversalMaddStation(
              spec: noonManifest.madd,
              onNext: () {},
              onPrevious: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    // Opens on the general Madd definition and 3-type overview first
    expect(find.text('مَا هُوَ الْمَدُّ؟'), findsNWidgets(2));
    expect(find.text('اسْتَمِعْ لِشَرْحِ الْمَدِّ كَامِلاً'), findsOneWidget);
    expect(find.text('أَنْوَاعُ الْمَدِّ مَعَ حَرْفِ (ن):'), findsOneWidget);

    // Tapping the example CTA switches to نَا example view
    await tester.ensureVisible(find.text('ابْدَأْ بِأَمْثِلَةِ حَرْفِ (ن)'));
    await tester.tap(find.text('ابْدَأْ بِأَمْثِلَةِ حَرْفِ (ن)'));
    await tester.pump();

    expect(find.text('استمع (نَا)'), findsOneWidget);
    expect(find.text('نُونٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: نَا'), findsOneWidget);

    // Switching back to intro works cleanly
    await tester.tap(find.text('مَا هُوَ الْمَدُّ؟'));
    await tester.pump();
    expect(find.text('اسْتَمِعْ لِشَرْحِ الْمَدِّ كَامِلاً'), findsOneWidget);
  });
}

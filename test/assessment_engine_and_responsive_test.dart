import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faseeh_kids/features/assessment/data/assessment_curriculum_data.dart';
import 'package:faseeh_kids/features/assessment/engine/arabic_question_engine.dart';
import 'package:faseeh_kids/features/assessment/logic/assessment_provider.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';
import 'package:faseeh_kids/features/assessment/screens/assessment_hub_screen.dart';
import 'package:faseeh_kids/features/assessment/screens/assessment_session_screen.dart';
import 'package:faseeh_kids/features/home/screens/oasis_map_screen.dart';
import 'package:faseeh_kids/features/onboarding/screens/age_selection_screen.dart';

/// أحجام الشاشات العالمية الستة (من أقدم الهواتف الصغيرة حتى تابلت المستخدم Lenovo TB350XU)
const Map<String, Size> _worldDevices = {
  'Old Compact Phone 320x533': Size(320, 533),
  'Budget Android 360x640': Size(360, 640),
  'Standard iPhone 390x844': Size(390, 844),
  'Modern Android 412x915': Size(412, 915),
  'Small Tablet 600x960': Size(600, 960),
  'Lenovo TB350XU Tablet 960x1600': Size(960, 1600),
};

Widget _wrapScreen(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      locale: const Locale('ar'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: child,
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Curriculum & Infinite Procedural Question Engine (28 letters × 13 types)', () {
    test('4 units cover all 28 Arabic letters with 7 letters per unit and zero duplicates', () {
      expect(AssessmentCurriculumData.units.length, 4);
      final seen = <String>{};
      for (final unit in AssessmentCurriculumData.units) {
        expect(unit.letters.length, 7, reason: '${unit.titleAr} must have 7 letters');
        expect(unit.sentences.length, greaterThanOrEqualTo(4));
        for (final l in unit.letters) {
          expect(seen.add(l), isTrue, reason: 'Duplicate letter $l');
          final spec = AssessmentCurriculumData.letterSpec(l);
          expect(spec.words.length, greaterThanOrEqualTo(5));
        }
      }
      expect(seen.length, 28);
    });

    test('Every letter × every exercise type (364 combinations) generates valid questions with real assets on disk', () {
      final engine = ArabicQuestionEngine(seed: 42);
      int generated = 0;

      for (final letter in AssessmentCurriculumData.allLetterChars) {
        for (final type in ExerciseType.values) {
          final q = engine.generateQuestion(letter: letter, type: type);
          generated++;

          expect(q.letter, letter);
          expect(q.type, type);
          expect(q.instructionAr.trim(), isNotEmpty);

          if (q.imagePath != null) {
            expect(
              File(q.imagePath!).existsSync(),
              isTrue,
              reason: 'Missing image asset ${q.imagePath} for $letter / $type',
            );
          }

          switch (type) {
            case ExerciseType.findAndTapGrid:
            case ExerciseType.circleMatchLetter:
              expect(q.choices.where((c) => c.isCorrect).length, greaterThanOrEqualTo(3));
              break;
            case ExerciseType.similarLettersSpot:
            case ExerciseType.oddOneOut:
            case ExerciseType.chooseLetterForm:
            case ExerciseType.identifyLetterPosition:
            case ExerciseType.chooseHaraka:
            case ExerciseType.matchPictureToLetter:
            case ExerciseType.joinLettersToWord:
            case ExerciseType.missingLetterInWord:
              expect(q.choices.length, greaterThanOrEqualTo(3));
              expect(
                q.choices.where((c) => c.isCorrect).length,
                1,
                reason: '$letter / $type must have exactly 1 correct choice',
              );
              break;
            case ExerciseType.unscrambleWord:
            case ExerciseType.buildSentence:
              expect(q.sequenceItems.length, q.correctSequence.length);
              expect(q.correctSequence.length, greaterThanOrEqualTo(2));
              break;
            case ExerciseType.tracingDrill:
              expect(q.tracingPosition, isNotNull);
              break;
          }
        }
      }

      expect(generated, 28 * 13);
    });

    test('IRONCLAD PEDAGOGICAL LAW: Zero ambiguous distractors & exact word-picture alignment across all 28 letters', () {
      final engine = ArabicQuestionEngine(seed: 2026);
      for (int round = 0; round < 5; round++) {
        for (final letter in AssessmentCurriculumData.allLetterChars) {
          // 1. matchPictureToLetter: word MUST start with letter AND ZERO distractors may appear anywhere in word!
          final picQ = engine.generateQuestion(
            letter: letter,
            type: ExerciseType.matchPictureToLetter,
          );
          final word = picQ.secondaryPrompt!;
          expect(
            AssessmentCurriculumData.wordStartsWithLetter(word, letter),
            isTrue,
            reason: 'matchPictureToLetter for $letter picked "$word" which does NOT start with $letter!',
          );
          for (final choice in picQ.choices.where((c) => !c.isCorrect)) {
            expect(
              AssessmentCurriculumData.wordContainsLetter(word, choice.label),
              isFalse,
              reason: 'AMBIGUOUS DISTRACTOR! For "$word" (letter=$letter), wrong option "${choice.label}" is actually INSIDE the word!',
            );
          }

          // 2. identifyLetterPosition: target letter MUST occur exactly once in the word!
          final posQ = engine.generateQuestion(
            letter: letter,
            type: ExerciseType.identifyLetterPosition,
          );
          final posWordPlain = AssessmentCurriculumData.stripDiacritics(posQ.displayPrompt!);
          final occurrences = posWordPlain
              .split('')
              .where((ch) => AssessmentCurriculumData.normalizeChar(ch) == letter)
              .length;
          expect(
            occurrences,
            1,
            reason: 'identifyLetterPosition for $letter picked "${posQ.displayPrompt}" with $occurrences occurrences!',
          );

          // 3. oddOneOut (when words mode): 3 start with letter, 1 odd does NOT contain letter!
          final oddQ = engine.generateQuestion(
            letter: letter,
            type: ExerciseType.oddOneOut,
          );
          if (oddQ.choices.any((c) => c.imagePath != null)) {
            final oddChoice = oddQ.choices.firstWhere((c) => c.isCorrect);
            expect(
              AssessmentCurriculumData.wordContainsLetter(oddChoice.label, letter),
              isFalse,
              reason: 'oddOneOut odd word "${oddChoice.label}" accidentally contains $letter!',
            );
            for (final same in oddQ.choices.where((c) => !c.isCorrect)) {
              expect(
                AssessmentCurriculumData.wordStartsWithLetter(same.label, letter),
                isTrue,
                reason: 'oddOneOut same word "${same.label}" does not start with $letter!',
              );
            }
          }

          // 4. chooseHaraka: if illustration shown, its word starts with letter AND matches chosen haraka!
          final hQ = engine.generateQuestion(
            letter: letter,
            type: ExerciseType.chooseHaraka,
          );
          if (hQ.imagePath != null) {
            final fullWord = hQ.secondaryPrompt!;
            expect(
              AssessmentCurriculumData.wordStartsWithLetter(fullWord, letter),
              isTrue,
              reason: 'chooseHaraka word "$fullWord" must start with $letter',
            );
            expect(
              AssessmentCurriculumData.leadingHarakaOf(fullWord),
              hQ.correctText,
              reason: 'chooseHaraka word "$fullWord" haraka must match ${hQ.correctText}',
            );
          }
        }
      }
    });

    test('Unit exams cover all 6 skill domains across all 4 units with spiral review', () {
      final engine = ArabicQuestionEngine(seed: 101);
      for (int unitIdx = 1; unitIdx <= 4; unitIdx++) {
        final exam = engine.generateUnitExam(unitIndex: unitIdx, questionCount: 10);
        expect(exam.length, 10);
        final coveredDomains = exam.map((q) => q.domain).toSet();
        expect(
          coveredDomains.length,
          SkillDomain.values.length,
          reason: 'Unit $unitIdx exam must assess all 6 scientific domains',
        );
      }
    });

    test('Infinite generator produces fresh varied questions across repeated calls', () {
      final engine = ArabicQuestionEngine(seed: 7);
      final round1 = engine.generateInfinitePractice(count: 15);
      final round2 = engine.generateInfinitePractice(count: 15);
      final sigs1 = round1.map((q) => q.signature).toSet();
      final sigs2 = round2.map((q) => q.signature).toSet();
      expect(sigs1.difference(sigs2), isNotEmpty);
    });

    test('Diagnostic engine detects weak letters & weak domains and builds targeted remedial plan', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(assessmentDiagnosticsProvider.notifier);
      final result = notifier.recordSession(
        mode: AssessmentSessionMode.unitExam,
        unitIndex: 1,
        records: const [
          QuestionAttemptRecord(
            letter: 'ث',
            domain: SkillDomain.similarLetters,
            exerciseType: ExerciseType.similarLettersSpot,
            isCorrectFirstTry: false,
            attempts: 3,
          ),
          QuestionAttemptRecord(
            letter: 'ث',
            domain: SkillDomain.phonicsHarakat,
            exerciseType: ExerciseType.chooseHaraka,
            isCorrectFirstTry: false,
            attempts: 2,
          ),
          QuestionAttemptRecord(
            letter: 'أ',
            domain: SkillDomain.visualRecognition,
            exerciseType: ExerciseType.findAndTapGrid,
            isCorrectFirstTry: true,
            attempts: 1,
          ),
          QuestionAttemptRecord(
            letter: 'ب',
            domain: SkillDomain.letterPositions,
            exerciseType: ExerciseType.chooseLetterForm,
            isCorrectFirstTry: true,
            attempts: 1,
          ),
        ],
      );

      expect(result.percent, 50.0);
      expect(result.masteryLevel, MasteryLevel.needsSupport);
      expect(result.weakLetters, contains('ث'));

      final state = container.read(assessmentDiagnosticsProvider);
      final prescription = state.buildPrescription();
      expect(prescription.hasDiagnosedWeaknesses, isTrue);
      expect(prescription.weakLetters, contains('ث'));
      expect(prescription.weakDomains, contains(SkillDomain.similarLetters));

      // Generate targeted remedial session from prescription
      final remedialQuestions = ArabicQuestionEngine(seed: 12).generateRemedialSession(
        weakLetters: prescription.weakLetters,
        weakDomains: prescription.weakDomains,
        questionCount: 6,
      );
      expect(remedialQuestions.length, 6);
      expect(remedialQuestions.every((q) => q.isScaffolded), isTrue);
      expect(remedialQuestions.every((q) => q.letter == 'ث'), isTrue);
    });
  });

  group('Universal Responsive Zero-Overflow Audit (Old Phones 320x533 -> Tablet 960x1600)', () {
    for (final entry in _worldDevices.entries) {
      testWidgets('AssessmentHubScreen renders all 3 tabs cleanly on ${entry.key}', (tester) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final errors = <FlutterErrorDetails>[];
        final prevOnError = FlutterError.onError;
        FlutterError.onError = (details) => errors.add(details);

        try {
          await tester.pumpWidget(_wrapScreen(const AssessmentHubScreen()));
          await tester.pump(const Duration(milliseconds: 400));

          // Tab 0 (الوحدات)
          expect(find.text('الْوَحْدَةُ الْأُولَى'), findsOneWidget);

          // Switch to Tab 1 (التقوية)
          await tester.tap(find.text('التَّقْوِيَةُ'));
          await tester.pump(const Duration(milliseconds: 300));
          expect(find.textContaining('مَسَارَ التَّقْوِيَةِ'), findsOneWidget);

          // Switch to Tab 2 (لانهائي)
          await tester.tap(find.text('لَانِهَائِيٌّ'));
          await tester.pump(const Duration(milliseconds: 300));
          expect(find.textContaining('تَوْلِيدُ جَوْلَةٍ جَدِيدَةٍ'), findsOneWidget);
        } finally {
          FlutterError.onError = prevOnError;
        }

        expect(
          errors,
          isEmpty,
          reason: 'Overflow/layout error on ${entry.key}: ${errors.map((e) => e.exceptionAsString()).join('\n')}',
        );
      });
    }

    testWidgets('All 13 exercise types render cleanly on 320x533, 360x640, and 960x1600 tablet', (tester) async {
      const testSizes = [
        Size(320, 533),
        Size(360, 640),
        Size(960, 1600),
      ];

      final errors = <FlutterErrorDetails>[];
      final prevOnError = FlutterError.onError;
      FlutterError.onError = (details) => errors.add(details);

      try {
        for (final size in testSizes) {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;

          for (final type in ExerciseType.values) {
            await tester.pumpWidget(
              _wrapScreen(
                AssessmentSessionScreen(
                  args: AssessmentSessionArgs(
                    mode: AssessmentSessionMode.infinitePractice,
                    targetLetters: const ['م'],
                    specificExerciseType: type,
                    questionCount: 1,
                    titleAr: type.titleAr,
                  ),
                ),
              ),
            );
            await tester.pump(const Duration(milliseconds: 120));
          }
        }
      } finally {
        FlutterError.onError = prevOnError;
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      }

      expect(
        errors,
        isEmpty,
        reason: 'Render errors across 13 exercise types: ${errors.map((e) => e.exceptionAsString()).join('\n')}',
      );
    });

    testWidgets('OasisMapScreen with 4 Unit Checkpoints renders cleanly on 320x533, 360x640, and 960x1600', (tester) async {
      const testSizes = [
        Size(320, 533),
        Size(360, 640),
        Size(960, 1600),
      ];

      final errors = <FlutterErrorDetails>[];
      final prevOnError = FlutterError.onError;
      FlutterError.onError = (details) => errors.add(details);

      try {
        for (final size in testSizes) {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(_wrapScreen(const OasisMapScreen()));
          await tester.pump(const Duration(milliseconds: 600));
          expect(find.textContaining('الْوَحْدَةُ الْأُولَى'), findsOneWidget);
          expect(find.textContaining('الْوَحْدَةُ الرَّابِعَةُ'), findsOneWidget);

          // Also verify AgeSelectionScreen doesn't overflow on compact old phones
          await tester.pumpWidget(_wrapScreen(const AgeSelectionScreen()));
          await tester.pump(const Duration(milliseconds: 600));
          expect(find.text('كم عمرك؟'), findsOneWidget);
        }
        // Unmount repeating animations cleanly
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(milliseconds: 100));
      } finally {
        FlutterError.onError = prevOnError;
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      }

      expect(
        errors,
        isEmpty,
        reason: 'OasisMapScreen layout errors: ${errors.map((e) => e.exceptionAsString()).join('\n')}',
      );
    });
  });
}

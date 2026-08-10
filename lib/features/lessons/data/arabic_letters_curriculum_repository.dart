import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/features/lessons/models/letter_curriculum_model.dart';
import 'package:faseeh_kids/services/audio_registry.dart';

/// Master Curriculum Repository Provider
final curriculumRepositoryProvider = Provider<CurriculumRepository>((ref) {
  return CurriculumRepository();
});

class CurriculumRepository {
  /// Builds complete curriculum data for any letter with zero-waste mapping
  FullLetterCurriculum getCurriculumForLetter(String letterChar) {
    final key = AudioRegistry.letterKeyFromChar(letterChar);
    final name = AudioRegistry.letterNamesArabic[key] ?? letterChar;
    final word1 = AudioRegistry.exampleWords[key] ?? '';

    return FullLetterCurriculum(
      key: key,
      name: name,
      char: letterChar,
      harakat: [
        HarakaAsset(
          id: '${key}_fatha',
          symbol: 'َ',
          charWithHaraka: '$letterChar\u064E',
          variant: LetterAudioVariant.fatha,
          audioKey: '${key}_fatha',
          demoAudioKey: '${key}_fatha_demo',
        ),
        HarakaAsset(
          id: '${key}_kasra',
          symbol: 'ِ',
          charWithHaraka: '$letterChar\u0650',
          variant: LetterAudioVariant.kasra,
          audioKey: '${key}_kasra',
          demoAudioKey: '${key}_kasra_demo',
        ),
        HarakaAsset(
          id: '${key}_damma',
          symbol: 'ُ',
          charWithHaraka: '$letterChar\u064F',
          variant: LetterAudioVariant.damma,
          audioKey: '${key}_damma',
          demoAudioKey: '${key}_damma_demo',
        ),
        HarakaAsset(
          id: '${key}_sukoon',
          symbol: 'ْ',
          charWithHaraka: '$letterChar\u0652',
          variant: LetterAudioVariant.sukoon,
          audioKey: '${key}_sukoon',
        ),
      ],
      positions: [
        PositionAsset(
          id: '${key}_pos_start',
          position: LetterPosition.start,
          displayChar: '$letterCharـ',
          exampleWord: word1,
          audioKey: '${key}_pos_start',
        ),
        PositionAsset(
          id: '${key}_pos_middle',
          position: LetterPosition.middle,
          displayChar: 'ـ$letterCharـ',
          exampleWord: word1,
          audioKey: '${key}_pos_middle',
        ),
        PositionAsset(
          id: '${key}_pos_end',
          position: LetterPosition.end,
          displayChar: 'ـ$letterChar',
          exampleWord: word1,
          audioKey: '${key}_pos_end',
        ),
      ],
      words: [
        WordExampleAsset(
          id: '${key}_word1',
          word: word1,
          diacriticsWord: word1,
          audioKey: '${key}_word',
          sentenceAudioKey: '${key}_sentence',
        ),
        WordExampleAsset(
          id: '${key}_word2',
          word: word1,
          diacriticsWord: word1,
          audioKey: '${key}_word2',
        ),
        WordExampleAsset(
          id: '${key}_word3',
          word: word1,
          diacriticsWord: word1,
          audioKey: '${key}_word3',
        ),
        WordExampleAsset(
          id: '${key}_word4',
          word: word1,
          diacriticsWord: word1,
          audioKey: '${key}_word4',
        ),
      ],
      tracingSteps: List.generate(
        10,
        (idx) => TracingStepAsset(
          id: '${key}_step_${idx + 1}',
          stepIndex: idx + 1,
          pathPoints: [0.1 * idx, 0.2 * idx, 0.3 * idx, 0.4 * idx],
          instructionText: 'خطوة ${idx + 1} لرسم $name',
          audioKey: 'instr_${key}_trace_${(idx + 1).toString().padLeft(2, '0')}',
        ),
      ),
      storyAudioKey: 'story_$key',
      storyText: 'قصة حرف $name الشائقة والممتعة للأطفال',
    );
  }
}

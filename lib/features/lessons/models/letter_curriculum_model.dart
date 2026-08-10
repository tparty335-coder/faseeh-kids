import 'package:flutter/foundation.dart';

/// ════════════════════════════════════════════════════════════════════════════
/// 1. STRICT ENUMS FOR TYPE SAFETY (ZERO MAGIC STRINGS)
/// ════════════════════════════════════════════════════════════════════════════

/// Letter Sound Variants (Core + Extended MOE Curriculum)
enum LetterAudioVariant {
  name,          // اسم الحرف (ألف، باء)
  sound,         // صوت الحرف الأساسي (أَ، بَ)
  fatha,         // فتحة
  kasra,         // كسرة
  damma,         // ضمة
  sukoon,        // سكون
  fathaDemo,     // توضيح الحركة مطول
  kasraDemo,     // توضيح الكسرة مطول
  dammaDemo,     // توضيح الضمة مطول
  maddAlif,      // مد بالألف
  maddDemo,      // توضيح المدود
  posStart,      // أول الكلمة
  posMiddle,     // وسط الكلمة
  posEnd,        // آخر الكلمة
  word1,         // كلمة أولى
  word2,         // كلمة ثانية
  word3,         // كلمة ثالثة
  word4,         // كلمة رابعة
  sentence,      // جملة كاملة
}

/// Feedback Types
enum FeedbackAudioType {
  excellent,
  great,
  wonderful,
  tryAgain,
  close,
  champion,
  wow,
  correct,
  continueNext,
  smart,
}

/// Position in Word
enum LetterPosition { start, middle, end, isolated }

/// ════════════════════════════════════════════════════════════════════════════
/// 2. SEALED CLASS MODELS FOR ZERO-WASTE ASSET MAPPING
/// ════════════════════════════════════════════════════════════════════════════

/// Base Asset Model with Graceful Degradation metadata
@immutable
sealed class CurriculumAsset {
  final String id;
  final String? audioKey;
  final String? fallbackText;
  final String? imageAsset;

  const CurriculumAsset({
    required this.id,
    this.audioKey,
    this.fallbackText,
    this.imageAsset,
  });

  /// Check if visual asset is available
  bool get hasImage => imageAsset != null && imageAsset!.isNotEmpty;

  /// Check if audio asset is registered
  bool get hasAudio => audioKey != null && audioKey!.isNotEmpty;
}

/// Word Example Model (Holds up to 4 rich words per letter)
final class WordExampleAsset extends CurriculumAsset {
  final String word;
  final String diacriticsWord;
  final String? sentence;
  final String? sentenceAudioKey;

  const WordExampleAsset({
    required super.id,
    required this.word,
    required this.diacriticsWord,
    super.audioKey,
    super.imageAsset,
    this.sentence,
    this.sentenceAudioKey,
  }) : super(fallbackText: diacriticsWord);
}

/// Letter Haraka (Diacritic) Model
final class HarakaAsset extends CurriculumAsset {
  final String symbol;        // َ , ِ , ُ , ْ
  final String charWithHaraka; // أً, إِ, أُ, أْ
  final LetterAudioVariant variant;
  final String? demoAudioKey;

  const HarakaAsset({
    required super.id,
    required this.symbol,
    required this.charWithHaraka,
    required this.variant,
    super.audioKey,
    this.demoAudioKey,
  }) : super(fallbackText: charWithHaraka);
}

/// Letter Positional Form Model
final class PositionAsset extends CurriculumAsset {
  final LetterPosition position;
  final String displayChar;
  final String exampleWord;

  const PositionAsset({
    required super.id,
    required this.position,
    required this.displayChar,
    required this.exampleWord,
    super.audioKey,
    super.imageAsset,
  }) : super(fallbackText: displayChar);
}

/// Tracing Step Model (up to 20 voice-guided steps per letter)
final class TracingStepAsset extends CurriculumAsset {
  final int stepIndex;
  final List<double> pathPoints; // Normalized path [x1, y1, x2, y2...]
  final String instructionText;

  const TracingStepAsset({
    required super.id,
    required this.stepIndex,
    required this.pathPoints,
    required this.instructionText,
    super.audioKey,
  }) : super(fallbackText: instructionText);
}

/// Comprehensive Letter Curriculum (Zero-Waste Master Model)
@immutable
final class FullLetterCurriculum {
  final String key;                  // e.g. 'alif', 'baa'
  final String name;                 // ألف، باء
  final String char;                 // أ، ب
  final List<HarakaAsset> harakat;    // فتحة، كسرة، ضمة، سكون
  final List<PositionAsset> positions;// أول، وسط، آخر
  final List<WordExampleAsset> words; // كلمات الحرف (1-4)
  final List<TracingStepAsset> tracingSteps; // خطوات الرسم
  final String? storyAudioKey;        // قصة الحرف
  final String? storyText;

  const FullLetterCurriculum({
    required this.key,
    required this.name,
    required this.char,
    required this.harakat,
    required this.positions,
    required this.words,
    required this.tracingSteps,
    this.storyAudioKey,
    this.storyText,
  });
}

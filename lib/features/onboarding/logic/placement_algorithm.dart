import 'package:faseeh_kids/core/utils/age_group.dart';

/// Placement Algorithm — determines starting unit based on test results
/// P4-T010
///
/// Scoring:
/// - Correct answer: +1.5 weight
/// - Wrong answer: -1.0 weight
/// - Final score determines starting unit
class PlacementAlgorithm {
  PlacementAlgorithm._();

  /// Calculate placement result from answers
  /// Returns the starting unit ID
  static PlacementResult calculate({
    required List<bool> answers,
    required AgeGroup ageGroup,
  }) {
    double score = 0;

    for (final correct in answers) {
      if (correct) {
        score += 1.5;
      } else {
        score -= 1.0;
      }
    }

    // Normalize score to 0-1 range
    final maxScore = answers.length * 1.5;
    final minScore = answers.length * -1.0;
    final normalized = (score - minScore) / (maxScore - minScore);

    // Determine starting unit based on normalized score
    final startUnit = _determineUnit(normalized, ageGroup);
    final level = _determineLevel(normalized);

    return PlacementResult(
      rawScore: score,
      normalizedScore: normalized,
      correctCount: answers.where((a) => a).length,
      totalQuestions: answers.length,
      startingUnit: startUnit,
      level: level,
    );
  }

  /// Map normalized score to starting unit
  static String _determineUnit(double normalized, AgeGroup ageGroup) {
    // For preschool, always start from the beginning regardless of score
    if (ageGroup == AgeGroup.preschool3to5) {
      if (normalized < 0.3) return 'unit_01_alif';
      if (normalized < 0.6) return 'unit_02_baa_taa';
      return 'unit_03_thaa_jeem';
    }

    // For older kids, allow skipping ahead
    if (normalized < 0.2) return 'unit_01_alif';
    if (normalized < 0.4) return 'unit_03_thaa_jeem';
    if (normalized < 0.6) return 'unit_05_daal_raa';
    if (normalized < 0.8) return 'unit_08_saad_daad';
    return 'unit_10_faa_qaaf';
  }

  /// Determine proficiency level (1-5)
  static int _determineLevel(double normalized) {
    if (normalized < 0.2) return 1;
    if (normalized < 0.4) return 2;
    if (normalized < 0.6) return 3;
    if (normalized < 0.8) return 4;
    return 5;
  }
}

/// Result of placement test
class PlacementResult {
  final double rawScore;
  final double normalizedScore;
  final int correctCount;
  final int totalQuestions;
  final String startingUnit;
  final int level;

  const PlacementResult({
    required this.rawScore,
    required this.normalizedScore,
    required this.correctCount,
    required this.totalQuestions,
    required this.startingUnit,
    required this.level,
  });

  /// Percentage score (0-100)
  int get percentage => (normalizedScore * 100).round();

  /// Human-readable level in Arabic
  String get levelLabelAr {
    switch (level) {
      case 1: return 'مبتدئ';
      case 2: return 'أساسي';
      case 3: return 'متوسط';
      case 4: return 'متقدم';
      case 5: return 'متميز';
      default: return 'مبتدئ';
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastery_record.freezed.dart';
part 'mastery_record.g.dart';

/// Mastery levels for the spaced repetition system (modified SM-2).
enum MasteryLevel {
  @JsonValue('new')
  newSkill, // Never practiced
  @JsonValue('learning')
  learning, // 1-2 correct attempts
  @JsonValue('practiced')
  practiced, // 3-4 correct attempts
  @JsonValue('mastered')
  mastered, // 5+ correct with good recall
  @JsonValue('reinforced')
  reinforced, // Maintained after review
}

/// Tracks mastery of a specific skill using spaced repetition.
/// Based on modified SM-2 algorithm adapted for children.
@freezed
class MasteryRecord with _$MasteryRecord {
  const factory MasteryRecord({
    /// The skill being tracked (e.g., 'letter_alif', 'word_arnab').
    required String skillId,

    /// Current mastery level.
    @Default(MasteryLevel.newSkill) MasteryLevel level,

    /// Number of successful consecutive recalls.
    @Default(0) int consecutiveCorrect,

    /// Last time this skill was practiced.
    required DateTime lastPracticed,

    /// Calculated next review date (SM-2 interval).
    required DateTime nextReview,

    /// Current ease factor for SM-2 (default 2.5).
    @Default(2.5) double easeFactor,

    /// Current interval in days.
    @Default(1) int intervalDays,
  }) = _MasteryRecord;

  factory MasteryRecord.fromJson(Map<String, dynamic> json) =>
      _$MasteryRecordFromJson(json);
}

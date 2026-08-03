import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_progress.freezed.dart';
part 'lesson_progress.g.dart';

/// Status of a lesson's completion.
enum LessonStatus {
  @JsonValue('locked')
  locked,
  @JsonValue('available')
  available,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('mastered')
  mastered,
}

/// Tracks a child's progress through a specific lesson.
@freezed
class LessonProgress with _$LessonProgress {
  const factory LessonProgress({
    /// Unique lesson identifier (e.g., 'unit1_lesson3').
    required String lessonId,

    /// Current status of the lesson.
    @Default(LessonStatus.locked) LessonStatus status,

    /// Number of times the child has attempted this lesson.
    @Default(0) int attempts,

    /// Best score achieved (0-100).
    @Default(0) int bestScore,

    /// Total stars earned (0-3) based on performance.
    @Default(0) int starsEarned,

    /// When the lesson was completed (null if not yet completed).
    DateTime? completedAt,

    /// XP awarded for this lesson.
    @Default(0) int xpEarned,
  }) = _LessonProgress;

  factory LessonProgress.fromJson(Map<String, dynamic> json) =>
      _$LessonProgressFromJson(json);
}

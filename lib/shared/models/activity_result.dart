import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_result.freezed.dart';
part 'activity_result.g.dart';

/// Types of learning activities in Faseeh Kids.
enum ActivityType {
  @JsonValue('phoneme_listen')
  phonemeListen,
  @JsonValue('letter_trace')
  letterTrace,
  @JsonValue('letter_match')
  letterMatch,
  @JsonValue('word_build')
  wordBuild,
  @JsonValue('picture_pick')
  picturePick,
  @JsonValue('diacritics_sort')
  diacriticsSort,
  @JsonValue('sentence_order')
  sentenceOrder,
  @JsonValue('story_listen')
  storyListen,
  @JsonValue('fill_blank')
  fillBlank,
  @JsonValue('record_speak')
  recordSpeak,
  @JsonValue('drag_drop')
  dragDrop,
  @JsonValue('color_letter')
  colorLetter,
}

/// Records the result of a single activity attempt.
@freezed
class ActivityResult with _$ActivityResult {
  const factory ActivityResult({
    /// Unique activity identifier.
    required String activityId,

    /// Type of activity completed.
    required ActivityType type,

    /// Whether the activity was answered correctly.
    required bool correct,

    /// Time spent on the activity in milliseconds.
    required int timeSpentMs,

    /// Number of attempts before success (or giving up).
    @Default(1) int attempts,

    /// Timestamp of the activity completion.
    required DateTime completedAt,

    /// The letter or skill this activity targets.
    String? targetLetter,

    /// Hint count used during this activity.
    @Default(0) int hintsUsed,
  }) = _ActivityResult;

  factory ActivityResult.fromJson(Map<String, dynamic> json) =>
      _$ActivityResultFromJson(json);
}

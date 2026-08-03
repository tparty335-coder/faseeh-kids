import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_progress.freezed.dart';
part 'story_progress.g.dart';

/// Story progress model — tracks reading progress for interactive stories
@freezed
class StoryProgress with _$StoryProgress {
  const factory StoryProgress({
    /// Unique story identifier
    required String storyId,

    /// Current page index (0-based)
    @Default(0) int currentPage,

    /// Whether the story has been fully read
    @Default(false) bool isCompleted,

    /// Last time the story was read
    DateTime? lastRead,
  }) = _StoryProgress;

  factory StoryProgress.fromJson(Map<String, dynamic> json) =>
      _$StoryProgressFromJson(json);
}

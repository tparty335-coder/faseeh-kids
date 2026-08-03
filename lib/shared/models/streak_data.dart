import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_data.freezed.dart';
part 'streak_data.g.dart';

/// Tracks the child's daily learning streak for motivation.
@freezed
class StreakData with _$StreakData {
  const factory StreakData({
    /// Number of consecutive days with at least one lesson completed.
    @Default(0) int currentStreak,

    /// Longest streak ever achieved.
    @Default(0) int longestStreak,

    /// Last date the child was active (completed at least one activity).
    required DateTime lastActiveDate,

    /// Total number of days the child has been active.
    @Default(0) int totalActiveDays,

    /// Whether today's activity has been completed (prevents double counting).
    @Default(false) bool todayCompleted,
  }) = _StreakData;

  factory StreakData.fromJson(Map<String, dynamic> json) =>
      _$StreakDataFromJson(json);
}

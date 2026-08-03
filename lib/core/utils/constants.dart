/// Faseeh Kids App-wide Constants
class AppConstants {
  AppConstants._();

  /// App name in Arabic
  static const String appName = 'فصيح الصغار';

  /// App name in English
  static const String appNameEn = 'Faseeh Kids';

  /// Mascot name
  static const String mascotName = 'فصيح';

  /// Mascot name in English
  static const String mascotNameEn = 'Faseeh';

  /// Maximum child profiles per device
  static const int maxChildProfiles = 5;

  /// Number of questions in placement test
  static const int placementTestQuestions = 10;

  /// Mastery threshold (85%) — letter is "mastered" above this
  static const double masteryThreshold = 0.85;

  /// Minimum activities before mastery can be evaluated
  static const int minActivitiesForMastery = 5;

  /// Session duration in minutes (by age group, see AgeGroup)
  static const int sessionDurationPreschool = 10;
  static const int sessionDurationEmerging = 15;
  static const int sessionDurationIndependent = 20;

  /// Touch target minimum size (by age group)
  static const double touchTargetPreschool = 64.0;
  static const double touchTargetEmerging = 52.0;
  static const double touchTargetIndependent = 48.0;

  /// Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 400);
  static const Duration animationSlow = Duration(milliseconds: 800);
  static const Duration celebrationDuration = Duration(seconds: 3);

  /// Hive box names
  static const String childProfileBox = 'child_profiles';
  static const String lessonProgressBox = 'lesson_progress';
  static const String activityResultBox = 'activity_results';
  static const String masteryRecordBox = 'mastery_records';
  static const String streakDataBox = 'streak_data';
  static const String storyProgressBox = 'story_progress';
  static const String parentSettingsBox = 'parent_settings';
  static const String syncQueueBox = 'sync_queue';
}

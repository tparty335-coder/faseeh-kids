import 'package:hive/hive.dart';
import 'package:faseeh_kids/core/utils/constants.dart';

/// Hive Box Accessor
/// Provides typed access to all Hive boxes used in the app
class HiveBoxes {
  HiveBoxes._();

  /// Child profile data
  static Box get childProfile => Hive.box(AppConstants.childProfileBox);

  /// Lesson progress tracking
  static Box get lessonProgress => Hive.box(AppConstants.lessonProgressBox);

  /// Individual activity results
  static Box get activityResult => Hive.box(AppConstants.activityResultBox);

  /// Letter/skill mastery records
  static Box get masteryRecord => Hive.box(AppConstants.masteryRecordBox);

  /// Daily streak data
  static Box get streakData => Hive.box(AppConstants.streakDataBox);

  /// Story reading progress
  static Box get storyProgress => Hive.box(AppConstants.storyProgressBox);

  /// Parent settings and preferences
  static Box get parentSettings => Hive.box(AppConstants.parentSettingsBox);

  /// Offline sync queue
  static Box get syncQueue => Hive.box(AppConstants.syncQueueBox);
}

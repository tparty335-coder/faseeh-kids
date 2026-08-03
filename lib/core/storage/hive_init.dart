import 'package:hive_flutter/hive_flutter.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/core/storage/hive_adapters.dart';

/// Hive Database Initialization
/// Initializes Hive for Flutter and opens all required boxes
class HiveInit {
  HiveInit._();

  /// Initialize Hive and open all required boxes
  /// Must be called before runApp() in main.dart
  static Future<void> init() async {
    // Initialize Hive for Flutter (handles path setup)
    await Hive.initFlutter();

    // Register type adapters (Phase 2: Data Models)
    _registerAdapters();

    // Open all boxes
    await _openBoxes();
  }

  /// Register all Hive TypeAdapters
  static void _registerAdapters() {
    Hive.registerAdapter(ChildProfileAdapter());       // TypeId 0
    Hive.registerAdapter(LessonProgressAdapter());     // TypeId 1
    Hive.registerAdapter(ActivityResultAdapter());     // TypeId 2
    Hive.registerAdapter(MasteryRecordAdapter());      // TypeId 3
    Hive.registerAdapter(StreakDataAdapter());          // TypeId 4
    Hive.registerAdapter(StoryProgressAdapter());      // TypeId 5
    Hive.registerAdapter(ParentSettingsAdapter());     // TypeId 6
    Hive.registerAdapter(SyncQueueItemAdapter());      // TypeId 7
  }

  /// Open all Hive boxes used by the app
  static Future<void> _openBoxes() async {
    await Future.wait([
      Hive.openBox(AppConstants.childProfileBox),
      Hive.openBox(AppConstants.lessonProgressBox),
      Hive.openBox(AppConstants.activityResultBox),
      Hive.openBox(AppConstants.masteryRecordBox),
      Hive.openBox(AppConstants.streakDataBox),
      Hive.openBox(AppConstants.storyProgressBox),
      Hive.openBox(AppConstants.parentSettingsBox),
      Hive.openBox(AppConstants.syncQueueBox),
    ]);
  }

  /// Close all Hive boxes (for cleanup)
  static Future<void> close() async {
    await Hive.close();
  }
}

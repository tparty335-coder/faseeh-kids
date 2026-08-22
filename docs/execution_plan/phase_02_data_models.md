# Phase 2: نماذج البيانات (Data Models)

### P2-T001: Create ChildProfile model
- **الوصف:** Create `lib/shared/models/child_profile.dart` — @freezed class ChildProfile with fields: String id, String name, int avatarIndex, String ageGroup, DateTime createdAt, String currentUnit, int totalXP. Include fromJson/toJson.
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** child_profile.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T002: Create LessonProgress model
- **الوصف:** Create `lib/shared/models/lesson_progress.dart` — @freezed class with: String lessonId, String status (locked/unlocked/completed), int attempts, int bestScore, DateTime? completedAt
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** lesson_progress.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T003: Create ActivityResult model
- **الوصف:** Create `lib/shared/models/activity_result.dart` — @freezed class with: String activityId, String type, bool correct, int timeSpent, int attempts
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** activity_result.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T004: Create MasteryRecord model
- **الوصف:** Create `lib/shared/models/mastery_record.dart` — @freezed class with: String skillId, int level (0-5), DateTime lastPracticed, DateTime nextReview
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** mastery_record.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T005: Create StreakData model
- **الوصف:** Create `lib/shared/models/streak_data.dart` — @freezed class with: int currentStreak, int longestStreak, DateTime lastActiveDate
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** streak_data.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T006: Create StoryProgress model
- **الوصف:** Create `lib/shared/models/story_progress.dart` — @freezed class with: String storyId, int currentPage, bool isCompleted, DateTime? lastRead
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** story_progress.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T007: Create ParentSettings model
- **الوصف:** Create `lib/shared/models/parent_settings.dart` — @freezed class with: String parentId, bool soundEnabled, bool bgmEnabled, int dailyLimitMinutes, String? pinHash
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** parent_settings.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T008: Create SyncQueueItem model
- **الوصف:** Create `lib/shared/models/sync_queue_item.dart` — @freezed class with: String id, String collection, String documentId, Map<String,dynamic> data, DateTime timestamp, bool synced
- **المدخلات:** lib/shared/models/ exists
- **المخرجات:** sync_queue_item.dart
- **التحقق:** File exists with @freezed annotation
- **الحالة:** ☐

### P2-T009: Run build_runner
- **الوصف:** Run `dart run build_runner build --delete-conflicting-outputs` — generate .freezed.dart and .g.dart files
- **المدخلات:** Models created
- **المخرجات:** Generated files
- **التحقق:** Command succeeds
- **الحالة:** ☐

### P2-T010: Verify generated files
- **الوصف:** Verify all generated files exist with no errors
- **المدخلات:** P2-T009 completed
- **المخرجات:** Verification
- **التحقق:** .freezed.dart and .g.dart files exist for all models
- **الحالة:** ☐

### P2-T011: Create Hive TypeAdapters
- **الوصف:** Create Hive TypeAdapters for each model (or use hive_generator)
- **المدخلات:** Models generated
- **المخرجات:** TypeAdapters
- **التحقق:** Adapters exist
- **الحالة:** ☐

### P2-T012: Register Adapters
- **الوصف:** Register all adapters in `hive_init.dart`
- **المدخلات:** P2-T011 completed
- **المخرجات:** Updated hive_init.dart
- **التحقق:** File contains registerAdapter calls
- **الحالة:** ☐

### P2-T013: Run flutter analyze
- **الوصف:** Run `flutter analyze` — 0 issues
- **المدخلات:** All Phase 2 code written
- **المخرجات:** Analysis report
- **التحقق:** 0 issues found
- **الحالة:** ☐

### P2-T014: Create models barrel file
- **الوصف:** Create `lib/shared/models/models.dart` barrel file exporting all models
- **المدخلات:** All models created
- **المخرجات:** models.dart file
- **التحقق:** File exists and exports all models
- **الحالة:** ☐

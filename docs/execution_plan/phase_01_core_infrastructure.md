# Phase 1: البنية التحتية الأساسية (Core Infrastructure)

### P1-T001: Create AppColors (Day Mode)
- **الوصف:** Create `lib/core/theme/app_colors.dart` — define class `AppColors` with static const for Day Mode: primary=#FFB347, secondary=#42A5F5, accent=#81C784, background=#FFF9E6, surface=#FFFFFF, textPrimary=#212121, textSecondary=#757575, success=#4CAF50, error=#F44336, warning=#FFC107, disabled=#E0E0E0, border=#EEEEEE
- **المدخلات:** lib/core/theme/ exists
- **المخرجات:** app_colors.dart file
- **التحقق:** File exists and contains Day Mode colors
- **الحالة:** ☐

### P1-T002: Add AppColors (Night Mode)
- **الوصف:** In same file, add Night Mode colors: primary=#D98C2E, secondary=#1E88E5, accent=#66BB6A, background=#121212, surface=#1E1E1E, textPrimary=#F5F5F5, textSecondary=#BDBDBD, success=#388E3C, error=#D32F2F, warning=#FFA000, disabled=#424242, border=#333333
- **المدخلات:** P1-T001 completed
- **المخرجات:** Updated app_colors.dart
- **التحقق:** File contains Night Mode colors
- **الحالة:** ☐

### P1-T003: Create AppTypography
- **الوصف:** Create `lib/core/theme/app_typography.dart` — define text styles using Cairo font for UI, sizes: h1=32(age3-5)/28(age6-10), h2=24/22, body=20/16, button=18/16, caption=14/12
- **المدخلات:** lib/core/theme/ exists
- **المخرجات:** app_typography.dart file
- **التحقق:** File exists and contains text styles
- **الحالة:** ☐

### P1-T004: Create AppTheme
- **الوصف:** Create `lib/core/theme/app_theme.dart` — build ThemeData for day and night modes using AppColors and AppTypography, set RTL as default
- **المدخلات:** P1-T001 to P1-T003 completed
- **المخرجات:** app_theme.dart file
- **التحقق:** File exists and contains ThemeData
- **الحالة:** ☐

### P1-T005: Create AppRouter
- **الوصف:** Create `lib/core/router/app_router.dart` — define GoRouter with initial route '/', routes for: splash, onboarding, ageSelection, avatarSelection, placementTest, homeMap, lesson, activity, celebration, parentGate, parentDashboard, settings, profileManagement, rewardsStore
- **المدخلات:** lib/core/router/ exists
- **المخرجات:** app_router.dart file
- **التحقق:** File exists and contains GoRouter config
- **الحالة:** ☐

### P1-T006: Create Hive Initialization
- **الوصف:** Create `lib/core/storage/hive_init.dart` — function `initHive()` that initializes Hive and registers all adapters
- **المدخلات:** lib/core/storage/ exists
- **المخرجات:** hive_init.dart file
- **التحقق:** File exists and contains initHive()
- **الحالة:** ☐

### P1-T007: Create Hive Boxes
- **الوصف:** Create `lib/core/storage/hive_boxes.dart` — define box names as constants: childProfileBox, lessonProgressBox, activityResultBox, masteryRecordBox, streakDataBox, storyProgressBox, parentSettingsBox, syncQueueBox
- **المدخلات:** lib/core/storage/ exists
- **المخرجات:** hive_boxes.dart file
- **التحقق:** File exists and contains box constants
- **الحالة:** ☐

### P1-T008: Create ConnectivityService
- **الوصف:** Create `lib/core/network/connectivity_service.dart` — simple connectivity checker using dart:io InternetAddress.lookup
- **المدخلات:** lib/core/network/ exists
- **المخرجات:** connectivity_service.dart file
- **التحقق:** File exists and contains ConnectivityService class
- **الحالة:** ☐

### P1-T009: Create Constants
- **الوصف:** Create `lib/core/utils/constants.dart` — define app-wide constants: appName, mascotName='فصيح', maxChildProfiles=5, placementTestQuestions=10, masteryThreshold=0.85
- **المدخلات:** lib/core/utils/ exists
- **المخرجات:** constants.dart file
- **التحقق:** File exists and contains constants
- **الحالة:** ☐

### P1-T010: Create AgeGroup Enum
- **الوصف:** Create `lib/core/utils/age_group.dart` — enum AgeGroup { preschool3to5, emerging6to8, independent9to10 } with helper methods for sessionDuration, activityCount, touchTargetSize
- **المدخلات:** lib/core/utils/ exists
- **المخرجات:** age_group.dart file
- **التحقق:** File exists and contains AgeGroup enum
- **الحالة:** ☐

### P1-T011: Update main.dart
- **الوصف:** Update `lib/main.dart` — wrap app in ProviderScope, initialize Hive, apply AppTheme, set GoRouter, set Directionality to RTL
- **المدخلات:** P1-T004, P1-T005, P1-T006 completed
- **المخرجات:** Updated main.dart
- **التحقق:** Check main.dart for ProviderScope, AppTheme, GoRouter, RTL
- **الحالة:** ☐

### P1-T012: Run flutter analyze
- **الوصف:** Run `flutter analyze` — verify 0 issues
- **المدخلات:** Phase 1 code completed
- **المخرجات:** Analysis report
- **التحقق:** 0 issues found
- **الحالة:** ☐

### P1-T013: Run flutter build
- **الوصف:** Run `flutter build apk --debug` — verify successful build
- **المدخلات:** P1-T012 completed
- **المخرجات:** debug APK
- **التحقق:** build succeeds
- **الحالة:** ☐

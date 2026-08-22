# Phase 0: تأسيس المشروع (Project Foundation)

### P0-T001: Create Flutter Project
- **الوصف:** Run `flutter create --org com.faseeh faseeh_kids` (or verify existing project)
- **المدخلات:** None
- **المخرجات:** New Flutter project structure
- **التحقق:** `flutter --version` and project folder exists
- **الحالة:** ☐

### P0-T002: Set minSdkVersion
- **الوصف:** Set `minSdkVersion` to 21 in android/app/build.gradle
- **المدخلات:** Project created
- **المخرجات:** Updated build.gradle
- **التحقق:** Check android/app/build.gradle for `minSdkVersion 21`
- **الحالة:** ☐

### P0-T003: Set targetSdkVersion
- **الوصف:** Set `targetSdkVersion` to 34
- **المدخلات:** P0-T002 completed
- **المخرجات:** Updated build.gradle
- **التحقق:** Check android/app/build.gradle for `targetSdkVersion 34`
- **الحالة:** ☐

### P0-T004: Set applicationId
- **الوصف:** Set `applicationId` to `com.faseeh.kids`
- **المدخلات:** P0-T003 completed
- **المخرجات:** Updated build.gradle
- **التحقق:** Check android/app/build.gradle for `applicationId "com.faseeh.kids"`
- **الحالة:** ☐

### P0-T005: Add flutter_riverpod dependency
- **الوصف:** Add `flutter_riverpod: ^2.4.9` to pubspec.yaml dependencies
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T006: Add Hive dependencies
- **الوصف:** Add `hive: ^2.2.3` and `hive_flutter: ^2.0.1`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependencies
- **الحالة:** ☐

### P0-T007: Add go_router dependency
- **الوصف:** Add `go_router: ^13.1.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T008: Add audioplayers dependency
- **الوصف:** Add `audioplayers: ^5.2.1`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T009: Add google_fonts dependency
- **الوصف:** Add `google_fonts: ^6.1.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T010: Add flutter_animate dependency
- **الوصف:** Add `flutter_animate: ^4.2.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T011: Add flutter_tts dependency
- **الوصف:** Add `flutter_tts: ^3.8.3`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T012: Add confetti dependency
- **الوصف:** Add `confetti: ^0.7.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T013: Add flutter_svg dependency
- **الوصف:** Add `flutter_svg: ^2.0.9`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T014: Add share_plus dependency
- **الوصف:** Add `share_plus: ^7.2.1`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T015: Add path_drawing dependency
- **الوصف:** Add `path_drawing: ^1.0.1`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T016: Add intl dependency
- **الوصف:** Add `intl: ^0.19.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T017: Add freezed dependencies
- **الوصف:** Add `freezed_annotation: ^2.4.1` to dependencies, `freezed: ^2.4.7` and `build_runner: ^2.4.8` to dev_dependencies
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependencies
- **الحالة:** ☐

### P0-T018: Add firebase_core dependency
- **الوصف:** Add `firebase_core: ^2.24.2`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T019: Add firebase_auth dependency
- **الوصف:** Add `firebase_auth: ^4.16.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T020: Add cloud_firestore dependency
- **الوصف:** Add `cloud_firestore: ^4.14.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T021: Add firebase_analytics dependency
- **الوصف:** Add `firebase_analytics: ^10.8.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T022: Add firebase_crashlytics dependency
- **الوصف:** Add `firebase_crashlytics: ^3.4.9`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T023: Add shimmer dependency
- **الوصف:** Add `shimmer: ^3.0.0`
- **المدخلات:** pubspec.yaml exists
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** Check pubspec.yaml for dependency
- **الحالة:** ☐

### P0-T024: Run flutter pub get
- **الوصف:** Run `flutter pub get` and verify no errors
- **المدخلات:** Dependencies added to pubspec.yaml
- **المخرجات:** Packages downloaded
- **التحقق:** `flutter pub get` runs successfully
- **الحالة:** ☐

### P0-T025: Create directory core
- **الوصف:** Create directory `lib/core/`
- **المدخلات:** lib folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T026: Create directory theme
- **الوصف:** Create directory `lib/core/theme/`
- **المدخلات:** lib/core/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T027: Create directory router
- **الوصف:** Create directory `lib/core/router/`
- **المدخلات:** lib/core/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T028: Create directory storage
- **الوصف:** Create directory `lib/core/storage/`
- **المدخلات:** lib/core/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T029: Create directory network
- **الوصف:** Create directory `lib/core/network/`
- **المدخلات:** lib/core/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T030: Create directory utils
- **الوصف:** Create directory `lib/core/utils/`
- **المدخلات:** lib/core/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T031: Create directory features
- **الوصف:** Create directory `lib/features/`
- **المدخلات:** lib folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T032: Create directory auth
- **الوصف:** Create directory `lib/features/auth/`
- **المدخلات:** lib/features/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T033: Create directory onboarding
- **الوصف:** Create directory `lib/features/onboarding/`
- **المدخلات:** lib/features/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T034: Create directory home
- **الوصف:** Create directory `lib/features/home/`
- **المدخلات:** lib/features/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T035: Create directory lessons
- **الوصف:** Create directory `lib/features/lessons/`
- **المدخلات:** lib/features/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T036: Create directory stories
- **الوصف:** Create directory `lib/features/stories/`
- **المدخلات:** lib/features/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T037: Create directory parent_dashboard
- **الوصف:** Create directory `lib/features/parent_dashboard/`
- **المدخلات:** lib/features/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T038: Create directory rewards
- **الوصف:** Create directory `lib/features/rewards/`
- **المدخلات:** lib/features/ folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T039: Create directory shared widgets
- **الوصف:** Create directory `lib/shared/widgets/`
- **المدخلات:** lib folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T040: Create directory shared models
- **الوصف:** Create directory `lib/shared/models/`
- **المدخلات:** lib folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T041: Create directory services
- **الوصف:** Create directory `lib/services/`
- **المدخلات:** lib folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T042: Create directory l10n
- **الوصف:** Create directory `lib/l10n/`
- **المدخلات:** lib folder exists
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T043: Create directory assets audio letters
- **الوصف:** Create directory `assets/audio/letters/`
- **المدخلات:** Project root
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T044: Create directory assets audio words
- **الوصف:** Create directory `assets/audio/words/`
- **المدخلات:** Project root
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T045: Create directory assets audio stories
- **الوصف:** Create directory `assets/audio/stories/`
- **المدخلات:** Project root
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T046: Create directory assets audio feedback
- **الوصف:** Create directory `assets/audio/feedback/`
- **المدخلات:** Project root
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T047: Create directory assets audio sfx
- **الوصف:** Create directory `assets/audio/sfx/`
- **المدخلات:** Project root
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T048: Create directory assets images
- **الوصف:** Create directory `assets/images/`
- **المدخلات:** Project root
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T049: Create directory assets animations
- **الوصف:** Create directory `assets/animations/`
- **المدخلات:** Project root
- **المخرجات:** New directory
- **التحقق:** Directory exists
- **الحالة:** ☐

### P0-T050: Update pubspec assets
- **الوصف:** Add all asset directories to pubspec.yaml under `flutter: assets:`
- **المدخلات:** Asset directories created
- **المخرجات:** Updated pubspec.yaml
- **التحقق:** pubspec.yaml contains asset paths
- **الحالة:** ☐

### P0-T051: Verify build
- **الوصف:** Run `flutter pub get` and verify clean build
- **المدخلات:** All phase 0 tasks completed
- **المخرجات:** Clean build state
- **التحقق:** `flutter pub get` runs successfully
- **الحالة:** ☐

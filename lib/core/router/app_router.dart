import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

// ─── Onboarding Screens ───
import 'package:faseeh_kids/features/onboarding/screens/splash_screen.dart';
import 'package:faseeh_kids/features/onboarding/screens/onboarding_screen.dart';
import 'package:faseeh_kids/features/onboarding/screens/age_selection_screen.dart';
import 'package:faseeh_kids/features/onboarding/screens/avatar_selection_screen.dart';
import 'package:faseeh_kids/features/onboarding/screens/name_input_screen.dart';
import 'package:faseeh_kids/features/onboarding/screens/placement_test_screen.dart';

// ─── Home / Oasis Map ───
import 'package:faseeh_kids/features/home/screens/oasis_map_screen.dart';

// ─── Lessons ───
import 'package:faseeh_kids/features/lessons/screens/letter_lesson_screen.dart';

// ─── Rewards & Profile ───
import 'package:faseeh_kids/features/rewards/screens/celebration_screen.dart';
import 'package:faseeh_kids/features/rewards/screens/rewards_store_screen.dart';
import 'package:faseeh_kids/features/rewards/screens/profile_screen.dart';

// ─── Parent Dashboard ───
import 'package:faseeh_kids/features/parent_dashboard/screens/parent_gate_screen.dart';
import 'package:faseeh_kids/features/parent_dashboard/screens/parent_dashboard_screen.dart';
import 'package:faseeh_kids/features/parent_dashboard/screens/progress_report_screen.dart';

// ─── Stories ───
import 'package:faseeh_kids/features/stories/screens/story_reader_screen.dart';

/// Faseeh Kids App Router
/// Defines all navigation routes using GoRouter
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// Route path constants
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String ageSelection = '/age-selection';
  static const String avatarSelection = '/avatar-selection';
  static const String nameInput = '/name-input';
  static const String placementTest = '/placement-test';
  static const String homeMap = '/home';
  static const String lesson = '/lesson/:lessonId';
  static const String activity = '/activity/:activityId';
  static const String celebration = '/celebration';
  static const String parentGate = '/parent-gate';
  static const String parentDashboard = '/parent-dashboard';
  static const String progressReport = '/progress-report';
  static const String settings = '/settings';
  static const String profileManagement = '/profile-management';
  static const String rewardsStore = '/rewards-store';
  static const String profile = '/profile';
  static const String storyReader = '/story/:storyId';
  static const String letterExplorer = '/letter/:letterId';

  /// Custom slide transition (RTL aware)
  static CustomTransitionPage<void> _slideTransition({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide from left for RTL
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.fastOutSlowIn));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Scale-up transition for celebrations
  static CustomTransitionPage<void> _scaleTransition({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation.drive(
            Tween(begin: 0.8, end: 1.0)
                .chain(CurveTween(curve: Curves.easeOutBack)),
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  /// The GoRouter configuration
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      // ─── Onboarding Flow ───
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: ageSelection,
        name: 'ageSelection',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const AgeSelectionScreen(),
        ),
      ),
      GoRoute(
        path: avatarSelection,
        name: 'avatarSelection',
        pageBuilder: (context, state) {
          final ageGroup = state.extra as AgeGroup? ?? AgeGroup.preschool3to5;
          return _slideTransition(
            state: state,
            child: AvatarSelectionScreen(ageGroup: ageGroup),
          );
        },
      ),
      GoRoute(
        path: nameInput,
        name: 'nameInput',
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};
          return _slideTransition(
            state: state,
            child: NameInputScreen(
              ageGroup: data['ageGroup'] as AgeGroup? ?? AgeGroup.preschool3to5,
              avatarIndex: data['avatarIndex'] as int? ?? 0,
            ),
          );
        },
      ),
      GoRoute(
        path: placementTest,
        name: 'placementTest',
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};
          return _slideTransition(
            state: state,
            child: PlacementTestScreen(
              ageGroup: data['ageGroup'] as AgeGroup? ?? AgeGroup.preschool3to5,
              avatarIndex: data['avatarIndex'] as int? ?? 0,
              childName: data['name'] as String? ?? 'طفل',
            ),
          );
        },
      ),

      // ─── Main App: Oasis Map (Home) ───
      GoRoute(
        path: homeMap,
        name: 'homeMap',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const OasisMapScreen(),
        ),
      ),

      // ─── Lessons ───
      GoRoute(
        path: lesson,
        name: 'lesson',
        pageBuilder: (context, state) {
          return _slideTransition(
            state: state,
            child: const LetterLessonScreen(),
          );
        },
      ),

      // ─── Celebration ───
      GoRoute(
        path: celebration,
        name: 'celebration',
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};
          return _scaleTransition(
            state: state,
            child: CelebrationScreen(
              stars: data['stars'] as int? ?? 3,
              xpEarned: data['xpEarned'] as int? ?? 20,
              badgeIcon: data['badgeIcon'] as String?,
            ),
          );
        },
      ),

      // ─── Parent Gate & Dashboard ───
      GoRoute(
        path: parentGate,
        name: 'parentGate',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const ParentGateScreen(),
        ),
      ),
      GoRoute(
        path: parentDashboard,
        name: 'parentDashboard',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const ParentDashboardScreen(),
        ),
      ),
      GoRoute(
        path: progressReport,
        name: 'progressReport',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const ProgressReportScreen(),
        ),
      ),

      // ─── Profile & Rewards ───
      GoRoute(
        path: profile,
        name: 'profile',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: rewardsStore,
        name: 'rewardsStore',
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const RewardsStoreScreen(),
        ),
      ),

      // ─── Stories ───
      GoRoute(
        path: storyReader,
        name: 'storyReader',
        pageBuilder: (context, state) {
          final storyId = state.pathParameters['storyId'] ?? 'story_01';
          return _slideTransition(
            state: state,
            child: StoryReaderScreen(storyId: storyId),
          );
        },
      ),

      // ─── Letter Explorer (uses lesson screen with specific letter) ───
      GoRoute(
        path: letterExplorer,
        name: 'letterExplorer',
        pageBuilder: (context, state) {
          return _slideTransition(
            state: state,
            child: const LetterLessonScreen(),
          );
        },
      ),
    ],
  );
}

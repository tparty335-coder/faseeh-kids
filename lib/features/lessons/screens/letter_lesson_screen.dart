import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/screens/listen_activity_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/trace_activity_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/words_activity_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/positions_activity_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/long_vowels_activity_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/phrases_activity_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/quiz_activity_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';

class LetterLessonScreen extends ConsumerWidget {
  const LetterLessonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطأ')),
        body: const Center(child: Text('لم يتم اختيار حرف')),
      );
    }

    final progress = ref.watch(lessonProgressProvider);
    final key = AudioRegistry.letterKeyFromChar(letter.letter);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.creamBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.desertSand),
            onPressed: () => context.pop(),
          ),
          actions: [
            // 🏠 Home Button — Fix #4
            IconButton(
              icon: const Icon(Icons.home_rounded, color: AppColors.desertSand, size: 28),
              tooltip: 'الرئيسية',
              onPressed: () => context.go(AppRouter.homeMap),
            ),
          ],
          title: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    backgroundColor: AppColors.desertSand.withValues(alpha: 0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.oasisGreen),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${lessonState.completedActivities}/${LessonActivity.values.length}',
                style: const TextStyle(
                  color: AppColors.desertSand,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    letter.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.desertSand,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.skyBlue.withValues(alpha: 0.2),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.volume_up, color: AppColors.skyBlue, size: 32),
                      onPressed: () {
                        // Fix #1: Use playLetterAudio instead of speakText
                        AudioManager.instance.playLetterAudio(key, 'name');
                      },
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            ),
            
            // Activity Area
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _buildActivityScreen(lessonState.currentActivity),
              ),
            ),
            
            // Bottom Activity Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ActivityButton(
                      iconData: Icons.volume_up_rounded,
                      label: 'استمع',
                      isActive: lessonState.currentActivity == LessonActivity.listen,
                      isCompleted: lessonState.completedActivities > 0,
                      onTap: () => ref.read(currentLessonProvider.notifier).setActivity(LessonActivity.listen),
                    ),
                    const SizedBox(width: 8),
                    _ActivityButton(
                      iconData: Icons.edit_rounded,
                      label: 'اكتب',
                      isActive: lessonState.currentActivity == LessonActivity.trace,
                      isCompleted: lessonState.completedActivities > 1,
                      onTap: () => ref.read(currentLessonProvider.notifier).setActivity(LessonActivity.trace),
                    ),
                    const SizedBox(width: 8),
                    _ActivityButton(
                      iconData: Icons.auto_stories_rounded,
                      label: 'كلمات',
                      isActive: lessonState.currentActivity == LessonActivity.words,
                      isCompleted: lessonState.completedActivities > 2,
                      onTap: () => ref.read(currentLessonProvider.notifier).setActivity(LessonActivity.words),
                    ),
                    const SizedBox(width: 8),
                    _ActivityButton(
                      iconData: Icons.text_rotation_none_rounded,
                      label: 'أوضاع',
                      isActive: lessonState.currentActivity == LessonActivity.positions,
                      isCompleted: lessonState.completedActivities > 3,
                      onTap: () => ref.read(currentLessonProvider.notifier).setActivity(LessonActivity.positions),
                    ),
                    const SizedBox(width: 8),
                    _ActivityButton(
                      iconData: Icons.straighten_rounded,
                      label: 'مدود',
                      isActive: lessonState.currentActivity == LessonActivity.longVowels,
                      isCompleted: lessonState.completedActivities > 4,
                      onTap: () => ref.read(currentLessonProvider.notifier).setActivity(LessonActivity.longVowels),
                    ),
                    const SizedBox(width: 8),
                    _ActivityButton(
                      iconData: Icons.format_quote_rounded,
                      label: 'جمل',
                      isActive: lessonState.currentActivity == LessonActivity.phrases,
                      isCompleted: lessonState.completedActivities > 5,
                      onTap: () => ref.read(currentLessonProvider.notifier).setActivity(LessonActivity.phrases),
                    ),
                    const SizedBox(width: 8),
                    _ActivityButton(
                      iconData: Icons.extension_rounded,
                      label: 'تمرين',
                      isActive: lessonState.currentActivity == LessonActivity.quiz,
                      isCompleted: lessonState.completedActivities > 6,
                      onTap: () => ref.read(currentLessonProvider.notifier).setActivity(LessonActivity.quiz),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityScreen(LessonActivity activity) {
    switch (activity) {
      case LessonActivity.listen:
        return const ListenActivityScreen();
      case LessonActivity.trace:
        return const TraceActivityScreen();
      case LessonActivity.words:
        return const WordsActivityScreen();
      case LessonActivity.positions:
        return const PositionsActivityScreen();
      case LessonActivity.longVowels:
        return const LongVowelsActivityScreen();
      case LessonActivity.phrases:
        return const PhrasesActivityScreen();
      case LessonActivity.quiz:
        return const QuizActivityScreen();
    }
  }
}

class _ActivityButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool isActive;
  final bool isCompleted;
  final VoidCallback onTap;

  const _ActivityButton({
    required this.iconData,
    required this.label,
    required this.isActive,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.desertSand : (isCompleted ? AppColors.oasisGreen : Colors.grey);
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isActive ? Border.all(color: color, width: 2) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: color, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ).animate(target: isActive ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 200.ms, curve: Curves.elasticOut);
  }
}

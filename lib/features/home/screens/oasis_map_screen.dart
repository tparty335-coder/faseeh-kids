import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';
import 'package:faseeh_kids/features/home/widgets/oasis_node.dart';
import 'package:faseeh_kids/features/home/widgets/bottom_nav_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';

class OasisMapScreen extends ConsumerWidget {
  const OasisMapScreen({super.key});

  final List<String> letters = const ['أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unlockedUnits = ref.watch(unlockedUnitsProvider);
    final currentUnit = ref.watch(currentUnitProvider);
    final currentIndex = ref.watch(homeNavIndexProvider);

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/backgrounds/desert_path_map.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.amber.withValues(alpha: 0.15),
                BlendMode.overlay,
              ),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Scrolling Map
                ListView.builder(
                  reverse: true, // Bottom-to-top scrolling
                  padding: const EdgeInsets.only(top: 100, bottom: 120),
                  itemCount: letters.length,
                  itemBuilder: (context, index) {
                    final letterChar = letters[index];
                    final isUnlocked = unlockedUnits.contains(letterChar);
                    final isCurrent = currentUnit == letterChar;
                    final isCompleted = isUnlocked && !isCurrent;
                    
                    NodeStatus status = NodeStatus.locked;
                    if (isCurrent) {
                      status = NodeStatus.current;
                    } else if (isCompleted) {
                      status = NodeStatus.completed;
                    }

                    // Curving path calculation
                    final double dx = (index % 2 == 0) ? 50.0 : -50.0;
                    
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Transform.translate(
                          offset: Offset(dx, 0),
                          child: OasisNode(
                            letter: letterChar,
                            status: status,
                            onTap: () {
                              if (status != NodeStatus.locked) {
                                final letterData = arabicLetters.firstWhere(
                                  (l) => l.letter == letterChar,
                                  orElse: () => arabicLetters.first,
                                );
                                ref.read(currentLessonProvider.notifier).setLetter(letterData);
                                AudioManager.instance.speakText('حرف ${letterData.name}');
                                context.push('/lesson/${letterData.letter}');
                              } else {
                                AudioManager.instance.playFeedback('try_again');
                              }
                            },
                          ).animate().fadeIn(delay: (index * 100).ms, duration: 500.ms).slideY(begin: 0.2, end: 0),
                        ),
                      ),
                    );
                  },
                ),
                
                // Top Progress Bar with Parent Gate Button
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.family_restroom, color: AppColors.desertSand),
                          tooltip: 'بوابة الآباء',
                          onPressed: () {
                            context.push(AppRouter.parentGate);
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'التقدم الكلي',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: unlockedUnits.length / letters.length,
                              minHeight: 12,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${((unlockedUnits.length / letters.length) * 100).toInt()}%',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: -1.0, end: 0, duration: 600.ms),
                ),
                
                // Bottom Navigation Bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: OasisBottomNavBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      ref.read(homeNavIndexProvider.notifier).state = index;
                      if (index == 1) {
                        context.push(AppRouter.rewardsStore);
                      } else if (index == 2) {
                        context.push('/story/rabbit_turtle');
                      } else if (index == 3) {
                        context.push(AppRouter.profile);
                      }
                    },
                  ).animate().slideY(begin: 1.0, end: 0, duration: 600.ms),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

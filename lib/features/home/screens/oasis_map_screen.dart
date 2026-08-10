import 'dart:math' as math;
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
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/core/providers/purchase_provider.dart';

class OasisMapScreen extends ConsumerWidget {
  const OasisMapScreen({super.key});

  // Dynamic: pull all 28 letters from the data source
  List<String> get letters => arabicLetters.map((l) => l.letter).toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unlockedUnits = ref.watch(unlockedUnitsProvider);
    final currentUnit = ref.watch(currentUnitProvider);
    final currentIndex = ref.watch(homeNavIndexProvider);

    final screenWidth = MediaQuery.sizeOf(context).width;
    const double nodeHeightStep = 110.0;
    final double totalMapHeight = letters.length * nodeHeightStep + 240.0;
    final double mapAmplitude = (screenWidth * 0.3).clamp(80.0, 160.0);

    // Calculate node coordinates along mathematical S-curve
    List<Offset> getNodePositions(double width) {
      final centerX = width / 2;
      return List.generate(letters.length, (index) {
        final y = totalMapHeight - (index * nodeHeightStep + 160.0);
        final x = centerX + math.sin(index * 0.75) * mapAmplitude;
        return Offset(x, y);
      });
    }

    final positions = getNodePositions(screenWidth);

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
                // Scrollable Geometrically-Mapped Oasis Path
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 80, bottom: 120),
                  child: SizedBox(
                    height: totalMapHeight,
                    width: screenWidth,
                    child: Stack(
                      children: [
                        // Custom Painter for the winding dashed desert road path
                        CustomPaint(
                          painter: _OasisPathPainter(
                            positions: positions,
                            unlockedCount: unlockedUnits.length,
                          ),
                          size: Size(screenWidth, totalMapHeight),
                        ),

                        // Render Oasis Nodes anchored at exact path coordinates
                        for (int index = 0; index < letters.length; index++) ...[
                          Builder(
                            builder: (context) {
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

                              final pos = positions[index];
                              final isAccessible = ref.watch(letterAccessProvider(index));

                              return Positioned(
                                left: pos.dx - 40.0, // Center 80px width node
                                top: pos.dy - 40.0,
                                child: OasisNode(
                                  letter: letterChar,
                                  status: status,
                                  isPremiumLocked: !isAccessible,
                                  onTap: () {
                                    if (status != NodeStatus.locked) {
                                      if (!isAccessible) {
                                        // Show paywall if not accessible
                                        context.push(AppRouter.paywall);
                                        return;
                                      }

                                      final letterData = arabicLetters.firstWhere(
                                        (l) => l.letter == letterChar,
                                        orElse: () => arabicLetters.first,
                                      );
                                      ref.read(currentLessonProvider.notifier).setLetter(letterData);
                                      final regKey = AudioRegistry.letterKeyFromChar(letterChar);
                                      AudioManager.instance.playLetterAudio(regKey, 'name');
                                      context.push('/lesson/${letterData.letter}');
                                    } else {
                                      AudioManager.instance.playFeedback('try_again');
                                    }
                                  },
                                ).animate().fadeIn(delay: (index * 60).ms, duration: 400.ms),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Top Progress Bar with Parent Gate Button
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
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

/// Custom Painter to draw smooth connecting curve between stage nodes
class _OasisPathPainter extends CustomPainter {
  final List<Offset> positions;
  final int unlockedCount;

  _OasisPathPainter({
    required this.positions,
    required this.unlockedCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.length < 2) return;

    final path = Path();
    path.moveTo(positions.first.dx, positions.first.dy);

    for (int i = 0; i < positions.length - 1; i++) {
      final p1 = positions[i];
      final p2 = positions[i + 1];
      final controlPointX = (p1.dx + p2.dx) / 2;
      final controlPointY = (p1.dy + p2.dy) / 2;

      path.quadraticBezierTo(p1.dx, p1.dy, controlPointX, controlPointY);
    }

    // Outer shadow / border path
    final borderPaint = Paint()
      ..color = Colors.brown.withValues(alpha: 0.25)
      ..strokeWidth = 14.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, borderPaint);

    // Inner desert road path
    final roadPaint = Paint()
      ..color = AppColors.desertSand.withValues(alpha: 0.6)
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, roadPaint);
  }

  @override
  bool shouldRepaint(covariant _OasisPathPainter oldDelegate) {
    return oldDelegate.positions != positions || oldDelegate.unlockedCount != unlockedCount;
  }
}


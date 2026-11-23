import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:faseeh_kids/core/providers/purchase_provider.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';
import 'package:faseeh_kids/features/assessment/data/assessment_curriculum_data.dart';
import 'package:faseeh_kids/features/assessment/logic/assessment_provider.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';
import 'package:faseeh_kids/features/home/widgets/bottom_nav_bar.dart';
import 'package:faseeh_kids/features/home/widgets/oasis_node.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';

/// عنصر واحد على خريطة الواحات: إما محطة حرف (١..٢٨) أو بوابة اختبار وحدة (بعد كل ٧ حروف)
class _OasisMapStep {
  final String? letterChar;
  final int? letterIndex;
  final int? checkpointUnitIndex; // 1..4 بعد كل ٧ حروف

  const _OasisMapStep.letter(this.letterChar, this.letterIndex)
      : checkpointUnitIndex = null;

  const _OasisMapStep.checkpoint(this.checkpointUnitIndex)
      : letterChar = null,
        letterIndex = null;

  bool get isCheckpoint => checkpointUnitIndex != null;
}

class OasisMapScreen extends ConsumerStatefulWidget {
  const OasisMapScreen({super.key});

  @override
  ConsumerState<OasisMapScreen> createState() => _OasisMapScreenState();
}

class _OasisMapScreenState extends ConsumerState<OasisMapScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> get letters => arabicLetters.map((l) => l.letter).toList();

  /// بناء خطوات الخريطة: ٢٨ حرفاً + ٤ بوابات قياس مستوى (بوابة بعد كل ٧ حروف) = ٣٢ محطة
  List<_OasisMapStep> get _mapSteps {
    final steps = <_OasisMapStep>[];
    final all = letters;
    for (int i = 0; i < all.length; i++) {
      steps.add(_OasisMapStep.letter(all[i], i));
      if ((i + 1) % 7 == 0) {
        steps.add(_OasisMapStep.checkpoint((i + 1) ~/ 7));
      }
    }
    return steps;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // Scroll to the bottom where letter Alif starts
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unlockedUnits = ref.watch(unlockedUnitsProvider);
    final currentUnit = ref.watch(currentUnitProvider);
    final currentIndex = ref.watch(homeNavIndexProvider);
    final diagnostics = ref.watch(assessmentDiagnosticsProvider);

    final screenWidth = context.screenWidth;
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final double nodeSize = (screenWidth * 0.18).clamp(64.0, 96.0);
    final double checkpointWidth = isCompact ? 156.0 : (context.isTablet ? 210.0 : 184.0);
    final double checkpointHeight = isCompact ? 62.0 : (context.isTablet ? 76.0 : 68.0);

    final steps = _mapSteps;
    final double nodeHeightStep = isCompact ? 112.0 : (context.isTablet ? 136.0 : 124.0);
    final double totalMapHeight = steps.length * nodeHeightStep + 340.0;
    final double mapAmplitude =
        (screenWidth * 0.25).clamp(62.0, context.isTablet ? 165.0 : 120.0);

    List<Offset> getStepPositions(double width) {
      final centerX = width / 2;
      return List.generate(steps.length, (index) {
        final step = steps[index];
        final y = totalMapHeight - (index * nodeHeightStep + 230.0);
        // بوابات قياس المستوى تتوسط الطريق بوضوح وبروز أنيق
        final x = step.isCheckpoint
            ? centerX
            : centerX + math.sin(index * 0.78) * mapAmplitude;
        return Offset(x, y);
      });
    }

    final positions = getStepPositions(screenWidth);
    final progressValue =
        letters.isEmpty ? 0.0 : (unlockedUnits.length / letters.length).clamp(0.0, 1.0);
    final prescription = diagnostics.buildPrescription();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgrounds/desert_path_map.webp'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // ── مسار الواحات القابل للتمرير (٢٨ حرفاً + ٤ بوابات قياس مستوى) ──
                  SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: isCompact ? 76 : 90,
                      bottom: isCompact ? 120 : 140,
                    ),
                    child: SizedBox(
                      height: totalMapHeight,
                      width: screenWidth,
                      child: Stack(
                        children: [
                          CustomPaint(
                            painter: _OasisPathPainter(
                              positions: positions,
                              unlockedCount: unlockedUnits.length,
                            ),
                            size: Size(screenWidth, totalMapHeight),
                          ),
                          for (int stepIdx = 0; stepIdx < steps.length; stepIdx++)
                            Builder(
                              builder: (context) {
                                final step = steps[stepIdx];
                                final pos = positions[stepIdx];

                                if (step.isCheckpoint) {
                                  final unitIdx = step.checkpointUnitIndex!;
                                  final unitSpec =
                                      AssessmentCurriculumData.unitByIndex(unitIdx);
                                  final unitRes = diagnostics.unitResults[unitIdx];
                                  return Positioned(
                                    left: (pos.dx - checkpointWidth / 2)
                                        .clamp(8.0, math.max(8.0, screenWidth - checkpointWidth - 8.0)),
                                    top: pos.dy - checkpointHeight / 2,
                                    child: _UnitCheckpointGate(
                                      unit: unitSpec,
                                      result: unitRes,
                                      width: checkpointWidth,
                                      height: checkpointHeight,
                                      compact: isCompact,
                                      onTap: () {
                                        HapticFeedback.mediumImpact();
                                        context.push(
                                          AppRouter.assessmentSession,
                                          extra: AssessmentSessionArgs(
                                            mode: AssessmentSessionMode.unitExam,
                                            unitIndex: unitSpec.unitIndex,
                                            targetLetters: unitSpec.letters,
                                            questionCount: 10,
                                            titleAr: 'اخْتِبَارُ ${unitSpec.titleAr}',
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }

                                final letterChar = step.letterChar!;
                                final letterIndex = step.letterIndex!;
                                final isUnlocked = unlockedUnits.contains(letterChar);
                                final isCurrent = currentUnit == letterChar;

                                NodeStatus status = NodeStatus.locked;
                                if (isCurrent) {
                                  status = NodeStatus.current;
                                } else if (isUnlocked) {
                                  status = NodeStatus.unlocked;
                                }

                                final isAccessible =
                                    ref.watch(letterAccessProvider(letterIndex));

                                return Positioned(
                                  left: pos.dx - nodeSize / 2,
                                  top: pos.dy - nodeSize / 2,
                                  child: OasisNode(
                                    letter: letterChar,
                                    status: status,
                                    isPremiumLocked: !isAccessible,
                                    onTap: () {
                                      if (status != NodeStatus.locked) {
                                        if (!isAccessible) {
                                          context.push(
                                            AppRouter.parentGate,
                                            extra: AppRouter.paywall,
                                          );
                                          return;
                                        }

                                        final letterData = arabicLetters.firstWhere(
                                          (l) => l.letter == letterChar,
                                          orElse: () => arabicLetters.first,
                                        );
                                        ref
                                            .read(currentLessonProvider.notifier)
                                            .setLetter(letterData);
                                        context.push('/lesson/${letterData.letter}');
                                      } else {
                                        AudioManager.instance.playFeedback('try_again');
                                      }
                                    },
                                  ).animate().fadeIn(
                                        delay: (math.min(stepIdx, 12) * 35).ms,
                                        duration: 320.ms,
                                      ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),

                  // ── الشريط العلوي المتجاوب (متوازن من 320dp حتى 960dp) ──
                  Positioned(
                    top: isCompact ? 8 : 12,
                    left: 0,
                    right: 0,
                    child: ResponsiveContentFrame(
                      maxWidth: 740,
                      padding: EdgeInsets.symmetric(horizontal: isCompact ? 10 : 16),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isCompact ? 10 : 14,
                          vertical: isCompact ? 7 : 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.96),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.desertSand.withValues(alpha: 0.55),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(
                                minWidth: isCompact ? 34 : 40,
                                minHeight: isCompact ? 34 : 40,
                              ),
                              icon: Icon(
                                Icons.family_restroom,
                                color: AppColors.desertSand,
                                size: isCompact ? 22 : 26,
                              ),
                              tooltip: 'بوابة الآباء',
                              onPressed: () {
                                context.push(AppRouter.parentGate);
                              },
                            ),
                            SizedBox(width: isCompact ? 4 : 8),
                            if (!context.isUltraCompact) ...[
                              Text(
                                'التَّقَدُّمُ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.scaledFont(14, min: 12, max: 16),
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(width: isCompact ? 6 : 10),
                            ],
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  minHeight: isCompact ? 10 : 12,
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    AppColors.success,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: isCompact ? 6 : 10),
                            Text(
                              '${(progressValue * 100).toInt()}%',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w900,
                                fontSize: context.scaledFont(13.5, min: 11.5, max: 16),
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(width: isCompact ? 6 : 10),
                            // زر الوصول السريع لمركز القياس وعيادة التقوية
                            Material(
                              color: prescription.hasDiagnosedWeaknesses
                                  ? const Color(0xFFEA580C)
                                  : const Color(0xFF0284C7),
                              borderRadius: BorderRadius.circular(14),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () => context.push(
                                  AppRouter.assessmentHub,
                                  extra: prescription.hasDiagnosedWeaknesses ? 1 : 0,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isCompact ? 8 : 12,
                                    vertical: isCompact ? 6 : 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        prescription.hasDiagnosedWeaknesses
                                            ? Icons.healing_rounded
                                            : Icons.quiz_rounded,
                                        color: Colors.white,
                                        size: isCompact ? 16 : 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        prescription.hasDiagnosedWeaknesses
                                            ? 'تَقْوِيَةٌ'
                                            : 'قِيَاسٌ',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: context.scaledFont(12, min: 10.5, max: 14),
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().slideY(begin: -0.6, end: 0, duration: 420.ms),
                    ),
                  ),

                  // ── شريط التنقل السفلي المتجاوب ──
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
                          context.push(AppRouter.assessmentHub);
                        } else if (index == 3) {
                          context.push(AppRouter.profile);
                        }
                      },
                    ).animate().slideY(begin: 0.8, end: 0, duration: 420.ms),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// بوابة اختبار قياس المستوى الذهبية بعد كل ٧ حروف على خريطة الواحات
class _UnitCheckpointGate extends StatelessWidget {
  final AssessmentUnitSpec unit;
  final UnitAssessmentResult? result;
  final double width;
  final double height;
  final bool compact;
  final VoidCallback onTap;

  const _UnitCheckpointGate({
    required this.unit,
    required this.result,
    required this.width,
    required this.height,
    required this.compact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mastery = result?.masteryLevel;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 14,
            vertical: compact ? 6 : 8,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [unit.primaryColor, unit.secondaryColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: unit.primaryColor.withValues(alpha: 0.38),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: compact ? 36 : 42,
                height: compact ? 36 : 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  mastery?.badgeEmoji ?? '🏆',
                  style: TextStyle(fontSize: compact ? 20 : 24),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        'اخْتِبَارُ: ${unit.titleAr}',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: compact ? 12.5 : 14.5,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        result != null
                            ? 'النَّتِيجَةُ: ${result!.percent.round()}%'
                            : 'بَعْدَ ٧ حُرُوفٍ • ابْدَأْ',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: compact ? 10.5 : 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withValues(alpha: 0.94),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Painter to draw smooth connecting desert trail between stage nodes
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
    path.lineTo(positions.last.dx, positions.last.dy);

    final borderPaint = Paint()
      ..color = const Color(0xFFD4A017).withValues(alpha: 0.4)
      ..strokeWidth = 16.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, borderPaint);

    final roadPaint = Paint()
      ..color = const Color(0xFFFFF3E0).withValues(alpha: 0.9)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, roadPaint);
  }

  @override
  bool shouldRepaint(covariant _OasisPathPainter oldDelegate) {
    return oldDelegate.positions != positions ||
        oldDelegate.unlockedCount != unlockedCount;
  }
}

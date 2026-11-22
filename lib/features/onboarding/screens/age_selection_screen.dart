import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';

/// Age Selection Screen — choose age group (3 cards)
/// Fully responsive from 320×533 compact phones to 960×1600 tablets
class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({super.key});

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  AgeGroup? _selected;

  void _selectAgeGroup(AgeGroup group) {
    setState(() => _selected = group);
  }

  void _proceed() {
    if (_selected == null) return;
    context.go(AppRouter.avatarSelection, extra: _selected);
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isUltraCompact || context.isShortScreen;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDay,
        body: SafeArea(
          child: ResponsiveContentFrame(
            maxWidth: 600,
            padding: EdgeInsets.symmetric(horizontal: isCompact ? 16 : 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryDay),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(AppRouter.onboarding);
                      }
                    },
                  ),
                ),

                // Scrollable center prevents overflow on short/old phones (320×533 / 360×640)
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: isCompact ? 4 : 12),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'كم عمرك؟',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: context.scaledFont(36, min: 26, max: 42),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryDay,
                                  ),
                                ),
                              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),
                              const SizedBox(height: 6),
                              Text(
                                'اختر فئتك العمرية لنبدأ معاً',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: context.scaledFont(18, min: 14, max: 21),
                                  color: AppColors.textSecondaryDay,
                                ),
                              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                              SizedBox(height: isCompact ? 16 : 32),
                              _buildAgeCard(
                                context: context,
                                group: AgeGroup.preschool3to5,
                                emoji: '🧒',
                                color: const Color(0xFFFF9800),
                                delay: 0,
                                compact: isCompact,
                              ),
                              SizedBox(height: isCompact ? 12 : 18),
                              _buildAgeCard(
                                context: context,
                                group: AgeGroup.emerging6to8,
                                emoji: '👦',
                                color: const Color(0xFF2196F3),
                                delay: 100,
                                compact: isCompact,
                              ),
                              SizedBox(height: isCompact ? 12 : 18),
                              _buildAgeCard(
                                context: context,
                                group: AgeGroup.independent9to10,
                                emoji: '🧑',
                                color: const Color(0xFF4CAF50),
                                delay: 200,
                                compact: isCompact,
                              ),
                              SizedBox(height: isCompact ? 14 : 24),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: isCompact ? 12 : 24, top: 6),
                  child: SizedBox(
                    width: double.infinity,
                    height: isCompact ? 52 : 60,
                    child: ElevatedButton(
                      onPressed: _selected != null ? _proceed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDay,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: AppColors.disabledDay,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'التالي',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(20, min: 16, max: 24),
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeCard({
    required BuildContext context,
    required AgeGroup group,
    required String emoji,
    required Color color,
    required int delay,
    required bool compact,
  }) {
    final isSelected = _selected == group;
    final boxSize = compact ? 48.0 : 58.0;

    return GestureDetector(
      onTap: () => _selectAgeGroup(group),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: BoxConstraints(minHeight: compact ? 74 : 94),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.15) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : AppColors.borderDay,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 14 : 22,
            vertical: compact ? 10 : 14,
          ),
          child: Row(
            children: [
              Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(emoji, style: TextStyle(fontSize: compact ? 24 : 28)),
                ),
              ),
              SizedBox(width: compact ? 12 : 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.labelAr,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(17, min: 14, max: 20),
                        fontWeight: FontWeight.w700,
                        color: isSelected ? color : AppColors.textPrimaryDay,
                      ),
                    ),
                    Text(
                      '${group.ageRange} سنوات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(13.5, min: 12, max: 16),
                        color: isSelected
                            ? color.withValues(alpha: 0.85)
                            : AppColors.textSecondaryDay,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: color, size: compact ? 24 : 28),
            ],
          ),
        ),
      ).animate(delay: Duration(milliseconds: delay)).fadeIn(duration: 400.ms).slideX(begin: 0.08, end: 0),
    );
  }
}

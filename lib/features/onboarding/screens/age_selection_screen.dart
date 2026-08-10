import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

/// Age Selection Screen — choose age group (3 cards)
/// P4-T006
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
    // Pass age group to avatar selection via extra
    context.go(AppRouter.avatarSelection, extra: _selected);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDay,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    const SizedBox(height: 16),
    
                    // Title
                    const Text(
                      'كم عمرك؟',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryDay,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: -0.2, end: 0),
    
                    const SizedBox(height: 8),
    
                    const Text(
                      'اختر فئتك العمرية لنبدأ معاً',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textSecondaryDay,
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
    
                    const SizedBox(height: 48),
    
                    // Age group cards
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAgeCard(
                            group: AgeGroup.preschool3to5,
                            icon: Icons.child_care,
                            emoji: '🧒',
                            color: const Color(0xFFFF9800),
                            delay: 0,
                          ),
                          const SizedBox(height: 20),
                          _buildAgeCard(
                            group: AgeGroup.emerging6to8,
                            icon: Icons.school,
                            emoji: '👦',
                            color: const Color(0xFF2196F3),
                            delay: 100,
                          ),
                          const SizedBox(height: 20),
                          _buildAgeCard(
                            group: AgeGroup.independent9to10,
                            icon: Icons.auto_stories,
                            emoji: '🧑',
                            color: const Color(0xFF4CAF50),
                            delay: 200,
                          ),
                        ],
                      ),
                    ),
    
                    // Next button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 64,
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
                          child: const Text(
                            'التالي',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeCard({
    required AgeGroup group,
    required IconData icon,
    required String emoji,
    required Color color,
    required int delay,
  }) {
    final isSelected = _selected == group;

    return GestureDetector(
      onTap: () => _selectAgeGroup(group),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 100,
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
        transform: isSelected
            ? (Matrix4.identity()..scale(1.03))
            : Matrix4.identity(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 16),
              // Text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.labelAr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? color : AppColors.textPrimaryDay,
                      ),
                    ),
                    Text(
                      '${group.ageRange} سنوات',
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? color.withValues(alpha: 0.8)
                            : AppColors.textSecondaryDay,
                      ),
                    ),
                  ],
                ),
              ),
              // Check
              if (isSelected)
                Icon(Icons.check_circle, color: color, size: 28),
            ],
          ),
        ),
      ).animate(delay: Duration(milliseconds: delay)).fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

/// Avatar Selection Screen — 3x3 grid of avatars
/// P4-T007
class AvatarSelectionScreen extends StatefulWidget {
  final AgeGroup? ageGroup;
  const AvatarSelectionScreen({super.key, this.ageGroup});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? _selectedIndex;

  // Avatar data: emoji + label
  static const List<_AvatarOption> _avatars = [
    _AvatarOption(icon: Icons.pets, label: 'صقر', color: Colors.amber),
    _AvatarOption(icon: Icons.shield, label: 'أسد', color: Colors.orange),
    _AvatarOption(icon: Icons.terrain, label: 'جمل', color: Colors.brown),
    _AvatarOption(icon: Icons.face, label: 'فصيح', color: Colors.blue),
    _AvatarOption(icon: Icons.eco, label: 'أرنب', color: Colors.green),
    _AvatarOption(icon: Icons.local_fire_department, label: 'ثعلب', color: Colors.deepOrange),
    _AvatarOption(icon: Icons.spa, label: 'دب', color: Colors.teal),
    _AvatarOption(icon: Icons.auto_awesome, label: 'فراشة', color: Colors.purple),
    _AvatarOption(icon: Icons.star, label: 'نجمة', color: Colors.yellow),
  ];

  void _proceed() {
    if (_selectedIndex == null) return;
    context.go(
      AppRouter.nameInput,
      extra: NameInputArgs(
        ageGroup: widget.ageGroup ?? AgeGroup.preschool3to5,
        avatarIndex: _selectedIndex!,
      ),
    );
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
                        context.go(AppRouter.ageSelection);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'اختر صورتك',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryDay,
                  ),
                ).animate().fadeIn(duration: 500.ms),

                const SizedBox(height: 8),

                const Text(
                  'اختر الصورة التي تعجبك',
                  style: TextStyle(fontSize: 16, color: AppColors.textSecondaryDay),
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 40),

                // 3x3 Grid
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _avatars.length,
                    itemBuilder: (context, index) {
                      final avatar = _avatars[index];
                      final isSelected = _selectedIndex == index;

                      return GestureDetector(
                        onTap: () => setState(() => _selectedIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryDay.withValues(alpha: 0.15)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.gold
                                  : AppColors.borderDay,
                              width: isSelected ? 3 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.gold.withValues(alpha: 0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: avatar.color.withValues(alpha: 0.2),
                                child: Icon(avatar.icon, size: 28, color: avatar.color),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                avatar.label,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.primaryDay
                                      : AppColors.textSecondaryDay,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate(delay: Duration(milliseconds: index * 50))
                          .fadeIn(duration: 300.ms)
                          .scale(begin: const Offset(0.8, 0.8));
                    },
                  ),
                ),

                // Next button
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _selectedIndex != null ? _proceed : null,
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
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
}

class _AvatarOption {
  final IconData icon;
  final String label;
  final Color color;
  const _AvatarOption({required this.icon, required this.label, required this.color});
}

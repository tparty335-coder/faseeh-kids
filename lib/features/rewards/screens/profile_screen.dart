import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/rewards/logic/rewards_provider.dart';
import 'package:faseeh_kids/features/rewards/widgets/stat_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xp = ref.watch(xpProvider);
    final streak = ref.watch(streakProvider);
    final stats = ref.watch(progressStatsProvider);
    final badges = ref.watch(badgesProvider);
    
    final earnedBadgesCount = badges.where((b) => b.isEarned).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('الملف الشخصي', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRouter.homeMap),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Avatar and Name
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 4),
                      ),
                      child: const Center(
                        child: Text('👦', style: TextStyle(fontSize: 64)),
                      ),
                    ).animate().scale(duration: const Duration(milliseconds: 500), curve: Curves.easeOutBack),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '٦-٨ سنوات',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ).animate(delay: const Duration(milliseconds: 300)).scale(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'أحمد',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ).animate(delay: const Duration(milliseconds: 200)).fadeIn().slideY(begin: 0.2),
              
              const SizedBox(height: 32),

              // Overall Progress Ring
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: stats.completionPercentage,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey.shade200,
                            color: AppColors.primary,
                          ),
                          Text(
                            '${(stats.completionPercentage * 100).toInt()}%',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'التقدم الإجمالي',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'لقد أنجزت عملاً رائعاً! استمر في التعلم.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate(delay: const Duration(milliseconds: 400)).fadeIn().slideY(begin: 0.2),

              const SizedBox(height: 24),

              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  StatCard(
                    icon: Icons.flash_on_rounded,
                    label: 'إجمالي XP',
                    value: xp.toString(),
                    color: Colors.amber,
                  ).animate(delay: const Duration(milliseconds: 500)).fadeIn().scale(),
                  StatCard(
                    icon: Icons.local_fire_department_rounded,
                    label: 'أيام متتالية',
                    value: streak.toString(),
                    color: Colors.orange,
                  ).animate(delay: const Duration(milliseconds: 600)).fadeIn().scale(),
                  StatCard(
                    icon: Icons.sort_by_alpha_rounded,
                    label: 'حروف أتقنتها',
                    value: stats.lettersMastered.toString(),
                    color: AppColors.primary,
                  ).animate(delay: const Duration(milliseconds: 700)).fadeIn().scale(),
                  StatCard(
                    icon: Icons.emoji_events_rounded,
                    label: 'شارات حصلت عليها',
                    value: earnedBadgesCount.toString(),
                    color: AppColors.secondary,
                  ).animate(delay: const Duration(milliseconds: 800)).fadeIn().scale(),
                ],
              ),

              const SizedBox(height: 40),

              // Switch Profile Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.people_alt_rounded),
                  label: const Text(
                    'تبديل الحساب',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary, width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    context.go(AppRouter.ageSelection);
                  },
                ).animate(delay: const Duration(milliseconds: 900)).fadeIn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

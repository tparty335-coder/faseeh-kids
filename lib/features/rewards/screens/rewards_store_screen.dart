import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/features/rewards/logic/rewards_provider.dart';
import 'package:faseeh_kids/features/rewards/widgets/badge_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RewardsStoreScreen extends ConsumerWidget {
  const RewardsStoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badges = ref.watch(badgesProvider);

    // Group badges by category
    final groupedBadges = <String, List<BadgeModel>>{};
    for (var badge in badges) {
      if (!groupedBadges.containsKey(badge.category)) {
        groupedBadges[badge.category] = [];
      }
      groupedBadges[badge.category]!.add(badge);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('المكافآت والشارات', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRouter.homeMap),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      size: 80,
                      color: Colors.amber,
                    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: const Duration(seconds: 2)),
                    const SizedBox(height: 16),
                    Text(
                      'اجمع الشارات بإكمال الدروس والمثابرة!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ...groupedBadges.entries.map((entry) {
              return SliverMainAxisGroup(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0).copyWith(bottom: 24.0),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final badge = entry.value[index];
                          return BadgeCard(
                            icon: badge.icon,
                            name: badge.name,
                            description: badge.description,
                            isEarned: badge.isEarned,
                            dateEarned: badge.dateEarned,
                          ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideY(begin: 0.2);
                        },
                        childCount: entry.value.length,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

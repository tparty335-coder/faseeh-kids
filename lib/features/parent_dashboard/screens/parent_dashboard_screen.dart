import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';
import '../logic/parent_provider.dart';
import '../widgets/settings_toggle.dart';

import 'package:faseeh_kids/features/rewards/logic/rewards_provider.dart';
import 'package:faseeh_kids/core/router/app_router.dart';

class ParentDashboardScreen extends ConsumerWidget {
  const ParentDashboardScreen({super.key});

  Future<void> _confirmDeleteAccount(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text(
            'ط­ط°ظپ ط§ظ„ط­ط³ط§ط¨ ظˆط¨ظٹط§ظ†ط§طھ ط§ظ„ط·ظپظ„',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'ظ‡ظ„ ط£ظ†طھ ظ…طھط£ظƒط¯ ظ…ظ† ط­ط°ظپ ظ…ظ„ظپ ط§ظ„ط·ظپظ„ ظˆط¬ظ…ظٹط¹ ط¨ظٹط§ظ†ط§طھ ط§ظ„طھظ‚ط¯ظ… ظˆط§ظ„ظ†ط¬ظˆظ… ظ†ظ‡ط§ط¦ظٹط§ظ‹ ظ…ظ† ظ‡ط°ط§ ط§ظ„ط¬ظ‡ط§ط²طں ظ„ط§ ظٹظ…ظƒظ† ط§ظ„طھط±ط§ط¬ط¹ ط¹ظ† ظ‡ط°ط§ ط§ظ„ط¥ط¬ط±ط§ط،.',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('ط¥ظ„ط؛ط§ط،', style: TextStyle(fontFamily: 'Cairo')),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('ظ†ط¹ظ…طŒ ط§ط­ط°ظپ ط¬ظ…ظٹط¹ ط§ظ„ط¨ظٹط§ظ†ط§طھ', style: TextStyle(fontFamily: 'Cairo')),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    try {
      for (final boxName in [
        AppConstants.childProfileBox,
        AppConstants.lessonProgressBox,
        AppConstants.activityResultBox,
        AppConstants.masteryRecordBox,
        AppConstants.streakDataBox,
        AppConstants.storyProgressBox,
        AppConstants.parentSettingsBox,
      ]) {
        if (Hive.isBoxOpen(boxName)) {
          await Hive.box(boxName).clear();
        }
      }
    } catch (_) {}

    ref.read(parentSettingsProvider.notifier).updateSettings(const ParentSettings());
    ref.read(unlockedUnitsProvider.notifier).reset();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('طھظ… ط­ط°ظپ ط¬ظ…ظٹط¹ ط¨ظٹط§ظ†ط§طھ ط§ظ„ط­ط³ط§ط¨ ط¨ظ†ط¬ط§ط­.', style: TextStyle(fontFamily: 'Cairo')),
        ),
      );
      context.go(AppRouter.onboarding);
    }
  }

  void _showLegalDialog(BuildContext context, {required bool isPrivacy}) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Text(
            isPrivacy ? 'ط³ظٹط§ط³ط© ط§ظ„ط®طµظˆطµظٹط© ظˆط­ظ…ط§ظٹط© ط§ظ„ط·ظپظ„ (COPPA)' : 'ط´ط±ظˆط· ظˆط£ط­ظƒط§ظ… ط§ظ„ط§ط³طھط®ط¯ط§ظ…',
            style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Text(
              isPrivacy
                  ? 'ظٹظ„طھط²ظ… طھط·ط¨ظٹظ‚ آ«ظپطµظٹط­ ط§ظ„طµط؛ط§ط±آ» ط§ظ„طھط²ط§ظ…ط§ظ‹ ظƒط§ظ…ظ„ط§ظ‹ ط¨ظ‚ط§ظ†ظˆظ† ط­ظ…ط§ظٹط© ط®طµظˆطµظٹط© ط§ظ„ط£ط·ظپط§ظ„ ط¹ظ„ظ‰ ط§ظ„ط¥ظ†طھط±ظ†طھ (COPPA) ظˆط³ظٹط§ط³ط§طھ ط¹ط§ط¦ظ„ط§طھ Google Play ظˆApple Kids Category:\n\n'
                    'ظ،. ظ„ط§ ظٹط¬ظ…ط¹ ط§ظ„طھط·ط¨ظٹظ‚ ط£ظٹ ط¨ظٹط§ظ†ط§طھ طھط¹ط±ظٹظپ ط´ط®طµظٹط© ط­ط³ط§ط³ط© ط¹ظ† ط§ظ„ط·ظپظ„طŒ ظˆظٹظڈط­ظپط¸ ط§ط³ظ… ط§ظ„ط·ظپظ„ ط§ظ„ط±ظ…ط²ظٹ ظˆطھظ‚ط¯ظ…ظ‡ ط§ظ„طھط¹ظ„ظٹظ…ظٹ ظ…ط­ظ„ظٹط§ظ‹ ط¹ظ„ظ‰ ط§ظ„ط¬ظ‡ط§ط².\n'
                    'ظ¢. ظ„ط§ ظٹط­طھظˆظٹ ط§ظ„طھط·ط¨ظٹظ‚ ط¹ظ„ظ‰ ط£ظٹ ط¥ط¹ظ„ط§ظ†ط§طھ ط·ط±ظپ ط«ط§ظ„ط« ط£ظˆ ط±ظˆط§ط¨ط· ط®ط§ط±ط¬ظٹط© ظ…ظپطھظˆط­ط© ظ„ظ„ط·ظپظ„.\n'
                    'ظ£. ط¬ظ…ظٹط¹ ط¹ظ…ظ„ظٹط§طھ ط§ظ„ط´ط±ط§ط، ظˆط¥ط¯ط§ط±ط© ط§ظ„ط­ط³ط§ط¨ ظ…ط­ظ…ظٹط© ط®ظ„ظپ آ«ط¨ظˆط§ط¨ط© ط§ظ„ط¢ط¨ط§ط،آ» (Parent Gate).\n'
                    'ظ¤. ظٹط­ظ‚ ظ„ظˆظ„ظٹ ط§ظ„ط£ظ…ط± ط­ط°ظپ ط¬ظ…ظٹط¹ ط§ظ„ط¨ظٹط§ظ†ط§طھ ط§ظ„ظ…ط®ط²ظ†ط© ظپظٹ ط£ظٹ ظˆظ‚طھ ط¹ط¨ط± ط²ط± آ«ط­ط°ظپ ط§ظ„ط­ط³ط§ط¨آ» ظپظٹ ظ„ظˆط­ط© طھط­ظƒظ… ط§ظ„ط¢ط¨ط§ط،.\n'
                    '5. للاطلاع على النسخة الكاملة: https://tparty335-coder.github.io/faseeh-kids-privacy/\n📧 lingobanana0@gmail.com'
                  : 'ط´ط±ظˆط· ط§ط³طھط®ط¯ط§ظ… طھط·ط¨ظٹظ‚ آ«ظپطµظٹط­ ط§ظ„طµط؛ط§ط±آ»:\n\n'
                    'ظ،. ط§ظ„ظ…ط­طھظˆظ‰ ط§ظ„طھط¹ظ„ظٹظ…ظٹ ظ…ط®طµطµ ظ„ظ„ط£ط·ظپط§ظ„ ظ…ظ† ط³ظ† ظ£ ط¥ظ„ظ‰ ظ،ظ  ط³ظ†ظˆط§طھ ظ„طھط¹ظ„ظ… ط§ظ„ظ‚ط±ط§ط،ط© ظˆط§ظ„ظƒطھط§ط¨ط© ط§ظ„ط¹ط±ط¨ظٹط© ط§ظ„ط³ظ„ظٹظ…ط©.\n'
                    'ظ¢. ط£ظˆظ„ ظ¥ ظˆط­ط¯ط§طھ طھط¹ظ„ظٹظ…ظٹط© (ط£طŒ ط¨طŒ طھطŒ ط«طŒ ط¬) ظ…طھط§ط­ط© ظ…ط¬ط§ظ†ط§ظ‹ ط¨ط§ظ„ظƒط§ظ…ظ„طŒ ظˆظٹظ…ظƒظ† ظ„ظˆظ„ظٹ ط§ظ„ط£ظ…ط± ط§ظ„ط§ط´طھط±ط§ظƒ ظ„ظپطھط­ ظƒط§ظ…ظ„ ط§ظ„ط­ط±ظˆظپ ط§ظ„ظ€ ظ¢ظ¨ ط£ظˆ طھظپط¹ظٹظ„ ظˆط¶ط¹ ط§ظ„ظ…ط±ط§ط¬ط¹ط© ط§ظ„ط­ط±ط©.\n'
                    'ظ£. طھظڈط¯ط§ط± ط§ظ„ط§ط´طھط±ط§ظƒط§طھ ظˆط§ط³طھط¹ط§ط¯ط© ط§ظ„ظ…ط´طھط±ظٹط§طھ ط­طµط±ظٹط§ظ‹ ط¨ظˆط§ط³ط·ط© ظˆظ„ظٹ ط§ظ„ط£ظ…ط± ط¹ط¨ط± ط­ط³ط§ط¨ ط§ظ„ظ…طھط¬ط± ط§ظ„ط±ط³ظ…ظٹ.\n'
                    'ظ¤. ط§ظ„ظ†ط³ط®ط© ط§ظ„ظƒط§ظ…ظ„ط© ظ…طھظˆظپط±ط© ظپظٹ ظ…ظ„ظپ web/terms_of_service.html.',
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, height: 1.5),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('ط¥ط؛ظ„ط§ظ‚', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(parentSettingsProvider);
    final profiles = ref.watch(childProfilesProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('ظ„ظˆط­ط© طھط­ظƒظ… ط§ظ„ط¢ط¨ط§ط،'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRouter.homeMap),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.show_chart),
              tooltip: 'ط§ظ„طھظ‚ط±ظٹط± ط§ظ„طھظپطµظٹظ„ظٹ',
              onPressed: () => context.push('/progress-report'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Child Selector
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.secondary,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: profiles.first.id,
                            isExpanded: true,
                            items: profiles
                                .map((p) => DropdownMenuItem(
                                      value: p.id,
                                      child: Text(
                                        p.name,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) { /* multi-profile switching — coming in v1.1 */ },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Progress Report Card
              GestureDetector(
                onTap: () => context.push('/progress-report'),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'طھظ‚ط±ظٹط± ط§ظ„طھظ‚ط¯ظ…',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade600),
                          ],
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.star, color: Colors.orange),
                          title: const Text('ط§ظ„ط­ط±ظˆظپ ط§ظ„ظ…طھظ‚ظ†ط©'),
                          trailing: Text(
                            '${ref.watch(progressStatsProvider).lettersMastered} / ظ¢ظ¨',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        LinearProgressIndicator(
                          value: ref.watch(progressStatsProvider).completionPercentage,
                          backgroundColor: Colors.grey.shade200,
                          color: Colors.green,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              'ط§ظ„ظˆظ‚طھ',
                              '${ref.watch(progressStatsProvider).lettersMastered * 5} ط¯ظ‚ظٹظ‚ط©',
                              Icons.timer,
                            ),
                            _buildStatItem(
                              'ط§ظ„ط¯ظ‚ط©',
                              '${(ref.watch(progressStatsProvider).completionPercentage * 100).toInt()}%',
                              Icons.check_circle,
                            ),
                            _buildStatItem(
                              'ط§ظ„ط§ط³طھظ…ط±ط§ط±ظٹط©',
                              '${ref.watch(streakProvider)} ط£ظٹط§ظ…',
                              Icons.local_fire_department,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'ط¥ط¹ط¯ط§ط¯ط§طھ ط§ظ„طھط·ط¨ظٹظ‚',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ظˆظ‚طھ ط§ظ„ط§ط³طھط®ط¯ط§ظ… ط§ظ„ظٹظˆظ…ظٹ: ${settings.dailyTimeLimit} ط¯ظ‚ظٹظ‚ط©',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        value: settings.dailyTimeLimit.toDouble(),
                        min: 10,
                        max: 60,
                        divisions: 5,
                        label: '${settings.dailyTimeLimit} ط¯ظ‚ظٹظ‚ط©',
                        onChanged: (val) {
                          ref.read(parentSettingsProvider.notifier).updateSettings(
                                settings.copyWith(dailyTimeLimit: val.toInt()),
                              );
                        },
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'ط§ظ„ظ…ط¤ط«ط±ط§طھ ط§ظ„طµظˆطھظٹط©',
                        description: 'طھط´ط؛ظٹظ„ ط£طµظˆط§طھ ط§ظ„طھط·ط¨ظٹظ‚ ظˆط§ظ„طھظپط§ط¹ظ„ط§طھ',
                        value: settings.soundEnabled,
                        onChanged: (val) => ref.read(parentSettingsProvider.notifier).updateSettings(
                              settings.copyWith(soundEnabled: val),
                            ),
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'ط§ظ„ظ…ظˆط³ظٹظ‚ظ‰ ط§ظ„ط®ظ„ظپظٹط©',
                        description: 'طھط´ط؛ظٹظ„ ط§ظ„ظ…ظˆط³ظٹظ‚ظ‰ ط§ظ„ظ‡ط§ط¯ط¦ط© ط£ط«ظ†ط§ط، ط§ظ„طھط¹ظ„ظ…',
                        value: settings.musicEnabled,
                        onChanged: (val) => ref.read(parentSettingsProvider.notifier).updateSettings(
                              settings.copyWith(musicEnabled: val),
                            ),
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'ط§ظ„ظˆط¶ط¹ ط§ظ„ظ„ظٹظ„ظٹ',
                        description: 'طھط؛ظٹظٹط± ط£ظ„ظˆط§ظ† ط§ظ„طھط·ط¨ظٹظ‚ ظ„طھظƒظˆظ† ظ…ط±ظٹط­ط© ظ„ظ„ط¹ظٹظ†',
                        value: settings.nightMode,
                        onChanged: (val) => ref.read(parentSettingsProvider.notifier).updateSettings(
                              settings.copyWith(nightMode: val),
                            ),
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'ظپطھط­ ط¬ظ…ظٹط¹ ط§ظ„ط­ط±ظˆظپ ظ„ظ„ظ…ط±ط§ط¬ط¹ط© ط§ظ„ط­ط±ط©',
                        description: 'ط§ظ„ط³ظ…ط§ط­ ظ„ظ„ط·ظپظ„ ط£ظˆ ط§ظ„ظ…ط¹ظ„ظ… ط¨طھطµظپط­ ط¬ظ…ظٹط¹ ط§ظ„ط­ط±ظˆظپ ط§ظ„ظ€ ظ¢ظ¨ ط¯ظˆظ† طھظ‚ظٹط¯ ط¨ط§ظ„طھط³ظ„ط³ظ„',
                        value: settings.unlockAllLettersForReview,
                        onChanged: (val) => ref.read(parentSettingsProvider.notifier).updateSettings(
                              settings.copyWith(unlockAllLettersForReview: val),
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'ط¥ط¯ط§ط±ط© ط§ظ„ط­ط³ط§ط¨ط§طھ ظˆط§ظ„ط®طµظˆطµظٹط©',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRouter.nameInput),
                icon: const Icon(Icons.add),
                label: const Text('ط¥ط¶ط§ظپط© ط·ظپظ„ ط¬ط¯ظٹط¯'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRouter.ageSelection),
                icon: const Icon(Icons.edit),
                label: const Text('طھط¹ط¯ظٹظ„ ط¨ظٹط§ظ†ط§طھ ط§ظ„ط·ظپظ„'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRouter.placementTest),
                icon: const Icon(Icons.quiz_outlined),
                label: const Text('ط¥ط¹ط§ط¯ط© ط§ط®طھط¨ط§ط± طھط­ط¯ظٹط¯ ط§ظ„ظ…ط³طھظˆظ‰'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showLegalDialog(context, isPrivacy: true),
                      icon: const Icon(Icons.privacy_tip_outlined, size: 18),
                      label: const Text('ط³ظٹط§ط³ط© ط§ظ„ط®طµظˆطµظٹط©'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showLegalDialog(context, isPrivacy: false),
                      icon: const Icon(Icons.description_outlined, size: 18),
                      label: const Text('ط´ط±ظˆط· ط§ظ„ط§ط³طھط®ط¯ط§ظ…'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => _confirmDeleteAccount(context, ref),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('ط­ط°ظپ ط§ظ„ط­ط³ط§ط¨', style: TextStyle(color: Colors.red)),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}


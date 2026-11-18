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
            'حذف الحساب وبيانات الطفل',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'هل أنت متأكد من حذف ملف الطفل وجميع بيانات التقدم والنجوم نهائياً من هذا الجهاز؟ لا يمكن التراجع عن هذا الإجراء.',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('نعم، احذف جميع البيانات', style: TextStyle(fontFamily: 'Cairo')),
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
          content: Text('تم حذف جميع بيانات الحساب بنجاح.', style: TextStyle(fontFamily: 'Cairo')),
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
            isPrivacy ? 'سياسة الخصوصية وحماية الطفل (COPPA)' : 'شروط وأحكام الاستخدام',
            style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Text(
              isPrivacy
                  ? 'يلتزم تطبيق «فصيح الصغار» التزاماً كاملاً بقانون حماية خصوصية الأطفال على الإنترنت (COPPA) وسياسات عائلات Google Play وApple Kids Category:\n\n'
                    '١. لا يجمع التطبيق أي بيانات تعريف شخصية حساسة عن الطفل، ويُحفظ اسم الطفل الرمزي وتقدمه التعليمي محلياً على الجهاز.\n'
                    '٢. لا يحتوي التطبيق على أي إعلانات طرف ثالث أو روابط خارجية مفتوحة للطفل.\n'
                    '٣. جميع عمليات الشراء وإدارة الحساب محمية خلف «بوابة الآباء» (Parent Gate).\n'
                    '٤. يحق لولي الأمر حذف جميع البيانات المخزنة في أي وقت عبر زر «حذف الحساب» في لوحة تحكم الآباء.\n'
                    '5. للاطلاع على النسخة الكاملة: https://tparty335-coder.github.io/faseeh-kids-privacy/\n📧 lingobanana0@gmail.com'
                  : 'شروط استخدام تطبيق «فصيح الصغار»:\n\n'
                    '١. المحتوى التعليمي مخصص للأطفال من سن ٣ إلى ١٠ سنوات لتعلم القراءة والكتابة العربية السليمة.\n'
                    '٢. أول ٥ وحدات تعليمية (أ، ب، ت، ث، ج) متاحة مجاناً بالكامل، ويمكن لولي الأمر الاشتراك لفتح كامل الحروف الـ ٢٨ أو تفعيل وضع المراجعة الحرة.\n'
                    '٣. تُدار الاشتراكات واستعادة المشتريات حصرياً بواسطة ولي الأمر عبر حساب المتجر الرسمي.\n'
                    '٤. النسخة الكاملة متوفرة في الرابط الرسمي للشروط.',
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, height: 1.5),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إغلاق', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
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

    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go(AppRouter.homeMap);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('لوحة تحكم الآباء'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRouter.homeMap),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.show_chart),
              tooltip: 'التقرير التفصيلي',
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
                              'تقرير التقدم',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade600),
                          ],
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.star, color: Colors.orange),
                          title: const Text('الحروف المتقنة'),
                          trailing: Text(
                            '${ref.watch(progressStatsProvider).lettersMastered} / 28',
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
                              'الوقت',
                              '${ref.watch(progressStatsProvider).lettersMastered * 5} دقيقة',
                              Icons.timer,
                            ),
                            _buildStatItem(
                              'الدقة',
                              '${(ref.watch(progressStatsProvider).completionPercentage * 100).toInt()}%',
                              Icons.check_circle,
                            ),
                            _buildStatItem(
                              'الاستمرارية',
                              '${ref.watch(streakProvider)} أيام',
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
                'إعدادات التطبيق',
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
                        'وقت الاستخدام اليومي: ${settings.dailyTimeLimit} دقيقة',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        value: settings.dailyTimeLimit.toDouble(),
                        min: 10,
                        max: 60,
                        divisions: 5,
                        label: '${settings.dailyTimeLimit} دقيقة',
                        onChanged: (val) {
                          ref.read(parentSettingsProvider.notifier).updateSettings(
                                settings.copyWith(dailyTimeLimit: val.toInt()),
                              );
                        },
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'المؤثرات الصوتية',
                        description: 'تشغيل أصوات التطبيق والتفاعلات',
                        value: settings.soundEnabled,
                        onChanged: (val) => ref.read(parentSettingsProvider.notifier).updateSettings(
                              settings.copyWith(soundEnabled: val),
                            ),
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'الموسيقى الخلفية',
                        description: 'تشغيل الموسيقى الهادئة أثناء التعلم',
                        value: settings.musicEnabled,
                        onChanged: (val) => ref.read(parentSettingsProvider.notifier).updateSettings(
                              settings.copyWith(musicEnabled: val),
                            ),
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'الوضع الليلي',
                        description: 'تغيير ألوان التطبيق لتكون مريحة للعين',
                        value: settings.nightMode,
                        onChanged: (val) => ref.read(parentSettingsProvider.notifier).updateSettings(
                              settings.copyWith(nightMode: val),
                            ),
                      ),
                      const Divider(),
                      SettingsToggle(
                        label: 'فتح جميع الحروف للمراجعة الحرة',
                        description: 'السماح للطفل أو المعلم بتصفح جميع الحروف الـ 28 دون تقيد بالتسلسل',
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
                'إدارة الحسابات والخصوصية',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRouter.nameInput),
                icon: const Icon(Icons.add),
                label: const Text('إضافة طفل جديد'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRouter.ageSelection),
                icon: const Icon(Icons.edit),
                label: const Text('تعديل بيانات الطفل'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRouter.placementTest),
                icon: const Icon(Icons.quiz_outlined),
                label: const Text('إعادة اختبار تحديد المستوى'),
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
                      label: const Text('سياسة الخصوصية'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showLegalDialog(context, isPrivacy: false),
                      icon: const Icon(Icons.description_outlined, size: 18),
                      label: const Text('شروط الاستخدام'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => _confirmDeleteAccount(context, ref),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('حذف الحساب', style: TextStyle(color: Colors.red)),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
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

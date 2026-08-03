import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import '../logic/parent_provider.dart';
import '../widgets/settings_toggle.dart';

import 'package:faseeh_kids/core/router/app_router.dart';

class ParentDashboardScreen extends ConsumerWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(parentSettingsProvider);
    final profiles = ref.watch(childProfilesProvider);

    return Directionality(
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
                            items: profiles.map((p) => DropdownMenuItem(
                              value: p.id,
                              child: Text(p.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            )).toList(),
                            onChanged: (val) {},
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
                        const ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.star, color: Colors.orange),
                          title: Text('الحروف المتقنة'),
                          trailing: Text('١٢ / ٢٨', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        LinearProgressIndicator(
                          value: 12 / 28,
                          backgroundColor: Colors.grey.shade200,
                          color: Colors.green,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem('الوقت', '٤٥ دقيقة', Icons.timer),
                            _buildStatItem('الدقة', '٪٨٥', Icons.check_circle),
                            _buildStatItem('الاستمرارية', '٣ أيام', Icons.local_fire_department),
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
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              const Text(
                'إدارة الحسابات',
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
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRouter.ageSelection),
                icon: const Icon(Icons.edit),
                label: const Text('تعديل بيانات الطفل'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  // Show delete confirmation
                },
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

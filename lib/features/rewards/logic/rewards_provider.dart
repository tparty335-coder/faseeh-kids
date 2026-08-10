import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';

class BadgeModel {
  final String id;
  final String icon;
  final String name;
  final String description;
  final String category;
  final bool isEarned;
  final DateTime? dateEarned;

  const BadgeModel({
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
    required this.category,
    this.isEarned = false,
    this.dateEarned,
  });
}

class ProgressStats {
  final int lettersMastered;
  final double completionPercentage;

  const ProgressStats({
    required this.lettersMastered,
    required this.completionPercentage,
  });
}

final progressStatsProvider = Provider<ProgressStats>((ref) {
  final unlocked = ref.watch(unlockedUnitsProvider);
  final count = unlocked.length;
  return ProgressStats(
    lettersMastered: count,
    completionPercentage: (count / 28.0).clamp(0.0, 1.0),
  );
});

final xpProvider = Provider<int>((ref) {
  final unlocked = ref.watch(unlockedUnitsProvider);
  return unlocked.length * 50;
});

final streakProvider = Provider<int>((ref) {
  final unlocked = ref.watch(unlockedUnitsProvider);
  return (unlocked.length / 2).ceil().clamp(1, 30);
});

final badgesProvider = Provider<List<BadgeModel>>((ref) {
  final unlocked = ref.watch(unlockedUnitsProvider);
  final count = unlocked.length;

  return [
    BadgeModel(
      id: 'explorer',
      icon: '🧭',
      name: 'المكتشف',
      description: 'أكملت اختبار تحديد المستوى بنجاح!',
      category: 'إنجازات',
      isEarned: count >= 1,
      dateEarned: count >= 1 ? DateTime.now() : null,
    ),
    BadgeModel(
      id: 'alif_star',
      icon: '⭐',
      name: 'نجم الألف',
      description: 'أتقنت الحرف الأول',
      category: 'أحرف',
      isEarned: unlocked.contains('أ'),
      dateEarned: unlocked.contains('أ') ? DateTime.now() : null,
    ),
    BadgeModel(
      id: 'daily_flame',
      icon: '🔥',
      name: 'مشعل اليوم',
      description: 'تعلمت لـ 3 أيام متتالية',
      category: 'مثابرة',
      isEarned: count >= 3,
      dateEarned: count >= 3 ? DateTime.now() : null,
    ),
    BadgeModel(
      id: 'weekly_champion',
      icon: '🏆',
      name: 'بطل الأسبوع',
      description: 'تعلمت لـ 7 أيام متتالية',
      category: 'مثابرة',
      isEarned: count >= 7,
      dateEarned: count >= 7 ? DateTime.now() : null,
    ),
    BadgeModel(
      id: 'letter_expert',
      icon: '🎯',
      name: 'خبير الحروف',
      description: 'أتقنت 10 حروف',
      category: 'أحرف',
      isEarned: count >= 10,
      dateEarned: count >= 10 ? DateTime.now() : null,
    ),
    BadgeModel(
      id: 'diamond',
      icon: '💎',
      name: 'الماسي',
      description: 'أتقنت جميع الحروف الـ 28',
      category: 'أحرف',
      isEarned: count >= 28,
      dateEarned: count >= 28 ? DateTime.now() : null,
    ),
  ];
});

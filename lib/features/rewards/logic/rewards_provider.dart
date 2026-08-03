import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final badgesProvider = Provider<List<BadgeModel>>((ref) {
  return [
    BadgeModel(
      id: 'explorer',
      icon: '🧭',
      name: 'المكتشف',
      description: 'أكملت اختبار تحديد المستوى بنجاح!',
      category: 'إنجازات',
      isEarned: true,
      dateEarned: DateTime.now().subtract(const Duration(days: 5)),
    ),
    BadgeModel(
      id: 'alif_star',
      icon: '⭐',
      name: 'نجم الألف',
      description: 'أتقنت الحرف الأول',
      category: 'أحرف',
      isEarned: true,
      dateEarned: DateTime.now().subtract(const Duration(days: 2)),
    ),
    BadgeModel(
      id: 'daily_flame',
      icon: '🔥',
      name: 'مشعل اليوم',
      description: 'تعلمت لـ 3 أيام متتالية',
      category: 'مثابرة',
      isEarned: true,
      dateEarned: DateTime.now(),
    ),
    const BadgeModel(
      id: 'weekly_champion',
      icon: '🏆',
      name: 'بطل الأسبوع',
      description: 'تعلمت لـ 7 أيام متتالية',
      category: 'مثابرة',
    ),
    const BadgeModel(
      id: 'little_reader',
      icon: '📚',
      name: 'قارئ صغير',
      description: 'أكملت قصتك الأولى',
      category: 'إنجازات',
    ),
    const BadgeModel(
      id: 'letter_expert',
      icon: '🎯',
      name: 'خبير الحروف',
      description: 'أتقنت 10 حروف',
      category: 'أحرف',
    ),
    const BadgeModel(
      id: 'diamond',
      icon: '💎',
      name: 'الماسي',
      description: 'أتقنت جميع الحروف الـ 28',
      category: 'أحرف',
    ),
  ];
});

final xpProvider = Provider<int>((ref) {
  return 1540;
});

final streakProvider = Provider<int>((ref) {
  return 4;
});

final progressStatsProvider = Provider<ProgressStats>((ref) {
  return const ProgressStats(
    lettersMastered: 3,
    completionPercentage: 0.15,
  );
});

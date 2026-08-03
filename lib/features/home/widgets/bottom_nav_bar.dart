import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OasisBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const OasisBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'الواحات', 'icon': Icons.map_rounded},
      {'label': 'الأبطال', 'icon': Icons.emoji_events_rounded},
      {'label': 'التقدم', 'icon': Icons.bar_chart_rounded},
      {'label': 'ملفي', 'icon': Icons.person_rounded},
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Cairo'),
          items: items.map((item) {
            final index = items.indexOf(item);
            final isSelected = index == currentIndex;
            
            Widget icon = Icon(
              item['icon'] as IconData,
              size: 32,
            );
            
            if (isSelected) {
              icon = icon.animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scaleXY(begin: 1.0, end: 1.1, duration: 400.ms);
            }

            return BottomNavigationBarItem(
              icon: icon,
              label: item['label'] as String,
            );
          }).toList(),
        ),
      ),
    );
  }
}

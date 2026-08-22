import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

// ═══ UPGRADED: baa_train_navbar.dart ═══

class BaaTrainNavBar extends StatelessWidget {
  final int activeStationIndex;
  final Function(int) onStationSelected;

  const BaaTrainNavBar({
    super.key,
    required this.activeStationIndex,
    required this.onStationSelected,
  });

  static const List<Map<String, dynamic>> stations = [
    {
      'title': 'الأهداف',
      'icon': Icons.flag_rounded,
      'color': AppColors.baaObjectivesTitle,
    },
    {
      'title': 'قصة الحرف',
      'icon': Icons.menu_book_rounded,
      'color': Color(0xFF8D6E63),
    },
    {
      'title': 'أصوات الحرف',
      'icon': Icons.volume_up_rounded,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'كتابة الحرف',
      'icon': Icons.edit_rounded,
      'color': Color(0xFFFFA000),
    },
    {
      'title': 'كلمات الحرف',
      'icon': Icons.auto_stories_rounded,
      'color': Color(0xFFE91E63),
    },
    {
      'title': 'الأنشطة',
      'icon': Icons.stars_rounded,
      'color': Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        border: const Border(
          top: BorderSide(color: Color(0xFFFFB74D), width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(stations.length, (index) {
          final s = stations[index];
          final isActive = index == activeStationIndex;
          final color = s['color'] as Color;

          return GestureDetector(
            onTap: () => onStationSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? color.withValues(alpha: 0.18) : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isActive ? color : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    s['icon'] as IconData,
                    color: isActive ? color : Colors.brown.shade400,
                    size: isActive ? 24 : 20,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s['title'] as String,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isActive ? 11 : 10,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? color : Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ═══ END OF FILE ═══

import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

/// شريط التنقل السفلي لدرس حرف الألف — الأهداف + القصة + الأصوات + الألف الممدودة + الكتابة + كلمات الحرف + ألعاب
class AlifTrainNavBar extends StatelessWidget {
  final int activeStationIndex;
  final Function(int) onStationSelected;

  const AlifTrainNavBar({
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
      'color': Color(0xFF7B1FA2),
    },
    {
      'title': 'الألف الممدودة',
      'icon': Icons.auto_awesome_rounded,
      'color': Color(0xFF00838F),
    },
    {
      'title': 'كتابة الحرف',
      'icon': Icons.edit_rounded,
      'color': Color(0xFF1976D2),
    },
    {
      'title': 'كلمات الحرف',
      'icon': Icons.abc_rounded,
      'color': Color(0xFFC62828),
    },
    {
      'title': 'ألعاب',
      'icon': Icons.sports_esports_rounded,
      'color': Color(0xFFF57C00),
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

          return Flexible(
            child: GestureDetector(
              onTap: () => onStationSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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
                      size: isActive ? 26 : 20,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        s['title'] as String,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isActive ? 12 : 10,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          color: isActive ? color : Colors.brown.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

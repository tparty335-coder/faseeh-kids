import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';
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
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final iconSize = isCompact ? 24.0 : (context.isTablet ? 30.0 : 27.0);
    final labelSize = context.scaledFont(12.5, min: 10.5, max: 14.5);

    final items = const [
      {'label': 'الْوَاحَاتُ', 'icon': Icons.map_rounded},
      {'label': 'الْأَبْطَالُ', 'icon': Icons.emoji_events_rounded},
      {'label': 'الْقِيَاسُ', 'icon': Icons.school_rounded},
      {'label': 'مَلَفِّي', 'icon': Icons.person_rounded},
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Container(
          margin: EdgeInsets.fromLTRB(
            isCompact ? 10 : 16,
            0,
            isCompact ? 10 : 16,
            isCompact ? 8 : 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(isCompact ? 20 : 24),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.14),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isCompact ? 20 : 24),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey.shade600,
              selectedFontSize: labelSize,
              unselectedFontSize: (labelSize - 1).clamp(10.0, 14.0),
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoNaskhArabic',
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'NotoNaskhArabic',
              ),
              items: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = index == currentIndex;

                Widget icon = Icon(
                  item['icon'] as IconData,
                  size: iconSize,
                );

                if (isSelected) {
                  icon = icon
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .scaleXY(begin: 1.0, end: 1.08, duration: 450.ms);
                }

                return BottomNavigationBarItem(
                  icon: icon,
                  label: item['label'] as String,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

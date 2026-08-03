import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BadgeCard extends StatelessWidget {
  final String icon;
  final String name;
  final String description;
  final bool isEarned;
  final DateTime? dateEarned;

  const BadgeCard({
    super.key,
    required this.icon,
    required this.name,
    required this.description,
    this.isEarned = false,
    this.dateEarned,
  });

  Widget _buildIconWidget(BuildContext context, double size) {
    IconData iconData;
    Color iconColor;

    switch (icon) {
      case 'explorer':
      case '🧭':
        iconData = Icons.explore_rounded;
        iconColor = Colors.teal;
        break;
      case 'alif_star':
      case '⭐':
        iconData = Icons.star_rounded;
        iconColor = Colors.amber;
        break;
      case 'daily_flame':
      case '🔥':
        iconData = Icons.local_fire_department_rounded;
        iconColor = Colors.deepOrange;
        break;
      case 'weekly_champion':
      case '🏆':
        iconData = Icons.emoji_events_rounded;
        iconColor = Colors.amber;
        break;
      case 'little_reader':
      case '📚':
        iconData = Icons.menu_book_rounded;
        iconColor = Colors.indigo;
        break;
      case 'letter_expert':
      case '🎯':
        iconData = Icons.track_changes_rounded;
        iconColor = Colors.redAccent;
        break;
      case 'diamond':
      case '💎':
        iconData = Icons.diamond_rounded;
        iconColor = Colors.cyan;
        break;
      default:
        iconData = Icons.verified_rounded;
        iconColor = AppColors.primaryDay;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: iconColor.withValues(alpha: 0.15),
      ),
      child: Icon(iconData, color: iconColor, size: size * 0.6),
    );
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: AppColors.surface,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconWidget(context, 80)
                  .animate()
                  .scale(duration: 400.ms, curve: Curves.elasticOut),
              const SizedBox(height: 16),
              Text(
                name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              if (isEarned && dateEarned != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'تاريخ الحصول: ${dateEarned!.year}/${dateEarned!.month}/${dateEarned!.day}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'حسناً',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardSize = (MediaQuery.sizeOf(context).width * 0.25).clamp(80.0, 120.0);

    return GestureDetector(
      onTap: () => _showDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: isEarned ? AppColors.surface : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: isEarned
              ? Border.all(color: Colors.amber, width: 2)
              : null,
          boxShadow: isEarned
              ? [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ColorFiltered(
                  colorFilter: isEarned
                      ? const ColorFilter.mode(Colors.transparent, BlendMode.dst)
                      : const ColorFilter.matrix(<double>[
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0,      0,      0,      1, 0,
                        ]),
                  child: _buildIconWidget(context, cardSize * 0.45),
                ),
                if (!isEarned)
                  Icon(
                    Icons.lock,
                    color: Colors.black.withValues(alpha: 0.5),
                    size: 24,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isEarned ? AppColors.textPrimary : Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ).animate(target: isEarned ? 1 : 0).shimmer(duration: const Duration(seconds: 2)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

class FaseehCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool hasGradientBorder;

  const FaseehCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.hasGradientBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCream,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (hasGradientBorder) {
      cardContent = Container(
        padding: const EdgeInsets.all(2), // border width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [AppColors.primaryDay, AppColors.gold],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: cardContent,
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

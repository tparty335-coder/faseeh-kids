import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

enum MascotExpression { happy, thinking, celebrating, encouraging }

class MascotWidget extends StatelessWidget {
  final MascotExpression expression;
  final String? speechText;

  const MascotWidget({
    super.key,
    this.expression = MascotExpression.happy,
    this.speechText,
  });

  String get _assetPath {
    switch (expression) {
      case MascotExpression.happy:
        return 'assets/images/mascot/falcon_happy.jpg';
      case MascotExpression.thinking:
        return 'assets/images/mascot/falcon_thinking.jpg';
      case MascotExpression.celebrating:
        return 'assets/images/mascot/falcon_celebrating.jpg';
      case MascotExpression.encouraging:
        return 'assets/images/mascot/falcon_encouraging.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final mascotSize = (screenWidth * 0.25).clamp(80.0, 140.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (speechText != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20).copyWith(
                bottomRight: const Radius.circular(0),
              ),
              border: Border.all(color: AppColors.gold, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              speechText!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ).animate().scale(delay: const Duration(milliseconds: 300)),
          const SizedBox(height: 8),
        ],
        Container(
          width: mascotSize,
          height: mascotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryDay.withValues(alpha: 0.2),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              _assetPath,
              fit: BoxFit.cover,
            ),
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .slideY(begin: 0, end: -0.06, duration: 1500.ms, curve: Curves.easeInOut)
            .scaleXY(begin: 1.0, end: 1.03, duration: 1500.ms),
      ],
    );
  }
}

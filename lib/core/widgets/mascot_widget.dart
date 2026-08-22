import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

enum MascotState {
  happy,
  thinking,
  encouraging,
  celebrating,
}

class MascotWidget extends StatelessWidget {
  final MascotState state;
  final double width;
  final double height;
  final bool showBackground;

  const MascotWidget({
    super.key,
    this.state = MascotState.happy,
    this.width = 150,
    this.height = 150,
    this.showBackground = true,
  });

  String get _assetPath {
    switch (state) {
      case MascotState.happy:
        return 'assets/images/characters/falcon/falcon_mascot_happy.png';
      case MascotState.thinking:
        return 'assets/images/characters/falcon/falcon_thinking.png';
      case MascotState.encouraging:
        return 'assets/images/characters/falcon/falcon_encouraging.png';
      case MascotState.celebrating:
        return 'assets/images/characters/falcon/falcon_celebrating.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mascot = Image.asset(
      _assetPath,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.pets_rounded,
        size: width * 0.7,
        color: AppColors.oasisGreen,
      ),
    );

    if (showBackground) {
      mascot = Container(
        padding: EdgeInsets.all(width * 0.15),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.desertSand.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: mascot,
      );
    }

    // Breathing Animation
    return mascot
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(end: 1.05, duration: 2.seconds, curve: Curves.easeInOut)
        .moveY(end: -5, duration: 2.seconds, curve: Curves.easeInOut);
  }
}

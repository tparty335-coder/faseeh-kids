import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

enum NodeStatus { locked, current, completed }

class OasisNode extends StatelessWidget {
  final String letter;
  final NodeStatus status;
  final bool isPremiumLocked;
  final VoidCallback? onTap;

  const OasisNode({
    super.key,
    required this.letter,
    required this.status,
    this.isPremiumLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrent = status == NodeStatus.current;
    final bool isLocked = status == NodeStatus.locked;
    final bool isCompleted = status == NodeStatus.completed;

    final double nodeSize = (MediaQuery.sizeOf(context).width * 0.18).clamp(64.0, 96.0);

    Widget node = GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        width: nodeSize,
        height: nodeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isLocked ? Colors.grey.shade300 : AppColors.surface,
          border: Border.all(
            color: isCompleted 
                ? AppColors.success 
                : (isCurrent ? AppColors.accent : Colors.grey.shade400),
            width: isCurrent ? 4 : 2,
          ),
          boxShadow: isCurrent ? [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.6),
              blurRadius: 15,
              spreadRadius: 5,
            )
          ] : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Oasis background decoration (pool/sand)
            if (!isLocked)
              Container(
                width: nodeSize * 0.75,
                height: nodeSize * 0.75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.2), // Water pool effect
                ),
              ),
            Text(
              letter,
              style: TextStyle(
                fontSize: nodeSize * 0.4,
                fontWeight: FontWeight.bold,
                color: isLocked ? Colors.grey.shade500 : AppColors.textPrimary,
                fontFamily: 'Cairo',
              ),
            ),
            if (isCompleted && !isPremiumLocked)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
            if (isPremiumLocked && !isLocked)
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
                  ),
                  child: const Icon(Icons.lock_rounded, color: Color(0xFFFFD700), size: 14),
                ),
              ),
            if (isCurrent)
              Positioned(
                top: -nodeSize * 0.3,
                child: Container(
                  width: nodeSize * 0.4,
                  height: nodeSize * 0.4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/mascot/falcon_happy.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (isCurrent) {
      node = node.animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scaleXY(begin: 1.0, end: 1.05, duration: 800.ms);
    } else if (!isLocked) {
      node = node.animate().shimmer(duration: 2.seconds, delay: 1.seconds);
    }

    return node;
  }
}

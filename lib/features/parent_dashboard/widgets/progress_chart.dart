import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProgressChart extends StatefulWidget {
  final List<double> weeklyMinutes; // Length 7, Sat-Fri

  const ProgressChart({
    super.key,
    required this.weeklyMinutes,
  });

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  @override
  Widget build(BuildContext context) {
    final maxMinutes = widget.weeklyMinutes.isEmpty
        ? 1.0
        : widget.weeklyMinutes.reduce((a, b) => a > b ? a : b);
    final chartMax = maxMinutes < 10 ? 10.0 : maxMinutes * 1.2;
    
    final days = ['السبت', 'الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          final minutes = index < widget.weeklyMinutes.length ? widget.weeklyMinutes[index] : 0.0;
          final heightFactor = minutes / chartMax;
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${minutes.toInt()}',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Container(
                width: 24,
                height: 120 * heightFactor,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ).animate().scaleY(
                duration: 500.ms,
                curve: Curves.easeOutBack,
                alignment: Alignment.bottomCenter,
              ),
              const SizedBox(height: 8),
              Text(
                days[index],
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';

class TraceActivityScreen extends ConsumerStatefulWidget {
  const TraceActivityScreen({super.key});

  @override
  ConsumerState<TraceActivityScreen> createState() => _TraceActivityScreenState();
}

class _TraceActivityScreenState extends ConsumerState<TraceActivityScreen> {
  late ConfettiController _confettiController;
  final List<Offset> _points = [];
  int _tracesCompleted = 0;
  final int _requiredTraces = 3;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _points.add(details.localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Simple validation (can be replaced with actual path validation)
    if (_points.length > 20) {
      setState(() {
        _tracesCompleted++;
        _points.clear();
      });
      
      if (_tracesCompleted >= _requiredTraces) {
        _confettiController.play();
        AudioManager.instance.playFeedback('wonderful');
        ref.read(currentLessonProvider.notifier).completeCurrentActivity();
      }
    } else {
      setState(() {
        _points.clear(); // Reset if didn't trace enough
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اكتب الحرف ($_tracesCompleted/$_requiredTraces)',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.desertSand),
            ),
            const SizedBox(height: 40),
            
            // Tracing Canvas
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: GestureDetector(
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  painter: _TracePainter(letter: letter.letter, points: _points),
                  size: const Size(300, 300),
                ),
              ),
            ),
            
            const Spacer(),
            
            if (_tracesCompleted >= _requiredTraces)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.oasisGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    ref.read(currentLessonProvider.notifier).nextActivity();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('التالي', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 20),
                    ],
                  ),
                ).animate().scale(duration: 300.ms),
              ),
          ],
        ),
        
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [AppColors.oasisGreen, AppColors.desertSand, AppColors.skyBlue],
        ),
      ],
    );
  }
}

class _TracePainter extends CustomPainter {
  final String letter;
  final List<Offset> points;

  _TracePainter({required this.letter, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the letter outline
    final textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          fontSize: 200,
          color: Colors.grey.withValues(alpha: 0.2),
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.rtl,
    );
    
    textPainter.layout();
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);

    // Draw the tracing trail
    if (points.isNotEmpty) {
      final paint = Paint()
        ..color = AppColors.oasisGreen
        ..strokeWidth = 12.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);
      
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TracePainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.letter != letter;
  }
}

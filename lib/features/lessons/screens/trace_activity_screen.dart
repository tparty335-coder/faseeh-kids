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
  static const int _maxPointsCap = 250; // Memory leak prevention cap
  int _tracesCompleted = 0;
  final int _requiredTraces = 3;
  bool _isInvalidTrace = false;

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

  void _onPanUpdate(DragUpdateDetails details, Size canvasSize, double guideFontSize, String letter) {
    if (_points.length >= _maxPointsCap) return; // Prevent OOM from infinite scribbling

    setState(() {
      _points.add(details.localPosition);
      _isInvalidTrace = false;
    });
  }

  void _onPanEnd(DragEndDetails details, Size canvasSize, double guideFontSize, String letter) {
    if (_points.length < 10) {
      // Stroke too short to be a letter trace
      setState(() {
        _points.clear();
      });
      return;
    }

    final isValid = _validateTracingCoverage(
      letterChar: letter,
      canvasSize: canvasSize,
      guideFontSize: guideFontSize,
    );

    if (isValid) {
      setState(() {
        _tracesCompleted++;
        _points.clear();
        _isInvalidTrace = false;
      });

      if (_tracesCompleted >= _requiredTraces) {
        _confettiController.play();
        AudioManager.instance.playFeedback('wonderful');
        ref.read(currentLessonProvider.notifier).completeCurrentActivity();
      } else {
        AudioManager.instance.playFeedback('correct');
      }
    } else {
      // Failed tracing validation (scribbled outside bounds)
      setState(() {
        _points.clear();
        _isInvalidTrace = true;
      });
      AudioManager.instance.playFeedback('try_again');
    }
  }

  /// Geometric Hit-Testing Validation
  /// Computes bounding box of the rendered letter text and verifies:
  /// 1. High ratio (> 55%) of drawn points fall within the letter's hit box
  /// 2. Sufficient point density inside the hit zone
  bool _validateTracingCoverage({
    required String letterChar,
    required Size canvasSize,
    required double guideFontSize,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: letterChar,
        style: TextStyle(
          fontSize: guideFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.rtl,
    );

    textPainter.layout();

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    // Centered offset of the letter within the canvas
    final leftMargin = (canvasSize.width - textWidth) / 2;
    final topMargin = (canvasSize.height - textHeight) / 2;

    // Expand bounding box with tolerance radius (stroke width + margin)
    const double tolerance = 24.0;
    final hitBox = Rect.fromLTRB(
      leftMargin - tolerance,
      topMargin - tolerance,
      leftMargin + textWidth + tolerance,
      topMargin + textHeight + tolerance,
    );

    int insideHitBoxCount = 0;

    for (final point in _points) {
      if (hitBox.contains(point)) {
        insideHitBoxCount++;
      }
    }

    final hitRatio = insideHitBoxCount / _points.length;

    // Valid if at least 55% of points fall inside letter bounds and has >= 10 hit points
    return hitRatio >= 0.55 && insideHitBoxCount >= 10;
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    final screenWidth = MediaQuery.sizeOf(context).width;
    final canvasSizeValue = (screenWidth * 0.7).clamp(200.0, 360.0);
    final canvasSize = Size(canvasSizeValue, canvasSizeValue);
    final guideFontSize = (canvasSizeValue * 0.65).clamp(100.0, 240.0);

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اكتب الحرف ($_tracesCompleted/$_requiredTraces)',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.desertSand,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 20),

            if (_isInvalidTrace)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'حاول تتبع الحرف بدقة داخل الحدود! ✏️',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ).animate().shake(duration: 400.ms),

            const SizedBox(height: 20),

            // Tracing Canvas — responsive with Hit-Testing & Memory Cap
            Container(
              width: canvasSizeValue,
              height: canvasSizeValue,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: _isInvalidTrace
                    ? Border.all(color: Colors.deepOrange, width: 3)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: GestureDetector(
                onPanUpdate: (details) => _onPanUpdate(details, canvasSize, guideFontSize, letter.letter),
                onPanEnd: (details) => _onPanEnd(details, canvasSize, guideFontSize, letter.letter),
                child: CustomPaint(
                  painter: _TracePainter(
                    letter: letter.letter,
                    points: _points,
                    guideFontSize: guideFontSize,
                  ),
                  size: canvasSize,
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
  final double guideFontSize;

  _TracePainter({required this.letter, required this.points, required this.guideFontSize});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the letter outline
    final textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          fontSize: guideFontSize,
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
        ..strokeWidth = 14.0
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


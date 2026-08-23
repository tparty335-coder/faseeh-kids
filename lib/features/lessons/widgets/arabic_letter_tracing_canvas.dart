import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// تعريف مقطع كتابة الحرف (Stroke)
class LetterStroke {
  final int index;
  final String label; // "١", "٢", "٣", "٤"
  final Offset start; // Normalized (0.0 to 1.0)
  final Offset end;   // Normalized (0.0 to 1.0)
  final List<Offset> pathPoints; // Normalized path points
  final String hintText;
  final bool isTapOnly;
  final double strokeWidth; // عرض الخط - قابل للتخصيص لكل مقطع

  const LetterStroke({
    required this.index,
    required this.label,
    required this.start,
    required this.end,
    required this.pathPoints,
    required this.hintText,
    this.isTapOnly = false,
    this.strokeWidth = 22.0,
  });
}

/// بيانات مقاطع الحروف العربية ومواضعها بدقة متناهية
class ArabicLetterTracingData {
  static List<LetterStroke> getStrokesForLetter(String letter, {String position = 'isolated'}) {
    if (letter == 'ب') {
      return _getBaaStrokes(position);
    }
    return _getAlifStrokes(position);
  }

  // ─── مقاطع حرف الألف (أ) ───────────────────────────────────────────
  //
  //  الألف مكوّنة من جزأين:
  //  ① عصا الألف: خط عمودي من الأعلى للأسفل
  //  ② الهمزة (ء): قوس كبير يبدأ من اليسار، يصعد لليمين ثم ينزل
  //     + ذيل الهمزة: خط أفقي قصير
  //
  //  المقاسات المثالية على لوحة 300×340 px (نسب مئوية):
  //  - الهمزة تمتد من x=0.22 إلى x=0.76 = 54% = 162px (واضحة كفاية)
  //  - الهمزة ارتفاعها من y=0.02 إلى y=0.26 = 24% = 82px
  // ──────────────────────────────────────────────────────────────────────
  static List<LetterStroke> _getAlifStrokes(String position) {

    // ─── الهمزة مشتركة في كل المواضع (فقط موضعها على المحور Y يختلف) ───
    // قوس الهمزة الرئيسي: يبدأ من أسفل-اليسار، يصعد لليمين ثم ينزل
    // هكذا يرسم أطفال المدارس حرف الهمزة:
    // ابدأ من اليسار (منتصف الهمزة)، صعوداً لليمين، ثم دوران لأسفل-اليسار

    if (position == 'middle' || position == 'end') {
      // ─── الألف المتصلة (ـأ) ───
      return [
        // ① خط الاتصال من اليمين لليسار (ـ)
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.88, 0.82),
          end: const Offset(0.50, 0.82),
          pathPoints: [
            const Offset(0.88, 0.82),
            const Offset(0.68, 0.82),
            const Offset(0.50, 0.82),
          ],
          hintText: '① ابدأ من اليمين واسحب خط الاتصال ⬅️',
          strokeWidth: 20.0,
        ),
        // ② عصا الألف صاعدة للأعلى (ا)
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.50, 0.82),
          end: const Offset(0.50, 0.28),
          pathPoints: [
            const Offset(0.50, 0.82),
            const Offset(0.50, 0.55),
            const Offset(0.50, 0.28),
          ],
          hintText: '② من النقطة ② اصعد بعصا الألف للأعلى ⬆️',
          strokeWidth: 20.0,
        ),
        // ③ قوس ورأس الهمزة (من اليمين للأعلى ثم نزول لأسفل)
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.58, 0.09),
          end: const Offset(0.47, 0.17),
          pathPoints: [
            const Offset(0.58, 0.09),
            const Offset(0.53, 0.05),
            const Offset(0.47, 0.05),
            const Offset(0.47, 0.17),
          ],
          hintText: '③ ابدأ من اليمين ودوّر قوس الهمزة لأسفل ↶',
          strokeWidth: 16.0,
        ),
        // ④ قاعدة وخط الهمزة الأفقي (من اليمين لليسار)
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.64, 0.17),
          end: const Offset(0.34, 0.17),
          pathPoints: [
            const Offset(0.64, 0.17),
            const Offset(0.49, 0.17),
            const Offset(0.34, 0.17),
          ],
          hintText: '④ من النقطة ④ اسحب خط الهمزة الأفقي لليسار ⬅️',
          strokeWidth: 16.0,
        ),
      ];
    }

    // ─── الألف المنفصلة أو أول الكلمة (أ) ───
    return [
      // ① عصا الألف (من الأعلى إلى الأسفل)
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.50, 0.28),
        end: const Offset(0.50, 0.88),
        pathPoints: [
          const Offset(0.50, 0.28),
          const Offset(0.50, 0.48),
          const Offset(0.50, 0.68),
          const Offset(0.50, 0.88),
        ],
        hintText: '① ابدأ من أعلى واسحب عصا الألف لأسفل ⬇️',
        strokeWidth: 20.0,
      ),
      // ② قوس ورأس الهمزة (من اليمين للأعلى ثم نزول لأسفل)
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.58, 0.09),
        end: const Offset(0.47, 0.17),
        pathPoints: [
          const Offset(0.58, 0.09),
          const Offset(0.53, 0.05),
          const Offset(0.47, 0.05),
          const Offset(0.47, 0.17),
        ],
        hintText: '② ابدأ من اليمين ودوّر قوس الهمزة لأسفل ↶',
        strokeWidth: 16.0,
      ),
      // ③ قاعدة وخط الهمزة الأفقي (من اليمين لليسار)
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.64, 0.17),
        end: const Offset(0.34, 0.17),
        pathPoints: [
          const Offset(0.64, 0.17),
          const Offset(0.49, 0.17),
          const Offset(0.34, 0.17),
        ],
        hintText: '③ من النقطة ③ اسحب خط الهمزة الأفقي لليسار ⬅️',
        strokeWidth: 16.0,
      ),
    ];
  }

  // ─── مقاطع حرف الباء ───
  static List<LetterStroke> _getBaaStrokes(String position) {
    if (position == 'start') {
      // الباء في أول الكلمة (بـ)
      return [
        // 1. السنّة اليمنى هبوطاً
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.80, 0.42),
          end: const Offset(0.80, 0.65),
          pathPoints: [
            const Offset(0.80, 0.42),
            const Offset(0.80, 0.54),
            const Offset(0.80, 0.65),
          ],
          hintText: 'ابدأ من النقطة (١) وانزل بالسنّة اليمنى ⬇️',
        ),
        // 2. خط الاتصال لليسار
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.80, 0.65),
          end: const Offset(0.20, 0.65),
          pathPoints: [
            const Offset(0.80, 0.65),
            const Offset(0.60, 0.65),
            const Offset(0.40, 0.65),
            const Offset(0.20, 0.65),
          ],
          hintText: 'من النقطة (٢) اسحب خط الاتصال لليسار ⬅️',
        ),
        // 3. نقطة الباء
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.50, 0.82),
          end: const Offset(0.50, 0.82),
          pathPoints: [const Offset(0.50, 0.82)],
          hintText: 'اضغط على النقطة (٣) لوضع نقطة الباء •',
          isTapOnly: true,
        ),
      ];
    } else if (position == 'middle') {
      // الباء في وسط الكلمة (ـبـ)
      return [
        // 1. خط الاتصال الأيمن
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.85, 0.65),
          end: const Offset(0.50, 0.65),
          pathPoints: [
            const Offset(0.85, 0.65),
            const Offset(0.68, 0.65),
            const Offset(0.50, 0.65),
          ],
          hintText: 'ابدأ من النقطة (١) واسحب خط الاتصال ⬅️',
        ),
        // 2. سنّة الباء الوسطى
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.50, 0.65),
          end: const Offset(0.50, 0.42),
          pathPoints: [
            const Offset(0.50, 0.65),
            const Offset(0.50, 0.42),
          ],
          hintText: 'من النقطة (٢) ارفع سنّة الباء للأعلى ⬆️',
        ),
        // 3. خط الاتصال الأيسر
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.50, 0.65),
          end: const Offset(0.15, 0.65),
          pathPoints: [
            const Offset(0.50, 0.65),
            const Offset(0.32, 0.65),
            const Offset(0.15, 0.65),
          ],
          hintText: 'من النقطة (٣) اسحب خط الاتصال لليسار ⬅️',
        ),
        // 4. نقطة الباء
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.50, 0.82),
          end: const Offset(0.50, 0.82),
          pathPoints: [const Offset(0.50, 0.82)],
          hintText: 'اضغط على النقطة (٤) لوضع نقطة الباء •',
          isTapOnly: true,
        ),
      ];
    }

    // الباء الكاملة المنفصلة (ب)
    return [
      // 1. السنّة اليمنى هبوطاً
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.82, 0.45),
        end: const Offset(0.82, 0.65),
        pathPoints: [
          const Offset(0.82, 0.45),
          const Offset(0.82, 0.55),
          const Offset(0.82, 0.65),
        ],
        hintText: 'ابدأ من النقطة (١) وانزل بالسنّة اليمنى ⬇️',
      ),
      // 2. جسم الباء الأفقي
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.82, 0.65),
        end: const Offset(0.18, 0.65),
        pathPoints: [
          const Offset(0.82, 0.65),
          const Offset(0.60, 0.65),
          const Offset(0.40, 0.65),
          const Offset(0.18, 0.65),
        ],
        hintText: 'من النقطة (٢) اسحب جسم الباء لليسار ⬅️',
      ),
      // 3. السنّة اليسرى صعوداً
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.18, 0.65),
        end: const Offset(0.18, 0.45),
        pathPoints: [
          const Offset(0.18, 0.65),
          const Offset(0.18, 0.55),
          const Offset(0.18, 0.45),
        ],
        hintText: 'من النقطة (٣) ارفع السنّة اليسرى للأعلى ⬆️',
      ),
      // 4. نقطة الباء بالأسفل
      LetterStroke(
        index: 4,
        label: '٤',
        start: const Offset(0.50, 0.82),
        end: const Offset(0.50, 0.82),
        pathPoints: [const Offset(0.50, 0.82)],
        hintText: 'اضغط على النقطة (٤) لوضع نقطة الباء •',
        isTapOnly: true,
      ),
    ];
  }
}

/// لوحة تتبع وكتابة الحرف العربي بأسلوب لينغو بنانا التفاعلي
class ArabicLetterTracingCanvas extends StatefulWidget {
  final String letterChar;
  final String position; // 'isolated', 'start', 'middle', 'end'
  final String exampleWord;
  final String exampleEmoji;
  final VoidCallback? onComplete;
  final Color primaryColor;

  const ArabicLetterTracingCanvas({
    super.key,
    required this.letterChar,
    this.position = 'isolated',
    this.exampleWord = 'أَسَد',
    this.exampleEmoji = '🦁',
    this.onComplete,
    this.primaryColor = const Color(0xFF673AB7), // Purple theme matching Lingo Banana
  });


  @override
  State<ArabicLetterTracingCanvas> createState() =>
      _ArabicLetterTracingCanvasState();
}

class _ArabicLetterTracingCanvasState extends State<ArabicLetterTracingCanvas>
    with SingleTickerProviderStateMixin {
  late List<LetterStroke> _strokes;
  int _currentStrokeIndex = 0;
  final List<List<Offset>> _completedStrokePaths = [];
  final List<Offset> _currentDrawingPoints = [];
  int _highestReachedPointIndex = 0;
  bool _isDrawing = false;
  bool _isWrongStartShake = false;
  bool _isAllCompleted = false;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _strokes = ArabicLetterTracingData.getStrokesForLetter(
      widget.letterChar,
      position: widget.position,
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant ArabicLetterTracingCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.letterChar != widget.letterChar ||
        oldWidget.position != widget.position) {
      setState(() {
        _strokes = ArabicLetterTracingData.getStrokesForLetter(
          widget.letterChar,
          position: widget.position,
        );
        _resetCanvas();
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _resetCanvas() {
    setState(() {
      _currentStrokeIndex = 0;
      _completedStrokePaths.clear();
      _currentDrawingPoints.clear();
      _highestReachedPointIndex = 0;
      _isDrawing = false;
      _isWrongStartShake = false;
      _isAllCompleted = false;
    });
  }

  void _onPanStart(DragStartDetails details, Size canvasSize) {
    if (_isAllCompleted || _currentStrokeIndex >= _strokes.length) return;

    final stroke = _strokes[_currentStrokeIndex];
    final guidePx = stroke.pathPoints.map((p) => Offset(
      p.dx * canvasSize.width,
      p.dy * canvasSize.height,
    )).toList();

    if (guidePx.isEmpty) return;

    final startPx = guidePx.first;
    final touchPos = details.localPosition;
    final distToStart = (touchPos - startPx).distance;

    // دائرة التسامح لبداية النقطة (Tolerance radius = 65px للأطفال)
    bool isNearStart = distToStart <= 65.0;

    // التحقق أيضاً مما إذا كان اللمس قريباً من النقطة الثانية في المسار
    if (!isNearStart && guidePx.length > 1) {
      if ((touchPos - guidePx[1]).distance <= 60.0) {
        isNearStart = true;
      }
    }

    if (isNearStart) {
      if (stroke.isTapOnly) {
        _completeCurrentStroke([startPx]);
        return;
      }
      setState(() {
        _isDrawing = true;
        _isWrongStartShake = false;
        _currentDrawingPoints.clear();
        _currentDrawingPoints.add(startPx);
        _highestReachedPointIndex = 0;
      });
    } else {
      // لمس نقطة خاطئة أو بعيدة عن النقطة المحددة
      setState(() {
        _isWrongStartShake = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _isWrongStartShake = false);
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details, Size canvasSize) {
    if (!_isDrawing || _isAllCompleted || _currentStrokeIndex >= _strokes.length) return;

    final touchPos = details.localPosition;
    final stroke = _strokes[_currentStrokeIndex];
    final guidePx = stroke.pathPoints.map((p) => Offset(
      p.dx * canvasSize.width,
      p.dy * canvasSize.height,
    )).toList();

    if (guidePx.isEmpty) return;

    // التحقق من التقدم على المسار
    for (int i = _highestReachedPointIndex + 1; i < guidePx.length; i++) {
      final target = guidePx[i];
      final distToTarget = (touchPos - target).distance;
      if (distToTarget <= 65.0) {
        _highestReachedPointIndex = i;
      }
    }

    setState(() {
      _currentDrawingPoints.add(touchPos);
    });

    // هل وصل لنهاية المقطع أو اقترب من النقطة الأخيرة؟
    final distToEnd = (touchPos - guidePx.last).distance;
    if (_highestReachedPointIndex >= guidePx.length - 1 || distToEnd <= 55.0) {
      _completeCurrentStroke(guidePx);
    }
  }

  void _onPanEnd(DragEndDetails details, Size canvasSize) {
    if (!_isDrawing) return;

    final stroke = _strokes[_currentStrokeIndex];
    final guidePx = stroke.pathPoints.map((p) => Offset(
      p.dx * canvasSize.width,
      p.dy * canvasSize.height,
    )).toList();

    if (guidePx.isEmpty) return;

    // إذا قطع التلميذ نصف المسار أو وصل لأكثر من نقطة، نعتبره مكتملاً ونسحبه للنهاية
    if (_highestReachedPointIndex >= (guidePx.length / 2).floor() || guidePx.length <= 2) {
      _completeCurrentStroke(guidePx);
    } else {
      // لم يكمل المقطع بشكل كافٍ -> إعادة المحاولة لهذا المقطع
      setState(() {
        _currentDrawingPoints.clear();
        _highestReachedPointIndex = 0;
        _isDrawing = false;
      });
    }
  }

  void _completeCurrentStroke(List<Offset> guidePx) {
    AudioService.instance.playAsset('audio/stories/alif_correct.mp3');

    setState(() {
      _completedStrokePaths.add(List.from(guidePx));
      _currentDrawingPoints.clear();
      _highestReachedPointIndex = 0;
      _isDrawing = false;
      _currentStrokeIndex++;

      if (_currentStrokeIndex >= _strokes.length) {
        _isAllCompleted = true;
        AudioService.instance.playAsset('audio/feedback/champion.mp3');
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stroke = _currentStrokeIndex < _strokes.length
        ? _strokes[_currentStrokeIndex]
        : null;

    final currentHint = _isAllCompleted
        ? 'مُمْتَازٌ! كَتَبْتَ حَرْفَ (${widget.letterChar}) بِنَجَاحٍ! 🎉'
        : (stroke?.hintText ?? '');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── 1. شريط الكبسولة العلوي (مثل لينغو بنانا: 1/26 🍎 APPLE) ───
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: widget.primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: widget.primaryColor.withValues(alpha: 0.4), width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.oasisGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '١ / ٢٨',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${widget.exampleEmoji} ${widget.exampleWord}',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: widget.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ─── 2. إطار رسم الحرف المتوهج (Lingo Banana Canvas Box) ───
          Center(
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: 320,
                  height: 340,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D144B), // خلفية بنفسجية داكنة فاخرة
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: _isWrongStartShake
                          ? Colors.redAccent
                          : Colors.white.withValues(alpha: 0.85),
                      width: _isWrongStartShake ? 3.5 : 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isWrongStartShake
                            ? Colors.redAccent.withValues(alpha: 0.4)
                            : widget.primaryColor.withValues(alpha: 0.35),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: child,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size = Size(constraints.maxWidth, constraints.maxHeight);

                    return GestureDetector(
                      onPanStart: (details) => _onPanStart(details, size),
                      onPanUpdate: (details) => _onPanUpdate(details, size),
                      onPanEnd: (details) => _onPanEnd(details, size),
                      child: CustomPaint(
                        size: size,
                        painter: _ArabicLetterPainter(
                          strokes: _strokes,
                          currentStrokeIndex: _currentStrokeIndex,
                          completedStrokePaths: _completedStrokePaths,
                          currentDrawingPoints: _currentDrawingPoints,
                          pulseValue: _pulseController.value,
                          isAllCompleted: _isAllCompleted,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ─── 3. شريط التوجيه التفاعلي أسفل الإطار ───
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: _isAllCompleted
                  ? AppColors.oasisGreen.withValues(alpha: 0.15)
                  : (_isWrongStartShake
                      ? Colors.red.withValues(alpha: 0.15)
                      : widget.primaryColor.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isAllCompleted
                    ? AppColors.oasisGreen
                    : (_isWrongStartShake ? Colors.red : widget.primaryColor.withValues(alpha: 0.3)),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isAllCompleted
                      ? Icons.check_circle_rounded
                      : (_isWrongStartShake
                          ? Icons.warning_amber_rounded
                          : Icons.touch_app_rounded),
                  color: _isAllCompleted
                      ? AppColors.oasisGreen
                      : (_isWrongStartShake ? Colors.red : widget.primaryColor),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    currentHint,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _isAllCompleted
                          ? AppColors.oasisGreen
                          : (_isWrongStartShake ? Colors.red : AppColors.textPrimaryDay),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (_isAllCompleted) ...[
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _resetCanvas,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text(
                'إِعَادَةُ الْكِتَابَةِ',
                style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: widget.primaryColor,
                side: BorderSide(color: widget.primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// الرسام المخصص لمسارات وأسهم ونقاط الحرف العربي
class _ArabicLetterPainter extends CustomPainter {
  final List<LetterStroke> strokes;
  final int currentStrokeIndex;
  final List<List<Offset>> completedStrokePaths;
  final List<Offset> currentDrawingPoints;
  final double pulseValue;
  final bool isAllCompleted;

  _ArabicLetterPainter({
    required this.strokes,
    required this.currentStrokeIndex,
    required this.completedStrokePaths,
    required this.currentDrawingPoints,
    required this.pulseValue,
    required this.isAllCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ── 1. رسم المسار الشفاف العريض (Guide Track) — كل مقطع بعرضه ──
    for (final stroke in strokes) {
      final points = stroke.pathPoints.map((p) => Offset(p.dx * size.width, p.dy * size.height)).toList();
      if (points.length == 1) {
        canvas.drawCircle(points.first, 18.0, Paint()..color = Colors.white.withValues(alpha: 0.16));
      } else if (points.isNotEmpty) {
        final trackPaint = Paint()
          ..color = Colors.white.withValues(alpha: 0.16)
          ..strokeWidth = stroke.strokeWidth + 16.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        final path = Path();
        path.moveTo(points.first.dx, points.first.dy);
        for (int i = 1; i < points.length; i++) {
          path.lineTo(points[i].dx, points[i].dy);
        }
        canvas.drawPath(path, trackPaint);
      }
    }

    // ── 2. رسم الخط المنقط المركزي والأسهم التوجيهية ──
    for (int sIdx = 0; sIdx < strokes.length; sIdx++) {
      final stroke = strokes[sIdx];
      final points = stroke.pathPoints.map((p) => Offset(p.dx * size.width, p.dy * size.height)).toList();

      final dashPaint = Paint()
        ..color = (sIdx == currentStrokeIndex)
            ? Colors.cyanAccent.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.35)
        ..strokeWidth = 3.5
        ..style = PaintingStyle.stroke;

      if (points.length == 1) {
        canvas.drawCircle(
          points.first,
          10.0,
          dashPaint..style = PaintingStyle.stroke..strokeWidth = 2.5,
        );
      } else {
        _drawDashedPolyline(canvas, points, dashPaint);
        if (points.length >= 2) {
          final last = points.last;
          final prev = points[points.length - 2];
          final angle = (last - prev).direction;
          _drawArrowHead(canvas, last, angle, dashPaint.color);
        }
      }
    }

    // ── 3. رسم المقاطع المكتملة — كل مقطع بعرضه الخاص ──
    final baseColor = isAllCompleted ? const Color(0xFF00E676) : const Color(0xFFFFB300);
    for (int i = 0; i < completedStrokePaths.length; i++) {
      final pathPoints = completedStrokePaths[i];
      final sw = (i < strokes.length) ? strokes[i].strokeWidth : 22.0;
      final completedPaint = Paint()
        ..color = baseColor
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      if (pathPoints.length == 1) {
        canvas.drawCircle(pathPoints.first, sw * 0.6, Paint()..color = baseColor);
      } else if (pathPoints.isNotEmpty) {
        final p = Path();
        p.moveTo(pathPoints.first.dx, pathPoints.first.dy);
        for (int j = 1; j < pathPoints.length; j++) {
          p.lineTo(pathPoints[j].dx, pathPoints[j].dy);
        }
        canvas.drawPath(p, completedPaint);
      }
    }


    // ── 4. رسم الخط الحالي أثناء السحب بإصبع التلميذ ──
    if (currentDrawingPoints.isNotEmpty) {
      final activeDrawingPaint = Paint()
        ..color = const Color(0xFFFFC107)
        ..strokeWidth = 34.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      if (currentDrawingPoints.length == 1) {
        canvas.drawCircle(currentDrawingPoints.first, 15.0, Paint()..color = const Color(0xFFFFC107));
      } else {
        final p = Path();
        p.moveTo(currentDrawingPoints.first.dx, currentDrawingPoints.first.dy);
        for (int i = 1; i < currentDrawingPoints.length; i++) {
          p.lineTo(currentDrawingPoints[i].dx, currentDrawingPoints[i].dy);
        }
        canvas.drawPath(p, activeDrawingPaint);
      }

      // نقطة متوهجة على رأس إصبع التلميذ
      final tip = currentDrawingPoints.last;
      canvas.drawCircle(
        tip,
        14.0,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        tip,
        8.0,
        Paint()..color = Colors.amber,
      );
    }

    // ── 5. رسم نقاط البداية المرقمة (Numbered Start Badges) ──
    if (!isAllCompleted) {
      for (int sIdx = 0; sIdx < strokes.length; sIdx++) {
        final stroke = strokes[sIdx];
        final startPx = Offset(stroke.start.dx * size.width, stroke.start.dy * size.height);
        final isCurrent = (sIdx == currentStrokeIndex);
        final isPassed = (sIdx < currentStrokeIndex);

        if (isPassed) continue; // تم الانتهاء منه

        // دائرة النبض للنقطة النشطة الحالية
        if (isCurrent) {
          final pulseRadius = 18.0 + (pulseValue * 8.0);
          canvas.drawCircle(
            startPx,
            pulseRadius,
            Paint()..color = Colors.cyanAccent.withValues(alpha: 0.35 * (1.0 - pulseValue)),
          );
        }

        // الدائرة الخارجية للنقطة
        canvas.drawCircle(
          startPx,
          16.0,
          Paint()
            ..color = isCurrent ? const Color(0xFF00E5FF) : Colors.white.withValues(alpha: 0.4)
            ..style = PaintingStyle.fill,
        );

        // الدائرة البيضاء الداخلية
        canvas.drawCircle(
          startPx,
          13.0,
          Paint()
            ..color = isCurrent ? Colors.white : Colors.grey.shade300
            ..style = PaintingStyle.fill,
        );

        // رقم النقطة (١ ، ٢ ، ٣)
        final textPainter = TextPainter(
          text: TextSpan(
            text: stroke.label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: isCurrent ? const Color(0xFF00838F) : Colors.grey.shade600,
            ),
          ),
          textDirection: TextDirection.rtl,
        )..layout();

        textPainter.paint(
          canvas,
          startPx - Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }
  }

  void _drawDashedPolyline(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length < 2) return;

    const dashLength = 8.0;
    const gapLength = 6.0;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final totalDist = (p2 - p1).distance;
      final dir = (p2 - p1) / totalDist;

      double current = 0.0;
      while (current < totalDist) {
        final start = p1 + dir * current;
        final endDist = math.min(current + dashLength, totalDist);
        final end = p1 + dir * endDist;
        canvas.drawLine(start, end, paint);
        current += dashLength + gapLength;
      }
    }
  }

  void _drawArrowHead(Canvas canvas, Offset tip, double angle, Color color) {
    const arrowSize = 14.0;
    final path = Path();

    final p1 = tip - Offset(arrowSize * math.cos(angle - 0.5), arrowSize * math.sin(angle - 0.5));
    final p2 = tip - Offset(arrowSize * math.cos(angle + 0.5), arrowSize * math.sin(angle + 0.5));

    path.moveTo(tip.dx, tip.dy);
    path.lineTo(p1.dx, p1.dy);
    path.lineTo(p2.dx, p2.dy);
    path.close();

    canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant _ArabicLetterPainter oldDelegate) => true;
}

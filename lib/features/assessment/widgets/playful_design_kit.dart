import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';

/// حالة رفيقنا «صقر فصيح» التفاعلية أثناء التمارين
enum FalconMood { happy, thinking, encouraging, celebrating }

extension FalconMoodAsset on FalconMood {
  String get assetPath {
    switch (this) {
      case FalconMood.happy:
        return 'assets/images/mascot/falcon_happy.webp';
      case FalconMood.thinking:
        return 'assets/images/mascot/falcon_thinking.webp';
      case FalconMood.encouraging:
        return 'assets/images/mascot/falcon_encouraging.webp';
      case FalconMood.celebrating:
        return 'assets/images/mascot/falcon_celebrating.webp';
    }
  }
}

/// لوحة ألوان طفولية مبهجة مستوحاة من ألعاب مونتيسوري وDuolingo ABC (عالية التباين WCAG AA+)
class PlayfulPalette {
  PlayfulPalette._();

  static const Color ink = Color(0xFF1E293B);
  static const Color skyTop = Color(0xFFE0F4FF);
  static const Color skyMid = Color(0xFFFFFBF2);
  static const Color sandBottom = Color(0xFFFFF0D4);

  static const Color coral = Color(0xFFFF6B6B);
  static const Color coralDeep = Color(0xFFD93F3F);
  static const Color sunny = Color(0xFFFFB703);
  static const Color sunnyDeep = Color(0xFFD98A00);
  static const Color emerald = Color(0xFF22C55E);
  static const Color emeraldDeep = Color(0xFF15803D);
  static const Color ocean = Color(0xFF0EA5E9);
  static const Color oceanDeep = Color(0xFF0369A1);
  static const Color grape = Color(0xFF8B5CF6);
  static const Color grapeDeep = Color(0xFF6D28D9);
  static const Color berry = Color(0xFFEC4899);
  static const Color berryDeep = Color(0xFFBE185D);

  static Color darken(Color color, [double amount = 0.18]) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.15, 0.85))
        .toColor();
  }

  /// لون زاهٍ مخصص لكل خيار حتى تبدو البطاقات كمكعبات خشبية مبهجة للأطفال
  static Color blockColorForIndex(int index) {
    const colors = [
      Color(0xFF0EA5E9), // سماوي
      Color(0xFF8B5CF6), // بنفسجي
      Color(0xFFF97316), // برتقالي مشرق
      Color(0xFFEC4899), // وردي حيوي
      Color(0xFF14B8A6), // فيروزي
      Color(0xFFEAB308), // ذهبي
    ];
    return colors[index % colors.length];
  }
}

/// خلفية قصصية دافئة (سماء مشرقة + غيوم ناعمة + نجوم خفيفة + كثبان واحة لطيفة)
/// تنسجم تماماً مع هوية «فصيح الصغار» وتُزيل الفراغ الأبيض البارد على التابلت والهاتف!
class StorybookOasisBackground extends StatelessWidget {
  final Widget child;
  final Color? tintAccent;

  const StorybookOasisBackground({
    super.key,
    required this.child,
    this.tintAccent,
  });

  @override
  Widget build(BuildContext context) {
    final topColor = tintAccent != null
        ? Color.lerp(PlayfulPalette.skyTop, tintAccent!, 0.10)!
        : PlayfulPalette.skyTop;

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.52, 1.0],
                colors: [
                  topColor,
                  PlayfulPalette.skyMid,
                  PlayfulPalette.sandBottom,
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _StorybookSceneryPainter(
                accent: tintAccent ?? PlayfulPalette.ocean,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _StorybookSceneryPainter extends CustomPainter {
  final Color accent;
  const _StorybookSceneryPainter({required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. غيوم قصصية ناعمة في الأعلى
    final cloudPaint = Paint()..color = Colors.white.withValues(alpha: 0.65);
    _drawCloud(canvas, Offset(size.width * 0.14, size.height * 0.11), 36, cloudPaint);
    _drawCloud(canvas, Offset(size.width * 0.84, size.height * 0.16), 44, cloudPaint);

    // 2. نجوم ذهبية لطيفة متناثرة بخفة
    final starPaint = Paint()..color = const Color(0xFFFBBF24).withValues(alpha: 0.30);
    final softAccent = Paint()..color = accent.withValues(alpha: 0.08);
    canvas.drawCircle(Offset(size.width * 0.09, size.height * 0.42), 28, softAccent);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.54), 38, softAccent);

    _drawFourPointStar(canvas, Offset(size.width * 0.22, size.height * 0.25), 9, starPaint);
    _drawFourPointStar(canvas, Offset(size.width * 0.78, size.height * 0.30), 11, starPaint);
    _drawFourPointStar(canvas, Offset(size.width * 0.12, size.height * 0.72), 10, starPaint);
    _drawFourPointStar(canvas, Offset(size.width * 0.88, size.height * 0.76), 12, starPaint);

    // 3. كثبان واحة ناعمة متموّجة في أسفل الشاشة تُغلق التكوين البصري بأناقة
    final backDune = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.90)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.84,
        size.width * 0.56,
        size.height * 0.90,
      )
      ..quadraticBezierTo(
        size.width * 0.82,
        size.height * 0.95,
        size.width,
        size.height * 0.88,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(
      backDune,
      Paint()..color = const Color(0xFFFDE68A).withValues(alpha: 0.42),
    );

    final frontDune = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.94)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.98,
        size.width * 0.68,
        size.height * 0.92,
      )
      ..quadraticBezierTo(
        size.width * 0.88,
        size.height * 0.89,
        size.width,
        size.height * 0.94,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(
      frontDune,
      Paint()..color = const Color(0xFFFCD34D).withValues(alpha: 0.32),
    );
  }

  void _drawCloud(Canvas canvas, Offset center, double r, Paint paint) {
    canvas.drawCircle(center, r * 0.62, paint);
    canvas.drawCircle(center + Offset(-r * 0.55, r * 0.14), r * 0.46, paint);
    canvas.drawCircle(center + Offset(r * 0.58, r * 0.16), r * 0.44, paint);
  }

  void _drawFourPointStar(Canvas canvas, Offset c, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final rad = i.isEven ? r : r * 0.35;
      final p = Offset(c.dx + math.cos(angle) * rad, c.dy + math.sin(angle) * rad);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _StorybookSceneryPainter oldDelegate) =>
      oldDelegate.accent != accent;
}

/// بطاقة ثلاثية الأبعاد مبهجة بحافة سفلية لمسية (أسلوب Duolingo / Montessori)
class Juicy3DCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color borderColor;
  final Color? lipColor;
  final double radius;
  final double lipDepth;
  final EdgeInsetsGeometry? padding;

  const Juicy3DCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.borderColor = const Color(0xFFE2E8F0),
    this.lipColor,
    this.radius = 26,
    this.lipDepth = 5,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveLip = lipColor ?? borderColor;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 2.2),
        boxShadow: [
          BoxShadow(
            color: effectiveLip,
            offset: Offset(0, lipDepth),
            blurRadius: 0,
          ),
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            offset: Offset(0, lipDepth + 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: child,
    );
  }
}

/// زر لمسي ثلاثي الأبعاد بحركة ضغط حقيقية للأطفال (مثل أزرار Duolingo ABC)
class Juicy3DButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color color;
  final Color? lipColor;
  final Color foregroundColor;
  final Widget child;
  final double radius;
  final double lipDepth;
  final double? minHeight;
  final EdgeInsetsGeometry padding;

  const Juicy3DButton({
    super.key,
    required this.onPressed,
    required this.color,
    this.lipColor,
    this.foregroundColor = Colors.white,
    required this.child,
    this.radius = 20,
    this.lipDepth = 5,
    this.minHeight,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
  });

  @override
  State<Juicy3DButton> createState() => _Juicy3DButtonState();
}

class _Juicy3DButtonState extends State<Juicy3DButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final fill = enabled ? widget.color : const Color(0xFFCBD5E1);
    final lip = enabled
        ? (widget.lipColor ?? PlayfulPalette.darken(widget.color, 0.16))
        : const Color(0xFF94A3B8);

    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled
          ? (_) {
              setState(() => _pressed = false);
              HapticFeedback.lightImpact();
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        transform: Matrix4.translationValues(0, _pressed ? widget.lipDepth - 1 : 0, 0),
        constraints: widget.minHeight != null
            ? BoxConstraints(minHeight: widget.minHeight!)
            : null,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: [
            BoxShadow(
              color: lip,
              offset: Offset(0, _pressed ? 1.5 : widget.lipDepth),
              blurRadius: 0,
            ),
            if (!_pressed)
              BoxShadow(
                color: fill.withValues(alpha: 0.25),
                offset: const Offset(0, 8),
                blurRadius: 14,
              ),
          ],
        ),
        child: IconTheme(
          data: IconThemeData(color: widget.foregroundColor),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontFamily: 'Cairo',
              color: widget.foregroundColor,
              fontWeight: FontWeight.w900,
            ),
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }
}

/// فقاعة صقر فصيح التفاعلية: شخصية صقر فصيح المبهجة + فقاعة كلام دافئة + زر استماع بارز
class FalconCompanionBubble extends StatelessWidget {
  final FalconMood mood;
  final String? badgeAr;
  final String messageAr;
  final Color accent;
  final VoidCallback? onTapAudio;

  const FalconCompanionBubble({
    super.key,
    required this.mood,
    this.badgeAr,
    required this.messageAr,
    required this.accent,
    this.onTapAudio,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final avatarSize = isCompact ? 56.0 : (context.isTablet ? 90.0 : 70.0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // صقر فصيح في دائرة ذهبية مشرقة
        Container(
          width: avatarSize,
          height: avatarSize,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD166), Color(0xFFFF9F1C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Container(
              color: Colors.white,
              child: Image.asset(
                mood.assetPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: isCompact ? 8 : 12),

        // فقاعة الكلام ثلاثية الأبعاد
        Expanded(
          child: Juicy3DCard(
            color: Colors.white,
            borderColor: accent.withValues(alpha: 0.45),
            lipColor: accent.withValues(alpha: 0.28),
            radius: 22,
            lipDepth: 4,
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 10 : 14,
              vertical: isCompact ? 9 : 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (badgeAr != null && badgeAr!.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            badgeAr!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: context.scaledFont(11.5, min: 10, max: 14),
                              fontWeight: FontWeight.w900,
                              color: PlayfulPalette.darken(accent, 0.12),
                            ),
                          ),
                        ),
                      Text(
                        messageAr,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(15.5, min: 12.5, max: 20),
                          fontWeight: FontWeight.w900,
                          color: PlayfulPalette.ink,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTapAudio != null) ...[
                  SizedBox(width: isCompact ? 8 : 12),
                  Juicy3DButton(
                    onPressed: onTapAudio,
                    color: accent,
                    radius: 16,
                    lipDepth: 4,
                    padding: EdgeInsets.all(isCompact ? 9 : 12),
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: Colors.white,
                      size: isCompact ? 22 : 28,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// شريط تقدم لامع مبهج للأطفال (Candy Gloss Progress Bar)
class CandyProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  final double height;

  const CandyProgressBar({
    super.key,
    required this.progress,
    required this.color,
    this.height = 14,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.06, 1.0);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.6),
      ),
      padding: const EdgeInsets.all(2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: AlignmentDirectional.centerStart,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              width: constraints.maxWidth * clamped,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.lerp(color, Colors.white, 0.25)!,
                    color,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                  height: height * 0.24,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

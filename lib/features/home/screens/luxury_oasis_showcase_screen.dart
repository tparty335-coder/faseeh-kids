import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';

class LuxuryOasisShowcaseScreen extends ConsumerStatefulWidget {
  const LuxuryOasisShowcaseScreen({super.key});

  @override
  ConsumerState<LuxuryOasisShowcaseScreen> createState() =>
      _LuxuryOasisShowcaseScreenState();
}

class _LuxuryOasisShowcaseScreenState
    extends ConsumerState<LuxuryOasisShowcaseScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  final ScrollController _scrollController = ScrollController();

  final List<String> _letters = ['أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د'];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unlockedUnits = ref.watch(unlockedUnitsProvider);
    final currentUnit = ref.watch(currentUnitProvider);
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;

    const double stepHeight = 220.0;
    final double totalHeight = _letters.length * stepHeight + 400.0;
    final double amplitude = (screenWidth * 0.28).clamp(90.0, 160.0);

    // Calculate node coordinates along S-curve
    List<Offset> getOasisPositions() {
      final centerX = screenWidth / 2;
      return List.generate(_letters.length, (index) {
        final y = totalHeight - (index * stepHeight + 260.0);
        final x = centerX + math.sin(index * 0.9) * amplitude;
        return Offset(x, y);
      });
    }

    final positions = getOasisPositions();

    return Scaffold(
      backgroundColor: const Color(0xFF070B19),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            // ─── 1. Deep Arabian Night Desert Background ───
            Positioned.fill(
              child: CustomPaint(
                painter: _NightSkyAndDunesPainter(pulse: _pulseController),
              ),
            ),

            // ─── 2. Scrollable S-Curve Oasis River & Islands ───
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 120, bottom: 160),
              child: SizedBox(
                height: totalHeight,
                width: screenWidth,
                child: Stack(
                  children: [
                    // Dynamic Golden Path & Flowing Streams
                    CustomPaint(
                      size: Size(screenWidth, totalHeight),
                      painter: _LuxuryGoldenPathPainter(
                        positions: positions,
                        pulse: _pulseController,
                      ),
                    ),

                    // Interactive Oasis Nodes
                    ...List.generate(_letters.length, (index) {
                      final pos = positions[index];
                      final letter = _letters[index];
                      final isUnlocked = unlockedUnits.contains(letter);
                      final isCurrent = letter == currentUnit || (index == 0 && currentUnit == 'أ');

                      return Positioned(
                        left: pos.dx - 90,
                        top: pos.dy - 90,
                        child: _LuxuryOasisNode(
                          letter: letter,
                          index: index,
                          isCurrent: isCurrent,
                          isUnlocked: isUnlocked,
                          pulse: _pulseController,
                          onTap: () {
                            if (isUnlocked) {
                              final arabicLetter = arabicLetters.firstWhere(
                                (l) => l.letter == letter,
                                orElse: () => arabicLetters[0],
                              );
                              ref.read(currentLessonProvider.notifier).setLetter(arabicLetter);
                              final key = AudioRegistry.letterKeyFromChar(letter);
                              AudioManager.instance.playByKey('letter_$key');
                              context.push('/lesson/$letter');
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // ─── 3. Frosted Glassmorphic Top HUD ───
            Positioned(
              top: MediaQuery.paddingOf(context).top + 12,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Progress & Unit Glass Card (Top Left)
                  _buildGlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD54F), Color(0xFFFF8F00)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD54F).withValues(alpha: 0.4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.star_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'رِحْلَةُ الْحُرُوفِ الْعَرَبِيَّةِ',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFE082),
                              ),
                            ),
                            const SizedBox(height: 3),
                            SizedBox(
                              width: 110,
                              height: 6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  value: (unlockedUnits.length / 28).clamp(0.05, 1.0),
                                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                                  valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD54F)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Header Badge (Top Right: "واحات")
                  _buildGlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'وَاحَاتُ فَصِيحْ',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('🌴', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ─── 4. Left Floating Navigation Rail ───
            Positioned(
              right: 16,
              top: size.height * 0.32,
              child: _buildGlassCard(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                borderRadius: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildRailIcon(Icons.home_rounded, isSelected: true),
                    const SizedBox(height: 16),
                    _buildRailIcon(Icons.grid_view_rounded, isSelected: false),
                    const SizedBox(height: 16),
                    _buildRailIcon(Icons.auto_stories_rounded, isSelected: false),
                    const SizedBox(height: 16),
                    _buildRailIcon(Icons.military_tech_rounded, isSelected: false),
                  ],
                ),
              ),
            ),

            // ─── 5. Bottom Floating Luxury Nav Bar ───
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back / Map Button
                  _buildGlassCard(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 20,
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFFFE082), size: 20),
                  ),

                  // Center Floating Falcon Button
                  _buildGlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    borderRadius: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.people_alt_rounded, color: Colors.white70, size: 22),
                        const SizedBox(width: 20),
                        // Glowing Center Gold Badge
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [Color(0xFFFFF176), Color(0xFFFFB300), Color(0xFFFF8F00)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD54F).withValues(alpha: 0.6),
                                blurRadius: 18,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('🦅', style: TextStyle(fontSize: 24)),
                          ),
                        ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1.05, 1.05),
                              duration: 1800.ms,
                            ),
                        const SizedBox(width: 20),
                        const Icon(Icons.settings_rounded, color: Colors.white70, size: 22),
                      ],
                    ),
                  ),

                  // Level Badge (Bottom Left)
                  _buildGlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    borderRadius: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'المستوى ١',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFE082),
                          ),
                        ),
                        SizedBox(width: 6),
                        Text('🏆', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRailIcon(IconData icon, {required bool isSelected}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFD54F).withValues(alpha: 0.25) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: isSelected ? Border.all(color: const Color(0xFFFFD54F), width: 1.5) : null,
      ),
      child: Icon(
        icon,
        color: isSelected ? const Color(0xFFFFD54F) : Colors.white60,
        size: 22,
      ),
    );
  }

  Widget _buildGlassCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    double borderRadius = 20,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: const Color(0xFFFFD54F).withValues(alpha: 0.45),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: const Color(0xFFFFD54F).withValues(alpha: 0.08),
                  blurRadius: 10,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ─── Luxury Oasis Node Widget (Pond + Island + Glowing Letter + Falcon) ───
class _LuxuryOasisNode extends StatelessWidget {
  final String letter;
  final int index;
  final bool isCurrent;
  final bool isUnlocked;
  final AnimationController pulse;
  final VoidCallback onTap;

  const _LuxuryOasisNode({
    required this.letter,
    required this.index,
    required this.isCurrent,
    required this.isUnlocked,
    required this.pulse,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 180,
        height: 180,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Crystal Water Pond & Radial Glow
            AnimatedBuilder(
              animation: pulse,
              builder: (context, _) {
                final glow = isCurrent ? (pulse.value * 12.0 + 8.0) : 6.0;
                return Container(
                  width: 130,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(130, isCurrent ? 95 : 90),
                    ),
                    gradient: RadialGradient(
                      colors: isUnlocked
                          ? [
                              const Color(0xFF00E5FF),
                              const Color(0xFF0091EA),
                              const Color(0xFF01579B),
                              const Color(0xFF002244),
                            ]
                          : [
                              Colors.blueGrey.shade700,
                              Colors.blueGrey.shade900,
                            ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isUnlocked ? const Color(0xFF00E5FF) : Colors.blueGrey)
                            .withValues(alpha: isCurrent ? 0.6 : 0.3),
                        blurRadius: glow + 10,
                        spreadRadius: isCurrent ? 3 : 0,
                      ),
                      BoxShadow(
                        color: const Color(0xFFFFD54F).withValues(alpha: isCurrent ? 0.35 : 0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                );
              },
            ),

            // 2. Palm Trees Framing
            Positioned(
              left: 10,
              top: 25,
              child: const Text('🌴', style: TextStyle(fontSize: 34)),
            ),
            Positioned(
              right: 12,
              top: 30,
              child: const Text('🌴', style: TextStyle(fontSize: 28)),
            ),

            // 3. Central Island / Falcon Mascot for Current Node
            if (isCurrent)
              Positioned(
                top: 40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Golden Falcon Mascot
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFF9C4).withValues(alpha: 0.2),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD54F).withValues(alpha: 0.6),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Text('🦅', style: TextStyle(fontSize: 38)),
                    ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
                          begin: 0,
                          end: -6,
                          duration: 1500.ms,
                          curve: Curves.easeInOut,
                        ),
                  ],
                ),
              ),

            // 4. Floating Luminescent Arabic Letter
            Positioned(
              top: isCurrent ? 0 : 35,
              child: AnimatedBuilder(
                animation: pulse,
                builder: (context, _) {
                  final glowRadius = isCurrent ? (pulse.value * 14.0 + 12.0) : 8.0;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? const Color(0xFFFFD54F).withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: isCurrent ? 44 : 36,
                        fontWeight: FontWeight.w900,
                        color: isUnlocked ? const Color(0xFFFFF9C4) : Colors.white38,
                        shadows: isUnlocked
                            ? [
                                Shadow(
                                  color: const Color(0xFFFFD54F),
                                  blurRadius: glowRadius,
                                ),
                                Shadow(
                                  color: const Color(0xFFFF8F00),
                                  blurRadius: glowRadius + 12,
                                ),
                                const Shadow(
                                  color: Colors.black54,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Custom Painter: Arabian Night Sky & Layered Dunes ───
class _NightSkyAndDunesPainter extends CustomPainter {
  final Animation<double> pulse;

  _NightSkyAndDunesPainter({required this.pulse}) : super(repaint: pulse);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1. Sky Deep Gradient
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF040714),
          Color(0xFF0A1128),
          Color(0xFF101B3B),
          Color(0xFF1C274C),
        ],
        stops: [0.0, 0.35, 0.7, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, skyPaint);

    // 2. Crescent Moon (Top Center-Right)
    final moonCenter = Offset(size.width * 0.72, 80);
    final moonGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFF9C4).withValues(alpha: 0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: moonCenter, radius: 45));
    canvas.drawCircle(moonCenter, 45, moonGlow);

    final moonPaint = Paint()..color = const Color(0xFFFFF9C4);
    canvas.drawCircle(moonCenter, 14, moonPaint);
    final moonCutout = Paint()..color = const Color(0xFF060B1C);
    canvas.drawCircle(moonCenter.translate(-5, -3), 12, moonCutout);

    // 3. Distant Stars Particle Field
    final starPaint = Paint()..color = Colors.white.withValues(alpha: 0.8);
    final random = math.Random(42);
    for (int i = 0; i < 45; i++) {
      final sx = random.nextDouble() * size.width;
      final sy = random.nextDouble() * (size.height * 0.45);
      final r = random.nextDouble() * 1.5 + 0.5;
      canvas.drawCircle(Offset(sx, sy), r, starPaint);
    }

    // 4. Layered Rolling Dunes Silhouettes with Gold Crests
    _drawDune(canvas, size, 0.45, const Color(0xFF0F1A36), const Color(0xFFD4AF37), 0.3);
    _drawDune(canvas, size, 0.65, const Color(0xFF131F3F), const Color(0xFFE5C07B), 0.4);
    _drawDune(canvas, size, 0.85, const Color(0xFF18264D), const Color(0xFFFFD54F), 0.5);
  }

  void _drawDune(Canvas canvas, Size size, double heightFactor, Color fillColor, Color crestColor, double crestAlpha) {
    final path = Path();
    final y = size.height * heightFactor;
    path.moveTo(0, y);
    path.quadraticBezierTo(size.width * 0.3, y - 40, size.width * 0.6, y + 20);
    path.quadraticBezierTo(size.width * 0.85, y + 60, size.width, y);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final fillPaint = Paint()..color = fillColor;
    canvas.drawPath(path, fillPaint);

    // Golden Rim Light on Dune Crest
    final crestPaint = Paint()
      ..color = crestColor.withValues(alpha: crestAlpha)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, crestPaint);
  }

  @override
  bool shouldRepaint(covariant _NightSkyAndDunesPainter oldDelegate) => true;
}

// ─── Custom Painter: Winding Golden Path with Glowing Streams ───
class _LuxuryGoldenPathPainter extends CustomPainter {
  final List<Offset> positions;
  final Animation<double> pulse;

  _LuxuryGoldenPathPainter({required this.positions, required this.pulse})
      : super(repaint: pulse);

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.length < 2) return;

    final path = Path();
    path.moveTo(positions.first.dx, positions.first.dy);

    for (int i = 0; i < positions.length - 1; i++) {
      final p0 = positions[i];
      final p1 = positions[i + 1];
      final midY = (p0.dy + p1.dy) / 2;
      path.cubicTo(p0.dx, midY, p1.dx, midY, p1.dx, p1.dy);
    }

    // 1. Path Ambient Golden Glow
    final glowPaint = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 64.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawPath(path, glowPaint);

    // 2. Solid Sand Gold Path Body
    final pathPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFE6C280),
          Color(0xFFD4AF37),
          Color(0xFFC59B53),
          Color(0xFFE6C280),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 44.0
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, pathPaint);

    // 3. Delicate Inner Water Flow Stream
    final streamPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF00E5FF),
          Color(0xFF00B0FF),
          Color(0xFF00E5FF),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, streamPaint);
  }

  @override
  bool shouldRepaint(covariant _LuxuryGoldenPathPainter oldDelegate) => true;
}

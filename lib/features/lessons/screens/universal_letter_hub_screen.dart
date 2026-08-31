import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/screens/lesson_sequence_screen.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/features/lessons/screens/games_activity_screen.dart';

// ═══ UPGRADED: universal_letter_hub_screen.dart ═══

class UniversalLetterHubScreen extends ConsumerStatefulWidget {
  const UniversalLetterHubScreen({super.key});

  @override
  ConsumerState<UniversalLetterHubScreen> createState() => _UniversalLetterHubScreenState();
}

class _UniversalLetterHubScreenState extends ConsumerState<UniversalLetterHubScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbitController;
  bool _isPlayingSound = false;

  @override
  void initState() {
    super.initState();
    // Falcon orbital flight controller
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();

    // Auto-play letter sound on entrance after brief delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playLetterSound();
    });
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  void _playLetterSound() async {
    final letter = ref.read(currentLessonProvider).letter;
    if (letter != null && mounted) {
      setState(() => _isPlayingSound = true);
      final key = AudioRegistry.letterKeyFromChar(letter.letter);
      await AudioManager.instance.playLetterAudio(key, 'name');
      if (mounted) {
        setState(() => _isPlayingSound = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطأ')),
        body: const Center(child: Text('لم يتم اختيار حرف')),
      );
    }

    final progress = ref.watch(lessonProgressProvider);
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    final double letterFontSize = isTablet ? 140.0 : 105.0;
    final double cardSize = isTablet ? 240.0 : 180.0;
    final double orbitRadiusX = isTablet ? 150.0 : 115.0;
    final double orbitRadiusY = isTablet ? 110.0 : 85.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFF9E6), // Warm Oasis Cream
                Color(0xFFFFF0C2),
                Color(0xFFFFE0B2),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // ─── 1. Top App Bar ───
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.desertSand, size: 24),
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 14,
                            backgroundColor: Colors.white,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.oasisGreen),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.desertSand.withValues(alpha: 0.5)),
                        ),
                        child: Text(
                          '${lessonState.completedActivities}/${LessonActivity.values.length}',
                          style: const TextStyle(
                            color: AppColors.desertSand,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.home_rounded, color: AppColors.desertSand, size: 30),
                        tooltip: 'الرئيسية',
                        onPressed: () => context.go(AppRouter.homeMap),
                      ),
                    ],
                  ),
                ),

                // ─── 2. Letter Title Header ───
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                    ],
                  ),
                  child: Text(
                    'حَرْفُ ${letter.name}',
                    style: TextStyle(
                      fontSize: isTablet ? 34 : 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.baaTopBar,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ).animate().fadeIn().slideY(begin: -0.2),

                // ─── 3. Center Area (Big Letter + Orbiting Falcon) ───
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: orbitRadiusX * 2 + 100,
                      height: orbitRadiusY * 2 + 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Radiant Halo Glow
                          Container(
                            width: cardSize + 40,
                            height: cardSize + 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryDay.withValues(alpha: 0.2),
                            ),
                          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                                begin: const Offset(0.95, 0.95),
                                end: const Offset(1.1, 1.1),
                                duration: 1500.ms,
                              ),

                          // Central Letter Badge
                          Container(
                            width: cardSize,
                            height: cardSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.white, Color(0xFFFFFDE7)],
                              ),
                              border: Border.all(color: AppColors.primaryDay, width: 4.5),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryDay.withValues(alpha: 0.4),
                                  blurRadius: 20,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                letter.letter,
                                style: TextStyle(
                                  fontSize: letterFontSize,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.baaLetterPurple,
                                  fontFamily: 'Cairo',
                                  height: 1.0,
                                  shadows: [
                                    Shadow(
                                      color: AppColors.baaLetterPurple.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),

                          // Orbiting Flying Falcon Mascot
                          AnimatedBuilder(
                            animation: _orbitController,
                            builder: (context, child) {
                              final angle = _orbitController.value * 2 * math.pi;
                              final x = math.cos(angle) * orbitRadiusX;
                              final y = math.sin(angle) * orbitRadiusY;

                              return Transform.translate(
                                offset: Offset(x, y),
                                child: child,
                              );
                            },
                            child: Container(
                              width: isTablet ? 72 : 56,
                              height: isTablet ? 72 : 56,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.baaHighlightYellow, width: 2.5),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/mascot/falcon_happy.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Center(
                                    child: Text('🦅', style: TextStyle(fontSize: 32)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ─── 4. Audio Speaker Button Under the Letter ───
                GestureDetector(
                  onTap: _playLetterSound,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.secondaryDay, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondaryDay.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isPlayingSound ? Icons.volume_up_rounded : Icons.volume_up_outlined,
                          color: AppColors.secondaryDay,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'استمع لصوت حرف ${letter.name}',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: isTablet ? 20 : 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryDay,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.04, 1.04),
                      duration: 1200.ms,
                    ),

                SizedBox(height: isTablet ? 24 : 14),

                // ─── 5. Action Buttons at the Bottom ───
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 60 : 20, vertical: 8),
                  child: Column(
                    children: [
                      // زر بدء الدرس المتسلسل
                      SizedBox(
                        width: double.infinity,
                        height: isTablet ? 66 : 56,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LessonSequenceScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.play_circle_fill_rounded, size: 30),
                          label: Text(
                            'ابدأ درس حرف (${letter.letter})',
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDay,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // زر ألعاب وأسئلة الحرف المباشر
                      SizedBox(
                        width: double.infinity,
                        height: isTablet ? 60 : 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Scaffold(
                                  backgroundColor: AppColors.backgroundDay,
                                  appBar: AppBar(
                                    title: Text(
                                      'ألعاب وأسئلة حرف (${letter.letter})',
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimaryDay,
                                      ),
                                    ),
                                    centerTitle: true,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    leading: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.desertSand),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ),
                                  body: const GamesActivityScreen(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.videogame_asset_rounded, size: 26),
                          label: const Text(
                            'ألعاب وأسئلة الحرف 🎮',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.oasisGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══ END OF FILE ═══

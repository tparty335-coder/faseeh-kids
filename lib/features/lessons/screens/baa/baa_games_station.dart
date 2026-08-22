import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ═══ UPGRADED: baa_games_station.dart ═══

class BaaGamesStation extends StatefulWidget {
  final VoidCallback onPrevious;

  const BaaGamesStation({
    super.key,
    required this.onPrevious,
  });

  @override
  State<BaaGamesStation> createState() => _BaaGamesStationState();
}

class _BaaGamesStationState extends State<BaaGamesStation>
    with TickerProviderStateMixin {
  int? _activeGameIndex; // null = Selection Wheel
  int _score = 0;

  // Flash effect colors
  Color? _screenFlashColor;

  // Confetti controller for star bursts
  late final ConfettiController _confettiController;

  static const List<Map<String, dynamic>> _games = [
    {
      'title': 'صَيْدُ الْكَلِمَاتِ',
      'subtitle': 'اِصْطَدِ الْأَسْمَاكَ الَّتِي بِهَا حَرْفُ (ب)',
      'color': Color(0xFFD32F2F), // Red
      'icon': Icons.phishing_rounded,
      'bg': 'assets/images/lessons/baa/baa_fishing.jpg',
    },
    {
      'title': 'خَلِيَّةُ الْحَرْفِ',
      'subtitle': 'سَاعِدِ النَّحْلَةَ فِي اخْتِيَارِ الْحَرَكَةِ الْمُنَاسِبَةِ',
      'color': Color(0xFF00ACC1), // Cyan
      'icon': Icons.hive_rounded,
      'bg': 'assets/images/lessons/baa/baa_bee.jpg',
    },
    {
      'title': 'لُعْبَةُ الْكَلِمَاتِ',
      'subtitle': 'ضَعِ اسْمَ الصُّورَةِ مَكَانَ النُّقَطِ',
      'color': Color(0xFFF57C00), // Orange
      'icon': Icons.menu_book_rounded,
      'bg': 'assets/images/lessons/baa/baa_drag_words.jpg',
    },
    {
      'title': 'التَّلْوِينُ',
      'subtitle': 'لَوِّنِ الْكَلِمَةَ الَّتِي بِهَا مَدٌّ',
      'color': Color(0xFF1976D2), // Blue
      'icon': Icons.palette_rounded,
      'bg': 'assets/images/lessons/baa/baa_coloring.jpg',
    },
    {
      'title': 'السِّيرْكُ',
      'subtitle': 'اخْتَرِ الصُّورَةَ الَّتِي بِهَا حَرْفُ (ب)',
      'color': Color(0xFFC2185B), // Magenta
      'icon': Icons.theater_comedy_rounded,
      'bg': 'assets/images/lessons/baa/baa_circus.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _triggerCorrectCelebration() async {
    setState(() {
      _score++;
      _screenFlashColor = AppColors.baaHighlightYellow.withValues(alpha: 0.35);
    });
    _confettiController.play();
    await AudioService.instance.stop();
    await AudioService.instance.playAsset('audio/lessons/baa/short/baa_5.mp3'); // أحسنت!

    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) {
      setState(() => _screenFlashColor = null);
    }
  }

  void _triggerWrongShake() async {
    setState(() {
      _screenFlashColor = Colors.red.withValues(alpha: 0.35);
    });
    await AudioService.instance.stop();
    await AudioService.instance.playAsset('audio/lessons/baa/short/baa_77.mp3'); // حاول مرة أخرى

    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) {
      setState(() => _screenFlashColor = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Screen Content
        if (_activeGameIndex == null)
          _buildWheelSelectionView()
        else if (_activeGameIndex == 0)
          _buildFishingGame()
        else if (_activeGameIndex == 4)
          _buildCircusGame()
        else if (_activeGameIndex == 3)
          _buildColoringGame()
        else
          _buildGenericGameView(_games[_activeGameIndex!]),

        // Confetti / Star Burst Overlay
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              AppColors.baaHighlightYellow,
              Colors.orange,
              Colors.pink,
              Colors.green,
              Colors.blue,
            ],
            numberOfParticles: 20,
            gravity: 0.2,
          ),
        ),

        // Screen Flash Overlay (Gold for correct / Red for wrong)
        if (_screenFlashColor != null)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: _screenFlashColor,
              ),
            ),
          ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // 1. THE AUTHENTIC 5-PETAL SELECTION WHEEL
  // ═══════════════════════════════════════════════════════════════════
  Widget _buildWheelSelectionView() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_wheel.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.lessonSky, AppColors.lessonGrass],
                ),
              ),
            ),
          ),
        ),

        // Header Title
        Positioned(
          top: 12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.baaTopBar,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: const Text(
                'اخْتَرْ نَوْعَ السُّؤَالِ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // 5 Activity Cards Grid
        Positioned(
          top: 60,
          left: 16,
          right: 16,
          bottom: 70,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemCount: _games.length,
            itemBuilder: (ctx, i) {
              final g = _games[i];
              final color = g['color'] as Color;

              return GestureDetector(
                onTap: () => setState(() => _activeGameIndex = i),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: color, width: 3),
                    boxShadow: [
                      BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(g['icon'] as IconData, color: color, size: 34),
                      const SizedBox(height: 4),
                      Text(
                        g['title'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: (i * 70).ms).scale(duration: 300.ms, curve: Curves.easeOutBack),
              );
            },
          ),
        ),

        // Bottom Previous Button
        Positioned(
          bottom: 12,
          left: 20,
          child: OutlinedButton.icon(
            onPressed: widget.onPrevious,
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            label: const Text('السابق', style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.9),
              foregroundColor: Colors.brown.shade800,
              side: BorderSide(color: Colors.brown.shade400, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // 2. GAME 1: صَيْدُ الْكَلِمَاتِ (FISHING WITH SINE WAVE FISH)
  // ═══════════════════════════════════════════════════════════════════
  Widget _buildFishingGame() {
    return _FishingGameWidget(
      onCorrect: _triggerCorrectCelebration,
      onWrong: _triggerWrongShake,
      onBack: () => setState(() => _activeGameIndex = null),
      score: _score,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // 3. GAME 5: السِّيرْكُ (CIRCUS WITH SPOTLIGHT ANIMAL FRAMES)
  // ═══════════════════════════════════════════════════════════════════
  Widget _buildCircusGame() {
    return _CircusGameWidget(
      onCorrect: _triggerCorrectCelebration,
      onWrong: _triggerWrongShake,
      onBack: () => setState(() => _activeGameIndex = null),
      score: _score,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // 4. GAME 4: التَّلْوِينُ (COLORING MADD WORDS SWEEP)
  // ═══════════════════════════════════════════════════════════════════
  Widget _buildColoringGame() {
    return _ColoringGameWidget(
      onCorrect: _triggerCorrectCelebration,
      onWrong: _triggerWrongShake,
      onBack: () => setState(() => _activeGameIndex = null),
      score: _score,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // 5. GENERIC VIEW FOR BEE & WORD MATCH GAMES
  // ═══════════════════════════════════════════════════════════════════
  Widget _buildGenericGameView(Map<String, dynamic> game) {
    final color = game['color'] as Color;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            game['bg'] as String,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: color.withValues(alpha: 0.1)),
          ),
        ),

        // Game Header
        Positioned(
          top: 10,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 26),
                style: IconButton.styleFrom(backgroundColor: color),
                onPressed: () => setState(() => _activeGameIndex = null),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color, width: 2),
                ),
                child: Text(
                  game['title'] as String,
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: color),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.baaHighlightYellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('⭐ $_score', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ],
          ),
        ),

        // Prompt
        Positioned(
          top: 60,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color, width: 1.5),
            ),
            child: Text(
              game['subtitle'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
        ),

        // Options
        Positioned(
          bottom: 30,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildChoiceBtn('بَقَرَة', true, color),
              _buildChoiceBtn('شَمْس', false, color),
              _buildChoiceBtn('بَاب', true, color),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceBtn(String text, bool isCorrect, Color color) {
    return ElevatedButton(
      onPressed: () {
        if (isCorrect) {
          _triggerCorrectCelebration();
        } else {
          _triggerWrongShake();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        side: BorderSide(color: color, width: 2.5),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 4,
      ),
      child: Text(
        text,
        style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// FISHING GAME SUB-WIDGET WITH REAL SINE WAVE FISH MOTION
// ═════════════════════════════════════════════════════════════════════
class _FishingGameWidget extends StatefulWidget {
  final VoidCallback onCorrect;
  final VoidCallback onWrong;
  final VoidCallback onBack;
  final int score;

  const _FishingGameWidget({
    required this.onCorrect,
    required this.onWrong,
    required this.onBack,
    required this.score,
  });

  @override
  State<_FishingGameWidget> createState() => _FishingGameWidgetState();
}

class _FishingGameWidgetState extends State<_FishingGameWidget>
    with TickerProviderStateMixin {
  late final List<AnimationController> _fishControllers;
  final List<bool> _caughtFish = [false, false, false, false];

  static const List<Map<String, dynamic>> _fishData = [
    {'word': 'بَقَرَة', 'hasBaa': true, 'color': Colors.orange, 'speed': 5500, 'yBase': 90.0},
    {'word': 'أَسَد', 'hasBaa': false, 'color': Colors.cyan, 'speed': 6800, 'yBase': 140.0},
    {'word': 'بَاب', 'hasBaa': true, 'color': Colors.amber, 'speed': 4800, 'yBase': 190.0},
    {'word': 'فَأْر', 'hasBaa': false, 'color': Colors.lightGreen, 'speed': 6200, 'yBase': 240.0},
  ];

  @override
  void initState() {
    super.initState();
    _fishControllers = List.generate(_fishData.length, (i) {
      final ctrl = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _fishData[i]['speed'] as int),
      )..repeat();
      return ctrl;
    });
  }

  @override
  void dispose() {
    for (final c in _fishControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Water Background
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_fishing.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF81D4FA), Color(0xFF0288D1)],
                ),
              ),
            ),
          ),
        ),

        // Header Bar
        Positioned(
          top: 10,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 26),
                style: IconButton.styleFrom(backgroundColor: const Color(0xFFD32F2F)),
                onPressed: widget.onBack,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD32F2F), width: 2),
                ),
                child: const Text(
                  '🎣 صَيْدُ الْكَلِمَاتِ (حَرْفُ الْبَاءِ)',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.baaHighlightYellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('⭐ ${widget.score}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ],
          ),
        ),

        // 4 Swimming Fish with Sine Wave Motion
        ...List.generate(_fishData.length, (i) {
          if (_caughtFish[i]) return const SizedBox.shrink();

          final f = _fishData[i];
          final hasBaa = f['hasBaa'] as bool;
          final color = f['color'] as Color;
          final yBase = f['yBase'] as double;

          return AnimatedBuilder(
            animation: _fishControllers[i],
            builder: (context, child) {
              final t = _fishControllers[i].value;
              final xPos = (t * (size.width + 120)) - 100;
              final yOffset = math.sin(t * 4 * math.pi) * 22;

              return Positioned(
                left: xPos,
                top: yBase + yOffset,
                child: child!,
              );
            },
            child: GestureDetector(
              onTap: () {
                if (hasBaa) {
                  setState(() => _caughtFish[i] = true);
                  widget.onCorrect();
                  // Auto-reset after 2 seconds if all correct fish caught
                  final allCorrectCaught = List.generate(_fishData.length, (j) {
                    if (_fishData[j]['hasBaa'] as bool) return _caughtFish[j] || j == i;
                    return true;
                  }).every((v) => v);
                  if (allCorrectCaught) {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) setState(() => _caughtFish.fillRange(0, _caughtFish.length, false));
                    });
                  }
                } else {
                  widget.onWrong();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🐟', style: TextStyle(fontSize: 26)),
                    const SizedBox(width: 6),
                    Text(
                      f['word'] as String,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// CIRCUS GAME SUB-WIDGET WITH SPOTLIGHT FRAMES & CLOWN BANNER
// ═════════════════════════════════════════════════════════════════════
class _CircusGameWidget extends StatelessWidget {
  final VoidCallback onCorrect;
  final VoidCallback onWrong;
  final VoidCallback onBack;
  final int score;

  const _CircusGameWidget({
    required this.onCorrect,
    required this.onWrong,
    required this.onBack,
    required this.score,
  });

  static const List<Map<String, dynamic>> _circusChoices = [
    {'emoji': '🐰', 'word': 'أَرْنَب', 'hasBaa': true},
    {'emoji': '🦁', 'word': 'أَسَد', 'hasBaa': false},
    {'emoji': '🐊', 'word': 'تِمْسَاح', 'hasBaa': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_circus.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF880E4F), Color(0xFFC2185B)],
                ),
              ),
            ),
          ),
        ),

        // Header
        Positioned(
          top: 10,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 26),
                style: IconButton.styleFrom(backgroundColor: const Color(0xFFC2185B)),
                onPressed: onBack,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFC2185B), width: 2),
                ),
                child: const Text(
                  '🎪 السِّيرْكُ — اضْغَطْ عَلَى الصُّورَةِ الَّتِي بِهَا (ب)',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFC2185B)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.baaHighlightYellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('⭐ $score', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ],
          ),
        ),

        // Clown Character on Right waving Banner
        Positioned(
          top: 75,
          right: 20,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.baaHighlightYellow,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Text(
                  'حَرْفُ (ب)',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).rotate(begin: -0.05, end: 0.05, duration: 600.ms),
              const SizedBox(height: 6),
              const Text('🤡', style: TextStyle(fontSize: 70)),
            ],
          ),
        ),

        // 3 Circular Spotlight Animal Frames
        Positioned(
          top: 100,
          left: 20,
          right: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_circusChoices.length, (i) {
              final item = _circusChoices[i];
              final hasBaa = item['hasBaa'] as bool;

              return GestureDetector(
                onTap: () {
                  if (hasBaa) {
                    onCorrect();
                  } else {
                    onWrong();
                  }
                },
                child: Container(
                  width: 85,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.baaHighlightYellow, width: 3),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item['emoji'] as String, style: const TextStyle(fontSize: 42)),
                      const SizedBox(height: 4),
                      Text(
                        item['word'] as String,
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
                      ),
                    ],
                  ),
                ).animate(delay: (i * 120).ms).scale(duration: 300.ms),
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// COLORING GAME SUB-WIDGET (MADD WORDS FILL SWEEP)
// ═════════════════════════════════════════════════════════════════════
class _ColoringGameWidget extends StatefulWidget {
  final VoidCallback onCorrect;
  final VoidCallback onWrong;
  final VoidCallback onBack;
  final int score;

  const _ColoringGameWidget({
    required this.onCorrect,
    required this.onWrong,
    required this.onBack,
    required this.score,
  });

  @override
  State<_ColoringGameWidget> createState() => _ColoringGameWidgetState();
}

class _ColoringGameWidgetState extends State<_ColoringGameWidget> {
  final Set<int> _coloredIndices = {};

  static const List<Map<String, dynamic>> _coloringWords = [
    {'word': 'كِتَاب', 'hasMadd': true},
    {'word': 'بِنْت', 'hasMadd': false},
    {'word': 'بَاب', 'hasMadd': true},
    {'word': 'بَيْت', 'hasMadd': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_coloring.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                ),
              ),
            ),
          ),
        ),

        // Header
        Positioned(
          top: 10,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 26),
                style: IconButton.styleFrom(backgroundColor: const Color(0xFF1976D2)),
                onPressed: widget.onBack,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1976D2), width: 2),
                ),
                child: const Text(
                  '🎨 التَّلْوِينُ — اضْغَطْ عَلَى الْكَلِمَةِ الَّتِي بِهَا مَدٌّ',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1976D2)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.baaHighlightYellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('⭐ ${widget.score}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ],
          ),
        ),

        // Words Cards (Outline -> Color Filled Sweep)
        Positioned(
          top: 85,
          left: 20,
          right: 20,
          bottom: 40,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.6,
            ),
            itemCount: _coloringWords.length,
            itemBuilder: (ctx, i) {
              final w = _coloringWords[i];
              final hasMadd = w['hasMadd'] as bool;
              final isColored = _coloredIndices.contains(i);

              return GestureDetector(
                onTap: () {
                  if (hasMadd) {
                    setState(() => _coloredIndices.add(i));
                    widget.onCorrect();
                  } else {
                    widget.onWrong();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isColored ? const Color(0xFF1976D2) : Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF1976D2), width: 3),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                  ),
                  child: Center(
                    child: Text(
                      w['word'] as String,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: isColored ? Colors.white : const Color(0xFF1976D2),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ═══ END OF FILE ═══

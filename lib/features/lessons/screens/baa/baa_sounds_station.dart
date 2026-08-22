import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ═══ UPGRADED: baa_sounds_station.dart ═══

class BaaSoundsStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaSoundsStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<BaaSoundsStation> createState() => _BaaSoundsStationState();
}

class _BaaSoundsStationState extends State<BaaSoundsStation>
    with TickerProviderStateMixin {
  int _selectedHarakaIndex = 0;

  // 1. Pendulum Controller for Letter Card
  late final AnimationController _pendulumController;
  late final Animation<double> _pendulumAnimation;

  // 2. Flying Haraka Controller
  late final AnimationController _harakaFlyController;
  late final Animation<Offset> _harakaOffsetAnimation;
  late final Animation<double> _harakaScaleAnimation;

  // 3. Butterfly Sine Wave Controllers
  late final AnimationController _butterfly1Controller;
  late final AnimationController _butterfly2Controller;

  static const List<Map<String, dynamic>> _vowels = [
    {
      'id': 'fatha',
      'label': 'الْفَتْحَة (بَ)',
      'letter': 'ب',
      'haraka': 'َ',
      'harakaName': 'فَتْحَة',
      'fullLetter': 'بَ',
      'word': 'بَقَرَة',
      'emoji': '🐄',
      'color': AppColors.harakaFatha,
      'audio': 'audio/lessons/baa/short/baa_11.mp3',
    },
    {
      'id': 'damma',
      'label': 'الضَّمَّة (بُ)',
      'letter': 'ب',
      'haraka': 'ُ',
      'harakaName': 'ضَمَّة',
      'fullLetter': 'بُ',
      'word': 'بُرْتُقَال',
      'emoji': '🍊',
      'color': AppColors.harakaDamma,
      'audio': 'audio/lessons/baa/short/baa_12.mp3',
    },
    {
      'id': 'kasra',
      'label': 'الْكَسْرَة (بِ)',
      'letter': 'ب',
      'haraka': 'ِ',
      'harakaName': 'كَسْرَة',
      'fullLetter': 'بِ',
      'word': 'بِطِّيخ',
      'emoji': '🍉',
      'color': AppColors.harakaKasra,
      'audio': 'audio/lessons/baa/short/baa_13.mp3',
    },
    {
      'id': 'sukoon',
      'label': 'السُّكُون (بْ)',
      'letter': 'ب',
      'haraka': 'ْ',
      'harakaName': 'سُكُون',
      'fullLetter': 'بْ',
      'word': 'حَبْل',
      'emoji': '🪢',
      'color': AppColors.harakaSukoon,
      'audio': 'audio/lessons/baa/short/baa_15.mp3',
    },
    {
      'id': 'madd_alif',
      'label': 'الْمَدّ بِالأَلِف (بَا)',
      'letter': 'ب',
      'haraka': 'َا',
      'harakaName': 'مَدٌّ بِالأَلِفِ',
      'fullLetter': 'بَا',
      'word': 'بَاب',
      'emoji': '🚪',
      'color': AppColors.maddAlif,
      'audio': 'audio/lessons/baa/medium/baa_28.mp3',
    },
    {
      'id': 'madd_waw',
      'label': 'الْمَدّ بِالْوَاو (بُو)',
      'letter': 'ب',
      'haraka': 'ُو',
      'harakaName': 'مَدٌّ بِالْوَاوِ',
      'fullLetter': 'بُو',
      'word': 'بُوق',
      'emoji': '🎺',
      'color': AppColors.maddWaw,
      'audio': 'audio/lessons/baa/medium/baa_42.mp3',
    },
    {
      'id': 'madd_yaa',
      'label': 'الْمَدّ بِالْيَاء (بِي)',
      'letter': 'ب',
      'haraka': 'ِي',
      'harakaName': 'مَدٌّ بِالْيَاءِ',
      'fullLetter': 'بِي',
      'word': 'طَبِيب',
      'emoji': '👨‍⚕️',
      'color': AppColors.maddYaa,
      'audio': 'audio/lessons/baa/medium/baa_44.mp3',
    },
  ];

  @override
  void initState() {
    super.initState();

    // 1. Setup Pendulum Animation (-0.05 to +0.05 radians)
    _pendulumController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _pendulumAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _pendulumController, curve: Curves.easeInOut),
    );

    // 2. Setup Flying Haraka Animation
    _harakaFlyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _harakaOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _harakaFlyController, curve: Curves.elasticOut),
    );

    _harakaScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(parent: _harakaFlyController, curve: Curves.easeInOut),
    );

    // 3. Setup Butterfly Sine Wave Controllers
    _butterfly1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    _butterfly2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();

    // Trigger initial sound and animations
    _triggerHarakaSelection(0);
  }

  @override
  void dispose() {
    _pendulumController.dispose();
    _harakaFlyController.dispose();
    _butterfly1Controller.dispose();
    _butterfly2Controller.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _triggerHarakaSelection(int index) {
    setState(() => _selectedHarakaIndex = index);
    _harakaFlyController.forward(from: 0.0);
    _playSound(_vowels[index]);
  }

  Future<void> _playSound(Map<String, dynamic> v) async {
    await AudioService.instance.stop();
    await AudioService.instance.playAsset(v['audio'] as String);
  }

  @override
  Widget build(BuildContext context) {
    final current = _vowels[_selectedHarakaIndex];
    final color = current['color'] as Color;

    return Stack(
      children: [
        // ── 1. Authentic Tree Hollow Background ───────────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_sounds.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.lessonForest, AppColors.lessonTrunk],
                ),
              ),
            ),
          ),
        ),

        // ── 2. Top Header ─────────────────────────────────────────
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.baaTopBar,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: const Text(
                'أَصْوَاتُ حَرْفِ الْبَاءِ وَالْمُدُود (ب)',
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

        // ── 3. Vowel Selector Ribbon (Horizontal Cards) ───────────
        Positioned(
          top: 55,
          left: 8,
          right: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              children: List.generate(_vowels.length, (i) {
                final v = _vowels[i];
                final isSelected = i == _selectedHarakaIndex;
                final itemColor = v['color'] as Color;

                return GestureDetector(
                  onTap: () => _triggerHarakaSelection(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? itemColor : Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.white : itemColor.withValues(alpha: 0.6),
                        width: isSelected ? 2.5 : 1.5,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(color: itemColor.withValues(alpha: 0.5), blurRadius: 8, spreadRadius: 1),
                      ],
                    ),
                    child: Text(
                      v['fullLetter'] as String,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : itemColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        // ── 4. Floating Butterflies Around Card (Sine Wave) ───────
        // Butterfly 1 (Blue)
        AnimatedBuilder(
          animation: _butterfly1Controller,
          builder: (context, child) {
            final t = _butterfly1Controller.value * 2 * math.pi;
            final dx = math.cos(t) * 45;
            final dy = math.sin(t * 2) * 20;
            return Positioned(
              top: 140 + dy,
              right: 60 + dx,
              child: child!,
            );
          },
          child: const Text('🦋', style: TextStyle(fontSize: 26)).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.1, 1.1),
            duration: 600.ms,
          ),
        ),

        // Butterfly 2 (Purple)
        AnimatedBuilder(
          animation: _butterfly2Controller,
          builder: (context, child) {
            final t = _butterfly2Controller.value * 2 * math.pi;
            final dx = math.sin(t) * 35;
            final dy = math.cos(t * 2) * 18;
            return Positioned(
              top: 220 + dy,
              right: 180 + dx,
              child: child!,
            );
          },
          child: const Text('🦋', style: TextStyle(fontSize: 22)).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.15, 1.15),
            duration: 800.ms,
          ),
        ),

        // ── 5. Swinging Letter Card Hanging from Golden Rope ──────
        Positioned(
          top: 105,
          right: 24,
          child: Column(
            children: [
              // Golden Rope from ceiling
              Container(
                width: 4,
                height: 30,
                color: AppColors.baaRope,
              ),
              // Pendulum Swivel Container
              AnimatedBuilder(
                animation: _pendulumAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _pendulumAnimation.value,
                    alignment: Alignment.topCenter,
                    child: child,
                  );
                },
                child: Container(
                  width: 140,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.baaCardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.baaCardBorder, width: 3.5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5)),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Base Letter (ب)
                      Text(
                        current['letter'] as String,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 68,
                          fontWeight: FontWeight.w900,
                          color: AppColors.baaLetterPurple,
                          height: 1.0,
                        ),
                      ),

                      // Flying Haraka Mark landing with elastic physics
                      SlideTransition(
                        position: _harakaOffsetAnimation,
                        child: ScaleTransition(
                          scale: _harakaScaleAnimation,
                          child: Text(
                            current['fullLetter'] as String,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 68,
                              fontWeight: FontWeight.w900,
                              color: color,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── 6. Tree Hollow Display (Popping Image + Sliding Word) ───
        Positioned(
          top: 110,
          left: 20,
          width: 175,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Popping Image / Emoji inside the hollow (Scale 0 -> 1.3 -> 1.0)
              Container(
                key: ValueKey('img_${current['id']}'),
                width: 130,
                height: 115,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.94),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: color, width: 3),
                  boxShadow: [
                    BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4)),
                  ],
                ),
                child: Center(
                  child: Text(
                    current['emoji'] as String,
                    style: const TextStyle(fontSize: 64),
                  ),
                ),
              )
                  .animate(key: ValueKey('anim_img_${current['id']}'))
                  .scale(
                    begin: const Offset(0.0, 0.0),
                    end: const Offset(1.0, 1.0),
                    duration: 600.ms,
                    curve: Curves.bounceOut,
                    delay: 200.ms,
                  ),

              const SizedBox(height: 8),

              // Word Sliding Up from below with Tashkeel
              Container(
                key: ValueKey('word_${current['id']}'),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
                  ],
                ),
                child: Text(
                  current['word'] as String,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
                  .animate(key: ValueKey('anim_word_${current['id']}'))
                  .fadeIn(duration: 500.ms, delay: 400.ms)
                  .slideY(
                    begin: 0.8,
                    end: 0.0,
                    duration: 500.ms,
                    curve: Curves.easeOutCubic,
                    delay: 400.ms,
                  ),

              const SizedBox(height: 8),

              // Replay Audio Speaker Button
              ElevatedButton.icon(
                onPressed: () => _playSound(current),
                icon: const Icon(Icons.volume_up_rounded, size: 20),
                label: Text(
                  current['harakaName'] as String,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.baaSpeaker,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ],
          ),
        ),

        // ── 7. Bottom Navigation Arrows ───────────────────────────
        Positioned(
          bottom: 12,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
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
              ElevatedButton.icon(
                onPressed: widget.onNext,
                icon: const Text('التالي', style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold)),
                label: const Icon(Icons.arrow_forward_ios, size: 16),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.nextButton,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══ END OF FILE ═══

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';
import 'dart:math';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';

/// لعبة صيد الحرف: أحرف تسقط من الأعلى، الطفل يلمس الحرف الصحيح فقط
class CatchLetterGame extends ConsumerStatefulWidget {
  const CatchLetterGame({super.key});

  @override
  ConsumerState<CatchLetterGame> createState() => _CatchLetterGameState();
}

class _FallingLetter {
  String char;
  double x;
  double y;
  double speed;
  bool isTarget;

  _FallingLetter({
    required this.char,
    required this.x,
    required this.y,
    required this.speed,
    required this.isTarget,
  });
}

class _CatchLetterGameState extends ConsumerState<CatchLetterGame> with SingleTickerProviderStateMixin {
  late ConfettiController _confetti;
  late AnimationController _ticker;
  final List<_FallingLetter> _letters = [];
  int _score = 0;
  int _misses = 0;
  final int _maxMisses = 3;
  final int _targetScore = 10;
  bool _gameOver = false;
  bool _won = false;
  String _targetChar = '';
  Timer? _spawnTimer;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _ticker = AnimationController(vsync: this, duration: const Duration(hours: 1))
      ..addListener(_tick)
      ..forward();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startGame());
  }

  void _startGame() {
    final letter = ref.read(currentLessonProvider).letter;
    if (letter == null) return;
    _targetChar = letter.letter;
    _spawnTimer = Timer.periodic(const Duration(milliseconds: 1200), (_) => _spawnLetter());
  }

  @override
  void dispose() {
    _confetti.dispose();
    _ticker.dispose();
    _spawnTimer?.cancel();
    super.dispose();
  }

  void _spawnLetter() {
    if (_gameOver) return;
    final size = context.size;
    if (size == null) return;

    final isTarget = _random.nextDouble() < 0.45;
    final char = isTarget ? _targetChar : arabicLetters[_random.nextInt(arabicLetters.length)].letter;

    if (mounted) {
      setState(() {
        _letters.add(_FallingLetter(
          char: char,
          x: _random.nextDouble() * (size.width - 80) + 40,
          y: -60,
          speed: _random.nextDouble() * 1.5 + 1.5,
          isTarget: isTarget,
        ));
      });
    }
  }

  void _tick() {
    if (_gameOver || !mounted) return;
    final size = context.size;
    if (size == null) return;

    setState(() {
      for (final letter in _letters) {
        letter.y += letter.speed;
      }
      // Remove letters that fell off screen
      final fallen = _letters.where((l) => l.y > size.height + 60 && l.isTarget).length;
      _letters.removeWhere((l) => l.y > size.height + 60);
      if (fallen > 0) {
        _misses += fallen;
        if (_misses >= _maxMisses) _endGame(won: false);
      }
    });
  }

  void _onTap(int index) {
    if (_gameOver) return;
    final letter = _letters[index];

    if (letter.isTarget) {
      HapticFeedback.heavyImpact();
      setState(() {
        _score++;
        _letters.removeAt(index);
      });
      if (_score >= _targetScore) _endGame(won: true);
    } else {
      HapticFeedback.vibrate();
      setState(() {
        _misses++;
        _letters.removeAt(index);
      });
      if (_misses >= _maxMisses) _endGame(won: false);
    }
  }

  void _endGame({required bool won}) {
    _spawnTimer?.cancel();
    setState(() {
      _gameOver = true;
      _won = won;
    });
    if (won) {
      _confetti.play();
      ref.read(currentLessonProvider.notifier).completeCurrentActivity();
    }
  }

  @override
  Widget build(BuildContext context) {
    final letter = ref.watch(currentLessonProvider).letter;
    if (letter == null) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Stack(
      children: [
        // Background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0D1B2A), Color(0xFF1B2A4A)],
            ),
          ),
        ),

        // HUD
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HudItem(label: 'النقاط', value: '$_score/$_targetScore', icon: Icons.star_rounded, color: Colors.amber),
                // Target letter hint
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.oasisGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.oasisGreen, width: 2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.catching_pokemon_rounded, color: AppColors.oasisGreen, size: 20),
                      const SizedBox(width: 6),
                      Text('اصطد: $_targetChar', style: const TextStyle(color: AppColors.oasisGreen, fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                _HudItem(label: 'الحياة', value: '${_maxMisses - _misses}', icon: Icons.favorite_rounded, color: Colors.red),
              ],
            ),
          ),
        ),

        // Falling letters
        ..._letters.asMap().entries.map((entry) {
          final i = entry.key;
          final fl = entry.value;
          return Positioned(
            left: fl.x - 35,
            top: fl.y - 35,
            child: GestureDetector(
              onTap: () => _onTap(i),
              child: Container(
                width: isTablet ? 80 : 70,
                height: isTablet ? 80 : 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: fl.isTarget
                        ? [const Color(0xFF4CAF50), const Color(0xFF1B5E20)]
                        : [const Color(0xFF9E9E9E), const Color(0xFF424242)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (fl.isTarget ? Colors.green : Colors.grey).withValues(alpha: 0.5),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(fl.char, style: TextStyle(fontSize: isTablet ? 36 : 30, fontFamily: 'Cairo', color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          );
        }),

        // Game over overlay
        if (_gameOver)
          Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_won ? '🎉 أحسنت!' : '💔 حاول مرة أخرى', style: TextStyle(fontSize: isTablet ? 48 : 36, color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text('النقاط: $_score', style: const TextStyle(fontSize: 28, color: Colors.white70, fontFamily: 'Cairo')),
                  const SizedBox(height: 24),
                  if (!_won)
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _letters.clear();
                          _score = 0;
                          _misses = 0;
                          _gameOver = false;
                          _won = false;
                        });
                        _startGame();
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('العب مجدداً', style: TextStyle(fontFamily: 'Cairo', fontSize: 20)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.oasisGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                    ),
                ],
              ),
            ),
          ).animate().fadeIn(),

        // Confetti
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 40,
            colors: const [Colors.amber, Colors.green, Colors.blue, Colors.purple],
          ),
        ),
      ],
    );
  }
}

class _HudItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _HudItem({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 4),
          Text(value, style: TextStyle(color: color, fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

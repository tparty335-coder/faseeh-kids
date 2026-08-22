import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';

/// لعبة تمييز الصوت: يسمع الطفل الصوت ويختار البطاقة الصحيحة من 3
class AudioRecognitionGame extends ConsumerStatefulWidget {
  const AudioRecognitionGame({super.key});

  @override
  ConsumerState<AudioRecognitionGame> createState() => _AudioRecognitionGameState();
}

class _AudioRecognitionGameState extends ConsumerState<AudioRecognitionGame> {
  late ConfettiController _confetti;
  List<String> _options = [];
  String? _correctLetter;
  String? _selectedLetter;
  int _score = 0;
  int _round = 0;
  final int _totalRounds = 5;
  bool _roundComplete = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) => _generateRound());
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  void _generateRound() {
    final letter = ref.read(currentLessonProvider).letter;
    if (letter == null) return;

    final random = Random();
    final options = <String>{letter.letter};
    while (options.length < 3) {
      options.add(arabicLetters[random.nextInt(arabicLetters.length)].letter);
    }

    setState(() {
      _correctLetter = letter.letter;
      _options = options.toList()..shuffle();
      _selectedLetter = null;
      _roundComplete = false;
    });

    // Play the sound after a short delay
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      final key = AudioRegistry.letterKeyFromChar(letter.letter);
      AudioManager.instance.playLetterAudio(key, 'sound');
    });
  }

  void _onSelect(String letter) {
    if (_roundComplete) return;
    HapticFeedback.selectionClick();
    final correct = letter == _correctLetter;

    setState(() {
      _selectedLetter = letter;
      _roundComplete = true;
      if (correct) _score++;
    });

    if (correct) {
      _confetti.play();
      HapticFeedback.heavyImpact();
      AudioManager.instance.playFeedback('excellent');
    } else {
      HapticFeedback.vibrate();
      AudioManager.instance.playFeedback('try_again');
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (_round < _totalRounds - 1) {
        setState(() => _round++);
        _generateRound();
      } else {
        ref.read(currentLessonProvider.notifier).completeCurrentActivity();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final letter = ref.watch(currentLessonProvider).letter;
    if (letter == null || _options.isEmpty) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ConfettiWidget(
          confettiController: _confetti,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 30,
          colors: const [AppColors.oasisGreen, AppColors.desertSand, AppColors.skyBlue, Colors.purple],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Score + round
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _InfoChip(label: 'الجولة', value: '${_round + 1}/$_totalRounds', color: AppColors.skyBlue),
                  _InfoChip(label: 'النقاط', value: '$_score', color: AppColors.oasisGreen),
                ],
              ),
              SizedBox(height: isTablet ? 40 : 24),

              // Sound button
              GestureDetector(
                onTap: () {
                  final key = AudioRegistry.letterKeyFromChar(letter.letter);
                  AudioManager.instance.playLetterAudio(key, 'sound');
                },
                child: Container(
                  width: isTablet ? 160 : 130,
                  height: isTablet ? 160 : 130,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.volume_up_rounded, color: Colors.white, size: isTablet ? 60 : 50),
                      const SizedBox(height: 8),
                      Text('استمع', style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: isTablet ? 20 : 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(end: 1.05, duration: 1.5.seconds, curve: Curves.easeInOut),

              SizedBox(height: isTablet ? 48 : 32),

              Text('أي حرف سمعت؟', style: TextStyle(fontSize: isTablet ? 28 : 22, fontWeight: FontWeight.bold, color: AppColors.desertSand, fontFamily: 'Cairo')),
              SizedBox(height: isTablet ? 32 : 20),

              // Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _options.map((opt) {
                  final isSelected = _selectedLetter == opt;
                  final isCorrect = opt == _correctLetter;
                  Color bgColor = Colors.white;
                  Color borderColor = Colors.grey.shade300;
                  if (_roundComplete && isSelected) {
                    bgColor = isCorrect ? AppColors.oasisGreen : Colors.orange;
                    borderColor = bgColor;
                  } else if (_roundComplete && isCorrect) {
                    bgColor = AppColors.oasisGreen.withValues(alpha: 0.3);
                    borderColor = AppColors.oasisGreen;
                  }

                  return GestureDetector(
                    onTap: () => _onSelect(opt),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isTablet ? 130 : 100,
                      height: isTablet ? 130 : 100,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderColor, width: 3),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Center(
                        child: Text(opt,
                          style: TextStyle(
                            fontSize: isTablet ? 64 : 52,
                            fontFamily: 'Cairo',
                            color: (_roundComplete && (isSelected || isCorrect)) ? Colors.white : AppColors.skyBlue,
                          ),
                        ),
                      ),
                    ),
                  ).animate(delay: Duration(milliseconds: _options.indexOf(opt) * 100)).scale(begin: const Offset(0.7, 0.7));
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _InfoChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: color, fontFamily: 'Cairo')),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color, fontFamily: 'Cairo')),
        ],
      ),
    );
  }
}

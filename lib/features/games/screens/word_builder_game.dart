import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';

/// لعبة تركيب الكلمة: الطفل يرتب الحروف المبعثرة ليصنع الكلمة الصحيحة
class WordBuilderGame extends ConsumerStatefulWidget {
  const WordBuilderGame({super.key});

  @override
  ConsumerState<WordBuilderGame> createState() => _WordBuilderGameState();
}

class _WordBuilderGameState extends ConsumerState<WordBuilderGame> {
  late ConfettiController _confetti;
  List<String> _shuffled = [];
  List<String?> _answer = [];
  List<String> _targetWord = [];
  bool _isComplete = false;
  int _round = 0;
  final int _totalRounds = 3;

  // Words for each letter — short 3-letter words only
  static const Map<String, List<String>> _letterWords = {
    'ا': ['أسد', 'أرز', 'أمل'],
    'ب': ['بيت', 'باب', 'بحر'],
    'ت': ['تين', 'تاج', 'تمر'],
    'ث': ['ثور', 'ثعب', 'ثلج'],
    'ج': ['جمل', 'جبل', 'جرو'],
    'ح': ['حصن', 'حمل', 'حوت'],
    'خ': ['خيل', 'خبز', 'ختم'],
    'د': ['دجاج', 'دلو', 'دين'],
    'ذ': ['ذرة', 'ذيل', 'ذهب'],
    'ر': ['رمل', 'رحل', 'ربط'],
    'ز': ['زهر', 'زيت', 'زرع'],
    'س': ['سمك', 'سهم', 'سبع'],
    'ش': ['شمس', 'شجر', 'شبك'],
    'ص': ['صقر', 'صبر', 'صفر'],
    'ض': ['ضفدع', 'ضوء', 'ضرب'],
    'ط': ['طير', 'طحن', 'طبل'],
    'ظ': ['ظبي', 'ظلم', 'ظرف'],
    'ع': ['عين', 'عسل', 'عجل'],
    'غ': ['غنم', 'غيم', 'غزل'],
    'ف': ['فيل', 'فرس', 'فتح'],
    'ق': ['قمر', 'قلم', 'قرد'],
    'ك': ['كتب', 'كلب', 'كبش'],
    'ل': ['ليث', 'لمع', 'لعب'],
    'م': ['مدد', 'ملح', 'مطر'],
    'ن': ['نمر', 'نحل', 'نهر'],
    'ه': ['هلل', 'هدف', 'همس'],
    'و': ['ورد', 'وقت', 'وتر'],
    'ي': ['يد', 'ينع', 'يسر'],
  };

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

    final words = _letterWords[letter.letter] ?? ['بيت', 'باب', 'بحر'];
    final word = words[_round % words.length];
    final chars = word.split('');

    setState(() {
      _targetWord = chars;
      _answer = List.filled(chars.length, null);
      _shuffled = chars.toList()..shuffle(Random());
      _isComplete = false;
    });

    AudioManager.instance.playFeedback('continue');
  }

  void _onLetterTap(String letter, int shuffledIndex) {
    if (_isComplete) return;
    final emptySlot = _answer.indexWhere((s) => s == null);
    if (emptySlot == -1) return;

    HapticFeedback.selectionClick();
    setState(() {
      _answer[emptySlot] = letter;
      _shuffled[shuffledIndex] = '';
    });

    // Check if complete
    if (!_answer.contains(null)) {
      final assembled = _answer.join();
      final target = _targetWord.join();
      if (assembled == target) {
        setState(() => _isComplete = true);
        _confetti.play();
        HapticFeedback.heavyImpact();
        AudioManager.instance.playFeedback('excellent');
        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;
          if (_round < _totalRounds - 1) {
            setState(() => _round++);
            _generateRound();
          } else {
            ref.read(currentLessonProvider.notifier).completeCurrentActivity();
          }
        });
      } else {
        // Wrong order — reset
        HapticFeedback.vibrate();
        AudioManager.instance.playFeedback('try_again');
        Future.delayed(const Duration(milliseconds: 800), () {
          if (!mounted) return;
          _resetAnswer();
        });
      }
    }
  }

  void _resetAnswer() {
    setState(() {
      _answer = List.filled(_targetWord.length, null);
      _shuffled = _targetWord.toList()..shuffle(Random());
    });
  }

  @override
  Widget build(BuildContext context) {
    final letter = ref.watch(currentLessonProvider).letter;
    if (letter == null || _shuffled.isEmpty) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;
    final tileSize = isTablet ? 90.0 : 72.0;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ConfettiWidget(
          confettiController: _confetti,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 30,
          colors: const [AppColors.oasisGreen, AppColors.desertSand, AppColors.skyBlue],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('رتّب الحروف لتكوّن كلمة', style: TextStyle(fontSize: isTablet ? 26 : 20, fontWeight: FontWeight.bold, color: AppColors.desertSand, fontFamily: 'Cairo')),
              Text('الجولة ${_round + 1}/$_totalRounds', style: TextStyle(fontSize: isTablet ? 18 : 14, color: Colors.grey, fontFamily: 'Cairo')),
              SizedBox(height: isTablet ? 40 : 24),

              // Answer slots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_answer.length, (i) {
                  final char = _answer[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: tileSize,
                      height: tileSize,
                      decoration: BoxDecoration(
                        color: char != null
                            ? (_isComplete ? AppColors.oasisGreen : AppColors.skyBlue.withValues(alpha: 0.15))
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: char != null ? AppColors.skyBlue : Colors.grey.shade300,
                          width: 2.5,
                        ),
                        boxShadow: char != null ? [BoxShadow(color: AppColors.skyBlue.withValues(alpha: 0.2), blurRadius: 8)] : null,
                      ),
                      child: Center(
                        child: Text(
                          char ?? '',
                          style: TextStyle(fontSize: isTablet ? 42 : 34, fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: _isComplete ? Colors.white : AppColors.skyBlue),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: isTablet ? 32 : 20),

              // Reset button
              TextButton.icon(
                onPressed: _resetAnswer,
                icon: const Icon(Icons.refresh_rounded, color: Colors.grey),
                label: Text('إعادة', style: TextStyle(color: Colors.grey, fontFamily: 'Cairo', fontSize: isTablet ? 18 : 14)),
              ),

              SizedBox(height: isTablet ? 32 : 16),

              // Shuffled tiles
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: List.generate(_shuffled.length, (i) {
                  final char = _shuffled[i];
                  if (char.isEmpty) {
                    return SizedBox(width: tileSize, height: tileSize);
                  }
                  return GestureDetector(
                    onTap: () => _onLetterTap(char, i),
                    child: Container(
                      width: tileSize,
                      height: tileSize,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.orange.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 4))],
                      ),
                      child: Center(
                        child: Text(char, style: TextStyle(fontSize: isTablet ? 42 : 34, fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ).animate().scale(begin: const Offset(0.8, 0.8), duration: 200.ms),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

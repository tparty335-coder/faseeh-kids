import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class QuizActivityScreen extends ConsumerStatefulWidget {
  const QuizActivityScreen({super.key});

  @override
  ConsumerState<QuizActivityScreen> createState() => _QuizActivityScreenState();
}

class _QuizActivityScreenState extends ConsumerState<QuizActivityScreen> {
  late ConfettiController _confettiController;
  int _questionIndex = 0;
  final int _totalQuestions = 3;
  String? _selectedLetter;
  bool? _isCorrect;
  List<String> _options = [];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateOptions();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _generateOptions() {
    final letter = ref.read(currentLessonProvider).letter;
    if (letter == null) return;

    final random = Random();
    final options = {letter.letter};
    
    while (options.length < 4) {
      final randomLetter = arabicLetters[random.nextInt(arabicLetters.length)].letter;
      options.add(randomLetter);
    }
    
    setState(() {
      _options = options.toList()..shuffle();
      _selectedLetter = null;
      _isCorrect = null;
    });
  }

  void _onOptionSelected(String option) {
    if (_isCorrect == true) return; // Prevent multiple clicks if already correct
    
    final targetLetter = ref.read(currentLessonProvider).letter?.letter;
    final correct = option == targetLetter;
    
    setState(() {
      _selectedLetter = option;
      _isCorrect = correct;
    });
    
    if (correct) {
      _confettiController.play();
      AudioManager.instance.playFeedback('excellent');
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        
        if (_questionIndex < _totalQuestions - 1) {
          setState(() {
            _questionIndex++;
          });
          _generateOptions();
        } else {
          ref.read(currentLessonProvider.notifier).completeCurrentActivity();
          // Lesson complete!
        }
      });
    } else {
      AudioManager.instance.playFeedback('try_again');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null || _options.isEmpty) return const SizedBox.shrink();

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'أين حرف ${letter.letter}؟',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.desertSand,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'السؤال ${_questionIndex + 1} من $_totalQuestions',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            
            const SizedBox(height: 60),
            
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: _options.map((option) {
                final isSelected = _selectedLetter == option;
                final isCorrectChoice = isSelected && _isCorrect == true;
                final isWrongChoice = isSelected && _isCorrect == false;
                
                return GestureDetector(
                  onTap: () => _onOptionSelected(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCorrectChoice 
                          ? AppColors.oasisGreen 
                          : (isWrongChoice ? Colors.orange : Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: isCorrectChoice 
                              ? AppColors.oasisGreen.withValues(alpha: 0.5) 
                              : Colors.black.withValues(alpha: 0.1),
                          blurRadius: 15,
                          spreadRadius: isCorrectChoice ? 5 : 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 60,
                          color: isSelected ? Colors.white : AppColors.skyBlue,
                        ),
                      ),
                    ),
                  )
                  .animate(target: isWrongChoice ? 1 : 0)
                  .shake(hz: 4, curve: Curves.easeInOutCubic, duration: 300.ms),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 60),
            
            // Feedback Text
            AnimatedOpacity(
              opacity: _isCorrect != null ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Text(
                _isCorrect == true ? 'أحسنت! 🌟' : 'لنجرب مرة أخرى!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _isCorrect == true ? AppColors.oasisGreen : Colors.orange,
                ),
              ),
            ),
            
            if (_isCorrect == true && _questionIndex == _totalQuestions - 1)
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.desertSand,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Navigate back or to success screen
                    Navigator.of(context).pop();
                  },
                  child: const Text('إنهاء الدرس', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ).animate().scale(),
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

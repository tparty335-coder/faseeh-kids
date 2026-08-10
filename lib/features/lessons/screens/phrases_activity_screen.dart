import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PhrasesActivityScreen extends ConsumerWidget {
  const PhrasesActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    final key = AudioRegistry.letterKeyFromChar(letter.letter);
    
    // Simplistic mock sentence for the task. Ideally this would be loaded from FullLetterCurriculum.
    final String sentenceText = 'هَذَا ${letter.exampleWords.isNotEmpty ? letter.exampleWords[0] : letter.name} جَمِيلٌ';

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'اقرأ الجملة',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.desertSand,
            ),
          ),
        ),
        
        Expanded(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 48, fontFamily: 'Cairo', color: AppColors.textPrimary, height: 1.5),
                      children: _buildHighlightedText(sentenceText, letter.letter),
                    ),
                  ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.8, 0.8)),
                  
                  const SizedBox(height: 40),
                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.skyBlue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.volume_up, color: AppColors.skyBlue, size: 48),
                      onPressed: () {
                        AudioManager.instance.playLetterAudio(key, 'sentence');
                      },
                    ),
                  ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.5, 0.5)),
                ],
              ),
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.oasisGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              ref.read(currentLessonProvider.notifier).completeCurrentActivity();
              ref.read(currentLessonProvider.notifier).nextActivity();
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('التالي', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _buildHighlightedText(String text, String targetLetter) {
    List<TextSpan> spans = [];
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final isTarget = char == targetLetter || (char == 'أ' && targetLetter == 'أ');
      
      spans.add(
        TextSpan(
          text: char,
          style: TextStyle(
            color: isTarget ? Colors.orange : AppColors.textPrimary,
            fontWeight: isTarget ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }
    return spans;
  }
}

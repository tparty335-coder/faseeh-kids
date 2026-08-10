import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WordsActivityScreen extends ConsumerWidget {
  const WordsActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'كلمات تبدأ بالحرف',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.desertSand,
            ),
          ),
        ),
        
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: letter.exampleWords.length,
            itemBuilder: (context, index) {
              final word = letter.exampleWords[index];
              return _WordCard(word: word, targetLetter: letter.letter)
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 200 * index))
                  .slideX(begin: 0.2, end: 0);
            },
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
}

class _WordCard extends StatelessWidget {
  final String word;
  final String targetLetter;

  const _WordCard({required this.word, required this.targetLetter});

  List<TextSpan> _buildHighlightedText() {
    List<TextSpan> spans = [];
    
    // Very simple highlight logic - in a real app would need complex Arabic text handling
    // especially for connected letters.
    for (int i = 0; i < word.length; i++) {
      final char = word[i];
      // simplified check, Arabic matching needs normalisation (stripping diacritics etc.)
      final isTarget = char == targetLetter || char == 'أ' && targetLetter == 'أ';
      
      spans.add(
        TextSpan(
          text: char,
          style: TextStyle(
            color: isTarget ? Colors.orange : AppColors.skyBlue,
            fontWeight: isTarget ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.skyBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.volume_up, color: AppColors.skyBlue, size: 32),
              onPressed: () {
                // Use playByKey with fallback to TTS for the word
                AudioManager.instance.playByKey(
                  '${AudioRegistry.letterKeyFromChar(targetLetter)}_word',
                  fallbackText: word,
                );
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 48, fontFamily: 'Cairo'),
                children: _buildHighlightedText(),
              ),
            ),
          ),
          // Vocabulary card illustration badge (responsive)
          Builder(
            builder: (context) {
              final badgeSize = (MediaQuery.sizeOf(context).width * 0.16).clamp(56.0, 80.0);
              return Container(
                width: badgeSize,
                height: badgeSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.sandWarm.withValues(alpha: 0.2),
                  border: Border.all(color: AppColors.accent, width: 2),
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_stories_rounded,
                    size: badgeSize * 0.5,
                    color: AppColors.accent,
                  ),
                ),
              )
                  .animate()
                  .scale(duration: 400.ms, curve: Curves.elasticOut)
                  .then()
                  .shimmer(duration: 1500.ms);
            },
          ),
        ],
      ),
    );
  }
}

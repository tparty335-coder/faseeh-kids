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
              final letterKey = AudioRegistry.letterKeyFromChar(letter.letter);
              // Map each word to its known image filename
              final wordImageMap = <String, String>{
                'أَسَد': '${letterKey}_word_asad',
                'أُذُن': '${letterKey}_word_udhun',
                'إِبْرَة': '${letterKey}_word_ibra',
                'آمَال': '${letterKey}_word_amal',
              };
              final imgKey = wordImageMap[word];
              final imagePath = imgKey != null
                  ? 'assets/images/lessons/$letterKey/$imgKey.jpg'
                  : null;
              return _WordCard(
                word: word,
                targetLetter: letter.letter,
                index: index,
                imageAssetPath: imagePath,
              )
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
  final int index;
  final String? imageAssetPath;

  const _WordCard({
    required this.word,
    required this.targetLetter,
    required this.index,
    this.imageAssetPath,
  });

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
                final key = AudioRegistry.letterKeyFromChar(targetLetter);
                final suffix = index == 0 ? 'word' : 'word${index + 1}';
                AudioManager.instance.playByKey(
                  '${key}_$suffix',
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
          // Word illustration — shows image if available, falls back to icon
          Builder(
            builder: (context) {
              final badgeSize = (MediaQuery.sizeOf(context).width * 0.18).clamp(64.0, 96.0);
              return ClipRRect(
                borderRadius: BorderRadius.circular(badgeSize * 0.25),
                child: imageAssetPath != null
                    ? Image.asset(
                        imageAssetPath!,
                        width: badgeSize,
                        height: badgeSize,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _fallbackBadge(badgeSize),
                      )
                    : _fallbackBadge(badgeSize),
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

  Widget _fallbackBadge(double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.25),
          color: AppColors.sandWarm.withValues(alpha: 0.2),
          border: Border.all(color: AppColors.accent, width: 2),
        ),
        child: Center(
          child: Icon(Icons.auto_stories_rounded, size: size * 0.5, color: AppColors.accent),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PositionsActivityScreen extends ConsumerWidget {
  const PositionsActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    final key = AudioRegistry.letterKeyFromChar(letter.letter);
    
    // Simplistic mapping for standard letters - ideally this comes from the Curriculum
    // but the task asks to build the UI cards and play 'key_pos_start' etc.
    final positions = [
      {'label': 'أول الكلمة', 'variant': 'pos_start', 'char': '${letter.letter}ـ', 'example': letter.exampleWords.isNotEmpty ? letter.exampleWords[0] : ''},
      {'label': 'وسط الكلمة', 'variant': 'pos_middle', 'char': 'ـ${letter.letter}ـ', 'example': letter.exampleWords.length > 1 ? letter.exampleWords[1] : ''},
      {'label': 'آخر الكلمة', 'variant': 'pos_end', 'char': 'ـ${letter.letter}', 'example': letter.exampleWords.length > 2 ? letter.exampleWords[2] : ''},
    ];

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'أشكال الحرف',
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
            itemCount: positions.length,
            itemBuilder: (context, index) {
              final pos = positions[index];
              return _PositionCard(
                label: pos['label']!,
                displayChar: pos['char']!,
                exampleWord: pos['example']!,
                letterKey: key,
                variant: pos['variant']!,
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

class _PositionCard extends StatelessWidget {
  final String label;
  final String displayChar;
  final String exampleWord;
  final String letterKey;
  final String variant;

  const _PositionCard({
    required this.label,
    required this.displayChar,
    required this.exampleWord,
    required this.letterKey,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.skyBlue.withValues(alpha: 0.3), width: 2),
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
                AudioManager.instance.playLetterAudio(letterKey, variant);
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                ),
                Text(
                  displayChar,
                  style: const TextStyle(fontSize: 40, fontFamily: 'Cairo', color: AppColors.skyBlue, height: 1.2),
                ),
                if (exampleWord.isNotEmpty)
                  Text(
                    exampleWord,
                    style: const TextStyle(fontSize: 20, fontFamily: 'Cairo', color: AppColors.textPrimary),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

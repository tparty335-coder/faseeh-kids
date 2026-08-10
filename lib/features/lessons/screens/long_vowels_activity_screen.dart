import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LongVowelsActivityScreen extends ConsumerWidget {
  const LongVowelsActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    final key = AudioRegistry.letterKeyFromChar(letter.letter);
    
    final vowels = [
      {'label': 'المد بالألف', 'variant': 'madd_alif', 'char': '${letter.letter}َا'},
      {'label': 'المد بالواو', 'variant': 'madd_demo', 'char': '${letter.letter}ُو'},
      {'label': 'المد بالياء', 'variant': 'madd_demo', 'char': '${letter.letter}ِي'},
    ];

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'الحركات الطويلة (المدود)',
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
            itemCount: vowels.length,
            itemBuilder: (context, index) {
              final vowel = vowels[index];
              return _LongVowelCard(
                label: vowel['label']!,
                displayChar: vowel['char']!,
                letterKey: key,
                variant: vowel['variant']!,
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

class _LongVowelCard extends StatelessWidget {
  final String label;
  final String displayChar;
  final String letterKey;
  final String variant;

  const _LongVowelCard({
    required this.label,
    required this.displayChar,
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
                  style: const TextStyle(fontSize: 48, fontFamily: 'Cairo', color: AppColors.skyBlue, height: 1.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

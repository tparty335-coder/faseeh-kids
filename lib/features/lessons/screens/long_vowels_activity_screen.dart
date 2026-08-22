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
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    final vowels = [
      {'label': 'المد بالألف', 'char': '${letter.letter}َا', 'color': const Color(0xFFE53935)},
      {'label': 'المد بالواو', 'char': '${letter.letter}ُو', 'color': const Color(0xFF1E88E5)},
      {'label': 'المد بالياء', 'char': '${letter.letter}ِي', 'color': const Color(0xFF43A047)},
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title
        Container(
          margin: const EdgeInsets.only(top: 24, bottom: 40),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.oasisGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.oasisGreen.withValues(alpha: 0.5), width: 2),
          ),
          child: Text(
            'الحركات الطويلة (المدود)',
            style: TextStyle(
              fontSize: isTablet ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: AppColors.oasisGreen,
              fontFamily: 'Cairo',
            ),
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

        // 3 Mudud Cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: vowels.map((vowel) {
              return Expanded(
                child: _LongVowelCard(
                  label: vowel['label'] as String,
                  displayChar: vowel['char'] as String,
                  color: vowel['color'] as Color,
                  isTablet: isTablet,
                ).animate().scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 50),

        // BIG Central Play Button for the Full Demo
        GestureDetector(
          onTap: () {
            // This plays the full madd demo audio which contains the explanation and examples
            AudioManager.instance.playLetterAudio(key, 'madd_demo');
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 48 : 32, vertical: isTablet ? 24 : 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.desertSand, Color(0xFFC79244)]),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: AppColors.desertSand.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.volume_up_rounded, color: Colors.white, size: 40),
                const SizedBox(width: 16),
                Text(
                  'استمع لشرح المدود',
                  style: TextStyle(
                    fontSize: isTablet ? 26 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

        const Spacer(),

        // Next Activity Button
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.oasisGreen,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24, vertical: isTablet ? 18 : 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 4,
            ),
            onPressed: () {
              ref.read(currentLessonProvider.notifier).completeCurrentActivity();
              ref.read(currentLessonProvider.notifier).nextActivity();
            },
            icon: const Icon(Icons.check_circle_outline, size: 28),
            label: Text('انتهيت', style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
          ).animate().scale(delay: 600.ms),
        ),
      ],
    );
  }
}

class _LongVowelCard extends StatelessWidget {
  final String label;
  final String displayChar;
  final Color color;
  final bool isTablet;

  const _LongVowelCard({
    required this.label,
    required this.displayChar,
    required this.color,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: isTablet ? 32 : 24, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 3),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: color,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          SizedBox(height: isTablet ? 24 : 16),
          Text(
            displayChar,
            style: TextStyle(
              fontSize: isTablet ? 72 : 48,
              fontFamily: 'Cairo',
              color: AppColors.textPrimaryDay,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

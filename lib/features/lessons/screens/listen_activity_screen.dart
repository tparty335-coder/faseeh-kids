import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';

class ListenActivityScreen extends ConsumerWidget {
  const ListenActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    final screenWidth = MediaQuery.sizeOf(context).width;
    final circleSize = (screenWidth * 0.55).clamp(160.0, 280.0);
    final letterFontSize = (circleSize * 0.6).clamp(60.0, 170.0);
    final vowelFontSize = (screenWidth * 0.1).clamp(28.0, 56.0);
    final key = AudioRegistry.letterKeyFromChar(letter.letter);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Huge Letter
        GestureDetector(
          onTap: () {
            AudioManager.instance.playLetterAudio(key, 'name');
          },
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.desertSand.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                letter.letter,
                style: TextStyle(
                  fontSize: letterFontSize,
                  color: AppColors.desertSand,
                  fontFamily: 'Cairo',
                  height: 1,
                ),
              ),
            ),
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
         .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds),
         
        const SizedBox(height: 40),
        
        // Vowels
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _VowelButton(letter: letter.letter, vowel: 'َ', variant: 'fatha', letterKey: key, fontSize: vowelFontSize),
            const SizedBox(width: 20),
            _VowelButton(letter: letter.letter, vowel: 'ِ', variant: 'kasra', letterKey: key, fontSize: vowelFontSize),
            const SizedBox(width: 20),
            _VowelButton(letter: letter.letter, vowel: 'ُ', variant: 'damma', letterKey: key, fontSize: vowelFontSize),
          ],
        ).animate().fadeIn(delay: 300.ms),
        
        const Spacer(),
        
        // Next Button
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

class _VowelButton extends StatelessWidget {
  final String letter;
  final String vowel;
  final String variant;
  final String letterKey;
  final double fontSize;

  const _VowelButton({
    required this.letter,
    required this.vowel,
    required this.variant,
    required this.letterKey,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.skyBlue.withValues(alpha: 0.3), width: 2),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            '$letter$vowel',
            style: TextStyle(fontSize: fontSize, color: AppColors.skyBlue, fontFamily: 'Cairo'),
          ),
        ),
        const SizedBox(height: 8),
        IconButton(
          icon: const Icon(Icons.volume_up, color: AppColors.desertSand),
          onPressed: () {
            AudioManager.instance.playLetterAudio(letterKey, variant);
          },
        ),
      ],
    );
  }
}

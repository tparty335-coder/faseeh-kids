import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SongActivityScreen extends ConsumerWidget {
  const SongActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox();

    final letterKey = AudioRegistry.letterKeyFromChar(letter.letter);
    final audioKey = 'song_$letterKey'; 

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.desertSand.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.music_note_rounded, size: 100, color: AppColors.oasisGreen),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(end: 1.1, duration: 1.seconds, curve: Curves.easeInOut),
          
          const SizedBox(height: 48),
          
          Text(
            'نشيد حرف ${letter.name}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.desertSand,
              fontFamily: 'Cairo',
            ),
          ),
          
          const SizedBox(height: 24),
          
          ElevatedButton.icon(
            onPressed: () {
              AudioManager.instance.playByKey(
                audioKey, 
                fallbackText: 'أنشودة حرف ${letter.name} الجميلة.',
                channel: AudioChannel.voice,
              );
              ref.read(currentLessonProvider.notifier).completeCurrentActivity();
            },
            icon: const Icon(Icons.play_circle_fill_rounded, size: 32),
            label: const Text('استمع للنشيد', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.skyBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              elevation: 4,
            ),
          ).animate().slideY(begin: 0.5, end: 0, duration: 300.ms, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}

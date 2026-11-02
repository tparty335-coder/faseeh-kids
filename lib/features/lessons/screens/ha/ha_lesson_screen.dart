import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/ha_manifest.dart';

/// شاشة درس حرف الحاء — تمرر haManifest إلى LetterLessonShellScreen المشتركة
/// الوحدة السادسة: حرف الحاء بثيم أزرق عميق 🐴
class HaLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const HaLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: haManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}

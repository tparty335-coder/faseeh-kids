import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/seen_manifest.dart';

/// شاشة درس حرف السين — تمرر seenManifest إلى LetterLessonShellScreen المشتركة
/// الوحدة الثانية عشرة: حرف السين بثيم أخضر زمردي 🐢
class SeenLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const SeenLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: seenManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/kha_manifest.dart';

/// شاشة درس حرف الحاء — تمرر khaManifest إلى LetterLessonShellScreen المشتركة
/// الوحدة السادسة: حرف الحاء بثيم أزرق عميق 🐑
class KhaLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const KhaLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: khaManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}


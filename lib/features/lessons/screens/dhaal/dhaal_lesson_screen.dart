import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/dhaal_manifest.dart';

/// شاشة درس حرف الذال — تمرر dhaalManifest إلى LetterLessonShellScreen المشتركة
/// الوحدة التاسعة: حرف الذال بثيم عنبري ذهبي 🐺
class DhaalLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const DhaalLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: dhaalManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/dal_manifest.dart';

/// شاشة درس حرف الدال — تمرر dalManifest إلى LetterLessonShellScreen المشتركة
/// الوحدة الثامنة: حرف الدال بثيم أخضر مزرق (تيل) 🐻
class DalLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const DalLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: dalManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}

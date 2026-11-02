import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/raa_manifest.dart';

/// شاشة درس حرف الراء — تمرر raaManifest إلى LetterLessonShellScreen المشتركة
/// الوحدة العاشرة: حرف الراء بثيم وردي داكن 🦌
class RaaLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const RaaLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: raaManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}

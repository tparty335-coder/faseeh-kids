import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/jeem_manifest.dart';

/// شاشة درس حرف الجيم — تعمل عبر LetterLessonShellScreen الموحّد
/// لإضافة حرف جديد: انسخ هذا الملف، غيّر اسم الفئة والمانيفست فقط
class JeemLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const JeemLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: jeemManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}

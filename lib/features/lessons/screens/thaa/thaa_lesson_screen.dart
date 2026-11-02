import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/thaa_manifest.dart';

/// شاشة درس حرف الثاء — تعمل عبر LetterLessonShellScreen الموحّد
/// لإضافة حرف جديد: انسخ هذا الملف، غيّر اسم الفئة والمانيفست فقط
class ThaaLessonScreen extends StatelessWidget {
  final int initialStationIndex;

  const ThaaLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LetterLessonShellScreen(
      manifest: thaaManifest,
      initialStationIndex: initialStationIndex,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';

/// محطة أصوات الحرف — حرف الباء (ب)
/// تستخدم نفس ShortVowelsSequenceWidget المستخدم في حرف الألف تماماً
/// لضمان نمط موحد في التطبيق
class BaaSoundsStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaSoundsStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return ShortVowelsSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'ب',
      isActive: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';

/// محطة أصوات الحرف — حرف الألف (أ)
/// نسخة مرآة مطابقة لـ BaaSoundsStation
class AlifSoundsStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isActive;

  const AlifSoundsStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ShortVowelsSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'أ',
      isActive: isActive,
    );
  }
}

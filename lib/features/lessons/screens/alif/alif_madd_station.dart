import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';

/// محطة الألف الممدودة — حرف الألف (أ)
/// نسخة مرآة مطابقة لـ BaaMaddStation
class AlifMaddStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isActive;

  const AlifMaddStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return LongVowelsSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'أ',
      isActive: isActive,
    );
  }
}

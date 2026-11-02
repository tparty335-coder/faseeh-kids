import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';

/// محطة أصوات الحرف — حرف الباء (ب)
class BaaSoundsStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isActive;

  const BaaSoundsStation({
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
      letterChar: 'ب',
      isActive: isActive,
    );
  }
}

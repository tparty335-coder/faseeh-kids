import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';

/// محطة التاء الممدودة — حرف التاء (ت)
class TaaMaddStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const TaaMaddStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return LongVowelsSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'ت',
      isActive: true,
    );
  }
}



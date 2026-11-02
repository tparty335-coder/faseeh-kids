import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

/// محطة المد — تُغذَّى من MaddSpec
class UniversalMaddStation extends StatelessWidget {
  final MaddSpec spec;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalMaddStation({
    super.key,
    required this.spec,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return LongVowelsSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: spec.letterChar,
    );
  }
}

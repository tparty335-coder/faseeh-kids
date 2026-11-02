import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

/// محطة أصوات الحرف — تُغذَّى من VowelsSpec
class UniversalSoundsStation extends StatelessWidget {
  final VowelsSpec spec;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalSoundsStation({
    super.key,
    required this.spec,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return ShortVowelsSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: spec.letterChar,
    );
  }
}

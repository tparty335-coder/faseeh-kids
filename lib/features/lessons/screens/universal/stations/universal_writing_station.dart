import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

/// محطة كتابة الحرف — تُغذَّى من TracingSpec
class UniversalWritingStation extends StatelessWidget {
  final TracingSpec spec;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalWritingStation({
    super.key,
    required this.spec,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return TraceSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: spec.letterChar,
    );
  }
}

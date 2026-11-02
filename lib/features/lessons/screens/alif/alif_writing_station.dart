import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';

/// محطة كتابة حرف الألف (أ)
/// نسخة مرآة مطابقة لـ BaaWritingStation
class AlifWritingStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const AlifWritingStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return TraceSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'أ',
    );
  }
}

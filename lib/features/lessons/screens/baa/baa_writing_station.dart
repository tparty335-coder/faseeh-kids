import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';

/// محطة كتابة حرف الباء (ب)
/// تستخدم نفس TraceSequenceWidget المستخدم في حرف الألف تماماً
/// مع بيانات الباء الكاملة (أسهم + أرقام + نقطة أسفل الحرف + 4 مواضع)
class BaaWritingStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaWritingStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return TraceSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'ب',
    );
  }
}

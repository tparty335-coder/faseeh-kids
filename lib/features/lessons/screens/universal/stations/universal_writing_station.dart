import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/unified_kiwii_writing_station.dart';

/// محطة كتابة الحرف الموحّدة — تُغذّي جميع الحروف (ت → ي) بتصميم Kiwii / Montessori التفاعلي
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
    return UnifiedKiwiiWritingStation(
      letterChar: spec.letterChar,
      tracingSpec: spec,
      onNext: onNext,
      onPrevious: onPrevious,
    );
  }
}

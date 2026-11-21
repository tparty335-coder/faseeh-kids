import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/unified_kiwii_writing_station.dart';

/// محطة كتابة حرف الألف (أ) — بالتصميم الفيكتوري الموحّد (Kiwii / Montessori)
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
    return UnifiedKiwiiWritingStation(
      letterChar: 'أ',
      onNext: onNext,
      onPrevious: onPrevious,
    );
  }
}

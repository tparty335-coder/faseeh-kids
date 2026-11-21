import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/unified_kiwii_writing_station.dart';

/// محطة كتابة حرف الباء (ب) — بالتصميم الفيكتوري الموحّد (Kiwii / Montessori)
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
    return UnifiedKiwiiWritingStation(
      letterChar: 'ب',
      onNext: onNext,
      onPrevious: onPrevious,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';

/// ظ…ط­ط·ط© ط£طµظˆط§طھ ط§ظ„ط­ط±ظپ â€” ط­ط±ظپ ط§ظ„ط¨ط§ط، (ط¨)
/// طھط³طھط®ط¯ظ… ظ†ظپط³ ShortVowelsSequenceWidget ط§ظ„ظ…ط³طھط®ط¯ظ… ظپظٹ ط­ط±ظپ ط§ظ„ط£ظ„ظپ طھظ…ط§ظ…ط§ظ‹
/// ظ„ط¶ظ…ط§ظ† ظ†ظ…ط· ظ…ظˆط­ط¯ ظپظٹ ط§ظ„طھط·ط¨ظٹظ‚
class TaaSoundsStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const TaaSoundsStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return ShortVowelsSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'ط¨',
      isActive: true,
    );
  }
}



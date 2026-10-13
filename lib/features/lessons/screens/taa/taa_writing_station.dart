import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';

/// ظ…ط­ط·ط© ظƒطھط§ط¨ط© ط­ط±ظپ ط§ظ„ط¨ط§ط، (ط¨)
/// طھط³طھط®ط¯ظ… ظ†ظپط³ TraceSequenceWidget ط§ظ„ظ…ط³طھط®ط¯ظ… ظپظٹ ط­ط±ظپ ط§ظ„ط£ظ„ظپ طھظ…ط§ظ…ط§ظ‹
/// ظ…ط¹ ط¨ظٹط§ظ†ط§طھ ط§ظ„ط¨ط§ط، ط§ظ„ظƒط§ظ…ظ„ط© (ط£ط³ظ‡ظ… + ط£ط±ظ‚ط§ظ… + ظ†ظ‚ط·ط© ط£ط³ظپظ„ ط§ظ„ط­ط±ظپ + 4 ظ…ظˆط§ط¶ط¹)
class TaaWritingStation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const TaaWritingStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return TraceSequenceWidget(
      onNext: onNext,
      onPrevious: onPrevious,
      letterChar: 'ط¨',
    );
  }
}



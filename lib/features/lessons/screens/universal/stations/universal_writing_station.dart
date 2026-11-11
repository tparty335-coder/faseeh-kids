import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/widgets/arabic_letter_tracing_canvas.dart';
import 'package:faseeh_kids/services/audio_service.dart';

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
    final positions = spec.positions;
    if (positions == null || positions.isEmpty) {
      return TraceSequenceWidget(
        onNext: onNext,
        onPrevious: onPrevious,
        letterChar: spec.letterChar,
      );
    }
    return _ManifestWritingView(
      spec: spec,
      positions: positions,
      onNext: onNext,
      onPrevious: onPrevious,
    );
  }
}

class _ManifestWritingView extends StatefulWidget {
  final TracingSpec spec;
  final List<TracingPositionSpec> positions;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const _ManifestWritingView({
    required this.spec,
    required this.positions,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<_ManifestWritingView> createState() => _ManifestWritingViewState();
}

class _ManifestWritingViewState extends State<_ManifestWritingView> {
  int _selected = 0;
  int _token = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _play(widget.spec.audioIntroPath);
    });
  }

  @override
  void dispose() {
    _token++;
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _play(String path) async {
    final tk = ++_token;
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _token) return;
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final pos = widget.positions[_selected];
    final guideImg = pos.imagePath ??
        (widget.spec.stepImagePaths.isNotEmpty
            ? widget.spec.stepImagePaths[_selected % widget.spec.stepImagePaths.length]
            : null);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(widget.positions.length, (i) {
                    final p = widget.positions[i];
                    final sel = i == _selected;
                    return ChoiceChip(
                      selected: sel,
                      selectedColor: AppColors.primaryDay,
                      backgroundColor: AppColors.primaryDay.withValues(alpha: 0.1),
                      labelStyle: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: sel ? Colors.white : AppColors.primaryDay,
                      ),
                      label: Text('${p.displayForm} • ${p.title}'),
                      onSelected: (_) {
                        HapticFeedback.selectionClick();
                        setState(() => _selected = i);
                        _play(p.audioPath);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 10),

                if (guideImg != null && guideImg.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryDay.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(guideImg, fit: BoxFit.contain),
                    ),
                  ),
                const SizedBox(height: 10),

                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _play(pos.audioPath),
                      icon: const Icon(Icons.volume_up_rounded, size: 18),
                      label: Text(
                        pos.title,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDay,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _play(widget.spec.audioIntroPath),
                      icon: const Icon(Icons.menu_book_rounded, size: 18),
                      label: const Text(
                        'شرح الكتابة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                ArabicLetterTracingCanvas(
                  key: ValueKey('${widget.spec.letterChar}_${pos.position}'),
                  letterChar: widget.spec.letterChar,
                  position: pos.position,
                  exampleWord: pos.exampleWord,
                  exampleEmoji: pos.exampleEmoji,
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      AudioService.instance.stop();
                      widget.onPrevious();
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'السابق',
                        maxLines: 1,
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: AppColors.textPrimaryDay,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      AudioService.instance.stop();
                      widget.onNext();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'كلمات الحرف',
                        maxLines: 1,
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDay,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

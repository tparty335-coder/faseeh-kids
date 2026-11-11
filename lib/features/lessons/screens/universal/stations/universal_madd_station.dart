import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// محطة المد — تُغذَّى من MaddSpec
class UniversalMaddStation extends StatelessWidget {
  final MaddSpec spec;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalMaddStation({
    super.key,
    required this.spec,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    if (!spec.useManifestMadd) {
      return LongVowelsSequenceWidget(
        onNext: onNext,
        onPrevious: onPrevious,
        letterChar: spec.letterChar,
      );
    }
    return _ManifestMaddView(
      spec: spec,
      onNext: onNext,
      onPrevious: onPrevious,
    );
  }
}

class _ManifestMaddView extends StatefulWidget {
  final MaddSpec spec;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const _ManifestMaddView({
    required this.spec,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<_ManifestMaddView> createState() => _ManifestMaddViewState();
}

class _ManifestMaddViewState extends State<_ManifestMaddView> {
  int _selected = 0;
  int _token = 0;

  static const List<String> _maddNames = [
    'مد بالألف (ا)',
    'مد بالواو (و)',
    'مد بالياء (ي)',
  ];

  static const List<Color> _maddColors = [
    Color(0xFFD84315),
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.spec.items.isNotEmpty) {
        _play(widget.spec.items[0].audioPath);
      }
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
    final items = widget.spec.items;
    final item = items[_selected];
    final accent = item.accentColor ?? _maddColors[_selected % _maddColors.length];
    final maddTitle = _maddNames[_selected % _maddNames.length];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(items.length, (i) {
                    final m = items[i];
                    final col = m.accentColor ?? _maddColors[i % _maddColors.length];
                    final sel = i == _selected;
                    return ChoiceChip(
                      selected: sel,
                      selectedColor: col,
                      backgroundColor: col.withValues(alpha: 0.12),
                      labelStyle: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: sel ? Colors.white : col,
                      ),
                      label: Text('${m.displayChar} — ${_maddNames[i % _maddNames.length]}'),
                      onSelected: (_) {
                        HapticFeedback.selectionClick();
                        setState(() => _selected = i);
                        _play(m.audioPath);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 12),

                if (item.imagePath.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 280),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: accent.withValues(alpha: 0.35),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Image.asset(item.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                const SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: accent.withValues(alpha: 0.28), width: 2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              item.displayChar,
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w900,
                                color: accent,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maddTitle,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: accent,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                if (item.exampleWord != null && item.exampleWord!.isNotEmpty)
                                  Text(
                                    item.exampleWord!,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.textPrimaryDay,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (item.explanation != null && item.explanation!.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          item.explanation!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryDay,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _play(item.audioPath),
                            icon: const Icon(Icons.volume_up_rounded),
                            label: Text(
                              'استمع (${item.displayChar})',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                          if (item.wordAudioPath != null && item.wordAudioPath!.isNotEmpty)
                            OutlinedButton.icon(
                              onPressed: () => _play(item.wordAudioPath!),
                              icon: const Icon(Icons.record_voice_over_rounded),
                              label: Text(
                                item.exampleWord ?? 'الكلمة',
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: accent,
                                side: BorderSide(color: accent, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
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
                        'الكتابة',
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

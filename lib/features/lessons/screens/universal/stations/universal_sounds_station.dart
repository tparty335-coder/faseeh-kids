import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// محطة أصوات الحرف — تُغذَّى من VowelsSpec (مباشرة للوحدات الجديدة أو عبر المحرك السابق)
class UniversalSoundsStation extends StatelessWidget {
  final VowelsSpec spec;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalSoundsStation({
    super.key,
    required this.spec,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final cards = spec.cards;
    if (cards == null || cards.isEmpty) {
      return ShortVowelsSequenceWidget(
        onNext: onNext,
        onPrevious: onPrevious,
        letterChar: spec.letterChar,
      );
    }
    return _ManifestSoundsView(
      spec: spec,
      cards: cards,
      onNext: onNext,
      onPrevious: onPrevious,
    );
  }
}

class _ManifestSoundsView extends StatefulWidget {
  final VowelsSpec spec;
  final List<VowelCardSpec> cards;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const _ManifestSoundsView({
    required this.spec,
    required this.cards,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<_ManifestSoundsView> createState() => _ManifestSoundsViewState();
}

class _ManifestSoundsViewState extends State<_ManifestSoundsView> {
  int _selectedIndex = 0;
  int _token = 0;

  static const List<Color> _cardColors = [
    Color(0xFFE53935), // الفتحة
    Color(0xFF1E88E5), // الضمة
    Color(0xFF43A047), // الكسرة
    Color(0xFF8E24AA), // السكون
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _playCardAudio(0, fullRule: true);
    });
  }

  @override
  void dispose() {
    _token++;
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playCardAudio(int idx, {bool fullRule = false}) async {
    final card = widget.cards[idx];
    final path = fullRule ? card.fullRuleAudio : card.vowelAudio;
    final tk = ++_token;
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _token) return;
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  Future<void> _playAsset(String path) async {
    final tk = ++_token;
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _token) return;
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.cards[_selectedIndex];
    final accent = _cardColors[_selectedIndex % _cardColors.length];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                // شريط اختيار الحركة
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(widget.cards.length, (i) {
                    final c = widget.cards[i];
                    final col = _cardColors[i % _cardColors.length];
                    final selected = i == _selectedIndex;
                    return ChoiceChip(
                      selected: selected,
                      selectedColor: col,
                      backgroundColor: col.withValues(alpha: 0.12),
                      labelStyle: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: selected ? Colors.white : col,
                      ),
                      label: Text('${c.vowelName} (${c.displayForm})'),
                      onSelected: (_) {
                        HapticFeedback.selectionClick();
                        setState(() => _selectedIndex = i);
                        _playCardAudio(i, fullRule: true);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 12),

                // الشريحة الأصلية من الأسطوانة
                if (card.slideImagePath != null &&
                    card.slideImagePath!.isNotEmpty)
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
                      child: Image.asset(
                        card.slideImagePath!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                const SizedBox(height: 14),

                // بطاقة الحرف والكلمة والأزرار الصوتية
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.28),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.10),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              card.displayForm,
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w900,
                                color: accent,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  card.vowelName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: accent,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                Text(
                                  '${card.exampleEmoji} ${card.exampleWord}',
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
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () =>
                                _playCardAudio(_selectedIndex, fullRule: false),
                            icon: const Icon(Icons.record_voice_over_rounded),
                            label: Text(
                              'صوت (${card.displayForm})',
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
                          OutlinedButton.icon(
                            onPressed: () =>
                                _playCardAudio(_selectedIndex, fullRule: true),
                            icon: const Icon(Icons.menu_book_rounded),
                            label: const Text(
                              'الشرح والقاعدة',
                              style: TextStyle(
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
                          if (card.wordAudio != null &&
                              card.wordAudio!.isNotEmpty)
                            OutlinedButton.icon(
                              onPressed: () => _playAsset(card.wordAudio!),
                              icon: const Icon(Icons.volume_up_rounded),
                              label: Text(
                                card.exampleWord,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primaryDay,
                                side: const BorderSide(
                                  color: AppColors.primaryDay,
                                  width: 1.5,
                                ),
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
        _buildStationNavBar(
          onPrevious: () {
            AudioService.instance.stop();
            widget.onPrevious();
          },
          onNext: () {
            AudioService.instance.stop();
            widget.onNext();
          },
          nextLabel: 'المدود',
        ),
      ],
    );
  }
}

Widget _buildStationNavBar({
  required VoidCallback onPrevious,
  required VoidCallback onNext,
  required String nextLabel,
}) {
  return SafeArea(
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
              onPressed: onPrevious,
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
              onPressed: onNext,
              icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  nextLabel,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
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
  );
}

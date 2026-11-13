import 'dart:async';

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
  // 0 = تمهيد وشرح مفهوم المد وأنواعه، 1..N = أمثلة الحرف المحددة
  int _selected = 0;
  int _token = 0;
  Timer? _followUpTimer;

  static const String _maddDefAudio = 'audio/lessons/baa/sounds/baa_madd_def.mp3';
  static const String _maddTypesAudio = 'audio/lessons/baa/sounds/baa_madd_types.mp3';
  static const Color _introColor = Color(0xFF6A1B9A);

  static const List<String> _maddNames = [
    'مد بالألف (ا)',
    'مد بالواو (و)',
    'مد بالياء (ي)',
  ];

  static const List<String> _maddHints = [
    'فتحة على الحرف + ألف ساكنة (ا)',
    'ضمة على الحرف + واو ساكنة (و)',
    'كسرة تحت الحرف + ياء ساكنة (ي)',
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
      if (mounted) {
        _playIntro();
      }
    });
  }

  @override
  void dispose() {
    _followUpTimer?.cancel();
    _token++;
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _play(String path) async {
    _followUpTimer?.cancel();
    final tk = ++_token;
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _token) return;
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  /// يشغل التعريف الصوتي العام للمد ثم يتبعه بتعداد أنواعه الثلاثة
  Future<void> _playIntro() async {
    _followUpTimer?.cancel();
    final tk = ++_token;
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _token) return;
      await AudioService.instance.playAsset(_maddDefAudio, channel: AudioChannel.voice);
      final defDur = AudioService.instance.getAssetDuration(_maddDefAudio);
      _followUpTimer = Timer(defDur + const Duration(milliseconds: 250), () async {
        if (!mounted || tk != _token) return;
        try {
          await AudioService.instance.playAsset(_maddTypesAudio, channel: AudioChannel.voice);
        } catch (_) {}
      });
    } catch (_) {}
  }

  void _selectTab(int tabIndex) {
    HapticFeedback.selectionClick();
    setState(() => _selected = tabIndex);
    if (tabIndex == 0) {
      _playIntro();
    } else {
      _play(widget.spec.items[tabIndex - 1].audioPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.spec.items;
    final showIntro = _selected == 0 || items.isEmpty;

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
                  children: [
                    ChoiceChip(
                      selected: _selected == 0,
                      selectedColor: _introColor,
                      backgroundColor: _introColor.withValues(alpha: 0.12),
                      labelStyle: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: _selected == 0 ? Colors.white : _introColor,
                      ),
                      label: const Text('مَا هُوَ الْمَدُّ؟'),
                      onSelected: (_) => _selectTab(0),
                    ),
                    ...List.generate(items.length, (i) {
                      final m = items[i];
                      final col = m.accentColor ?? _maddColors[i % _maddColors.length];
                      final sel = _selected == i + 1;
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
                        onSelected: (_) => _selectTab(i + 1),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 12),
                if (showIntro)
                  _buildIntroView(items)
                else
                  _buildItemView(items[_selected - 1], _selected - 1),
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
                      _followUpTimer?.cancel();
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
                      _followUpTimer?.cancel();
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

  /// يعرض شرح مفهوم المد وحروفه الثلاثة مع أمثلة الحرف التفاعلية
  Widget _buildIntroView(List<MaddItem> items) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _introColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _introColor.withValues(alpha: 0.35), width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.menu_book_rounded, color: _introColor, size: 28),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'مَا هُوَ الْمَدُّ؟',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: _introColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ، وَحُرُوفُ الْمَدِّ ثَلَاثَةٌ: الْأَلِفُ (ا)، وَالْوَاوُ (و)، وَالْيَاءُ (ي).',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDay,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: _playIntro,
                icon: const Icon(Icons.play_circle_rounded),
                label: const Text(
                  'اسْتَمِعْ لِشَرْحِ الْمَدِّ كَامِلاً',
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _introColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ],
          ),
        ),
        if (items.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'أَنْوَاعُ الْمَدِّ مَعَ حَرْفِ (${widget.spec.letterChar}):',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _introColor,
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(items.length, (i) {
            final item = items[i];
            final col = item.accentColor ?? _maddColors[i % _maddColors.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _selectTab(i + 1),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: col.withValues(alpha: 0.35), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: col.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          item.displayChar,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: col,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _maddNames[i % _maddNames.length],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: col,
                              ),
                            ),
                            Text(
                              _maddHints[i % _maddHints.length],
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                color: AppColors.textSecondaryDay,
                              ),
                            ),
                            if (item.exampleWord != null && item.exampleWord!.isNotEmpty)
                              Text(
                                'مثال: ${item.exampleWord!}',
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimaryDay,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Icon(Icons.volume_up_rounded, color: col),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 6),
          ElevatedButton.icon(
            onPressed: () => _selectTab(1),
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
            label: Text(
              'ابْدَأْ بِأَمْثِلَةِ حَرْفِ (${widget.spec.letterChar})',
              style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _maddColors[0],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ],
    );
  }

  /// يعرض تفاصيل ومثال نوع المد المختار
  Widget _buildItemView(MaddItem item, int index) {
    final accent = item.accentColor ?? _maddColors[index % _maddColors.length];
    final maddTitle = _maddNames[index % _maddNames.length];

    return Column(
      children: [
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
    );
  }
}

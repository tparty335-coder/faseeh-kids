import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// محطة المدود التفاعلية الحديثة — بتصميم مونتيسوري نظيف وموحّد
/// - شرح تفاعلي لمفهوم المد وحروفه الثلاثة (ا، و، ي) مع صوت الاستوديو الكامل بلا انقطاع
/// - مقارنة صوتية وبصرية مباشرة بين الحركة القصيرة (سَ / سُ / سِ) والمد الطويل (سَا / سُو / سِي)
/// - عرض أمثلة مصوّرة نقية مع تلوين مقطع المد داخل الكلمة (تِمْسَاح، نُسُور، بِرْسِيم...)
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
  int _selected = 0; // 0 = شرح المد، 1..N = أمثلة المدود (ألف، واو، ياء)
  int _token = 0;
  String? _playingTag;
  Timer? _followUpTimer;
  Timer? _indicatorTimer;
  final Set<int> _visitedTabs = {0};

  static const Color _navy = Color(0xFF1B2A4A);
  static const Color _introColor = Color(0xFF6D28D9);
  static const String _maddDefAudio = 'audio/lessons/baa/sounds/baa_madd_def.mp3';
  static const String _maddTypesAudio = 'audio/lessons/taa/madd/taa_madd_types.mp3';

  static const List<String> _maddShortLabels = ['بِالْأَلِفِ', 'بِالْوَاوِ', 'بِالْيَاءِ'];
  static const List<String> _maddFullNames = [
    'مَدٌّ بِالْأَلِفِ (ا)',
    'مَدٌّ بِالْوَاوِ (و)',
    'مَدٌّ بِالْيَاءِ (ي)',
  ];
  static const List<String> _maddLetters = ['ا', 'و', 'ي'];
  static const List<String> _maddShortVowels = ['َ', 'ُ', 'ِ'];
  static const List<String> _maddShortVowelNames = ['فَتْحَةٌ', 'ضَمَّةٌ', 'كَسْرَةٌ'];
  static const List<String> _maddShortAudioSuffix = ['fatha', 'damma', 'kasra'];
  static const List<Color> _maddColors = [
    Color(0xFFDC2626),
    Color(0xFF2563EB),
    Color(0xFF059669),
  ];

  static const Map<String, String> _shortAudioKey = {
    'أ': 'alif',
    'ب': 'baa',
    'ت': 'taa',
    'ث': 'thaa',
    'ج': 'jeem',
    'ح': 'haa_h',
    'خ': 'khaa',
    'د': 'daal',
    'ذ': 'dhaal',
    'ر': 'raa',
    'ز': 'zaay',
    'س': 'seen',
    'ش': 'sheen',
    'ص': 'saad',
    'ض': 'daad',
    'ط': 'taa_t',
    'ظ': 'dhaa_dh',
    'ع': 'ain',
    'غ': 'ghain',
    'ف': 'faa',
    'ق': 'qaaf',
    'ك': 'kaaf',
    'ل': 'laam',
    'م': 'meem',
    'ن': 'noon',
    'ه': 'haa',
    'هـ': 'haa',
    'و': 'waaw',
    'ي': 'yaa',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _playIntro();
    });
  }

  @override
  void dispose() {
    _followUpTimer?.cancel();
    _indicatorTimer?.cancel();
    _token++;
    AudioService.instance.stop();
    super.dispose();
  }

  String _shortVowelDisplay(int maddIndex) {
    final ch = widget.spec.letterChar;
    final norm = ch == 'هـ' ? 'ه' : ch;
    if (norm == 'أ') {
      return const ['أَ', 'أُ', 'إِ'][maddIndex % 3];
    }
    if (norm == 'ه') {
      return const ['هَـ', 'هُـ', 'هِـ'][maddIndex % 3];
    }
    return '$norm${_maddShortVowels[maddIndex % 3]}';
  }

  String _shortVowelAudioPath(int maddIndex) {
    final key = _shortAudioKey[widget.spec.letterChar] ?? 'seen';
    final suffix = _maddShortAudioSuffix[maddIndex % 3];
    return 'audio/letters/short_vowels/${key}_$suffix.mp3';
  }

  void _setPlaying(String tag, Duration duration) {
    _indicatorTimer?.cancel();
    if (mounted) setState(() => _playingTag = tag);
    _indicatorTimer = Timer(duration, () {
      if (mounted && _playingTag == tag) {
        setState(() => _playingTag = null);
      }
    });
  }

  Future<void> _play(String path, {String tag = 'clip'}) async {
    _followUpTimer?.cancel();
    final tk = ++_token;
    final dur = AudioService.instance.getAssetDuration(path);
    _setPlaying(tag, dur + const Duration(milliseconds: 300));
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _token) return;
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  /// يشغّل التعريف الصوتي الكامل للمد (12.5ث) ثم يليه تعداد أنواعه الثلاثة (6.5ث) بلا أي تقطيع
  Future<void> _playIntro() async {
    _followUpTimer?.cancel();
    final tk = ++_token;
    final defDur = AudioService.instance.getAssetDuration(_maddDefAudio);
    final typesDur = AudioService.instance.getAssetDuration(_maddTypesAudio);
    _setPlaying('intro', defDur + typesDur + const Duration(milliseconds: 600));
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _token) return;
      await AudioService.instance.playAsset(_maddDefAudio, channel: AudioChannel.voice);
      _followUpTimer = Timer(defDur + const Duration(milliseconds: 300), () async {
        if (!mounted || tk != _token) return;
        try {
          await AudioService.instance.playAsset(_maddTypesAudio, channel: AudioChannel.voice);
        } catch (_) {}
      });
    } catch (_) {}
  }

  void _selectTab(int tabIndex) {
    HapticFeedback.selectionClick();
    setState(() {
      _selected = tabIndex;
      _visitedTabs.add(tabIndex);
    });
    if (tabIndex == 0) {
      _playIntro();
    } else if (tabIndex - 1 < widget.spec.items.length) {
      final item = widget.spec.items[tabIndex - 1];
      _play(item.audioPath, tag: 'madd_${tabIndex - 1}');
    }
  }

  void _goNextStep() {
    final totalTabs = widget.spec.items.length + 1;
    if (_selected < totalTabs - 1) {
      _selectTab(_selected + 1);
    } else {
      _followUpTimer?.cancel();
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _goPreviousStep() {
    if (_selected > 0) {
      _selectTab(_selected - 1);
    } else {
      _followUpTimer?.cancel();
      AudioService.instance.stop();
      widget.onPrevious();
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.spec.items;
    final showIntro = _selected == 0 || items.isEmpty;
    final activeAccent = showIntro
        ? _introColor
        : (items[_selected - 1].accentColor ?? _maddColors[(_selected - 1) % _maddColors.length]);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: const Color(0xFFF8FAFC),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 600;
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 20 : 12,
                      vertical: 12,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 920),
                        child: Column(
                          children: [
                            // ── 1. شريط التبويبات الـ 4 الموحّد ──
                            _buildTopTabs(items),
                            const SizedBox(height: 14),

                            // ── 2. المحتوى التفاعلي (شرح المد أو مثال المد المختار) ──
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 240),
                              child: showIntro
                                  ? _buildIntroView(items, isWide)
                                  : _buildItemShowcase(
                                      items[_selected - 1],
                                      _selected - 1,
                                      isWide,
                                    ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ── 3. شريط التنقل السفلي الموحّد المقاوم لأي overflow ──
            _buildBottomBar(items.length + 1, activeAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabs(List<MaddItem> items) {
    final total = items.length + 1;
    return Row(
      children: List.generate(total, (i) {
        final isIntro = i == 0;
        final col = isIntro
            ? _introColor
            : (items[i - 1].accentColor ?? _maddColors[(i - 1) % _maddColors.length]);
        final isSelected = _selected == i;
        final isVisited = _visitedTabs.contains(i);
        final topText = isIntro ? '📖' : items[i - 1].displayChar;
        final subText = isIntro
            ? 'مَا هُوَ الْمَدُّ؟'
            : _maddShortLabels[(i - 1) % _maddShortLabels.length];

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: i == total - 1 ? 0 : 6),
            child: Material(
              color: isSelected
                  ? col
                  : (isVisited ? col.withValues(alpha: 0.06) : Colors.white),
              borderRadius: BorderRadius.circular(18),
              elevation: isSelected ? 3 : 0,
              shadowColor: col.withValues(alpha: 0.35),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _selectTab(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected ? col : col.withValues(alpha: 0.25),
                      width: isSelected ? 2.0 : 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              topText,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: isIntro ? 18 : 22,
                                fontWeight: FontWeight.w900,
                                color: isSelected ? Colors.white : col,
                                height: 1.05,
                              ),
                            ),
                            if (isVisited && !isSelected && !isIntro) ...[
                              const SizedBox(width: 3),
                              Icon(Icons.check_circle_rounded, size: 13, color: col),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          subText,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.96)
                                : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// شاشة الشرح التفاعلي لمفهوم المد + حروفه الثلاثة + بطاقات الأمثلة المصوّرة
  Widget _buildIntroView(List<MaddItem> items, bool isWide) {
    final isIntroPlaying = _playingTag == 'intro';
    final letterDisplay = widget.spec.letterChar == 'ه' ? 'هـ' : widget.spec.letterChar;

    return Column(
      key: const ValueKey('madd_intro_view'),
      children: [
        // ── بطاقة تعريف المد وحروفه الثلاثة ──
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isWide ? 22 : 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: _introColor.withValues(alpha: 0.22), width: 2),
            boxShadow: [
              BoxShadow(
                color: _introColor.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _introColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_stories_rounded, color: _introColor, size: 26),
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'مَا هُوَ الْمَدُّ؟',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: _navy,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF334155),
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),

              // حروف المد الثلاثة (ا، و، ي) بوضوح بصري جذاب
              Row(
                children: List.generate(3, (i) {
                  final col = _maddColors[i];
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: i == 2 ? 0 : 8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          if (i < items.length) _selectTab(i + 1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                            color: col.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: col.withValues(alpha: 0.30), width: 1.5),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _maddLetters[i],
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: isWide ? 32 : 26,
                                  fontWeight: FontWeight.w900,
                                  color: col,
                                  height: 1.05,
                                ),
                              ),
                              const SizedBox(height: 2),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  _maddShortLabels[i],
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: col,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'قَبْلَهُ ${_maddShortVowelNames[i]}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _playIntro,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isIntroPlaying ? const Color(0xFF5B21B6) : _introColor,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isIntroPlaying ? Icons.graphic_eq_rounded : Icons.play_circle_rounded,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'اسْتَمِعْ لِشَرْحِ الْمَدِّ كَامِلاً',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        if (items.isNotEmpty) ...[
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome_rounded, color: Color(0xFFF59E0B), size: 22),
              const SizedBox(width: 6),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'أَمْثِلَةُ الْمَدِّ مَعَ حَرْفِ ($letterDisplay)',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: _navy,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(items.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i == items.length - 1 ? 0 : 12),
                    child: _buildIntroExampleTile(items[i], i, compact: false),
                  ),
                );
              }),
            )
          else
            Column(
              children: List.generate(items.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildIntroExampleTile(items[i], i, compact: true),
                );
              }),
            ),
        ],
      ],
    );
  }

  Widget _buildIntroExampleTile(MaddItem item, int idx, {required bool compact}) {
    final col = item.accentColor ?? _maddColors[idx % _maddColors.length];
    final shortGlyph = _shortVowelDisplay(idx);
    final maddLetter = _maddLetters[idx % 3];
    final isPlaying = _playingTag == 'preview_$idx';

    if (compact) {
      return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        elevation: 1,
        shadowColor: col.withValues(alpha: 0.16),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => _selectTab(idx + 1),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: col.withValues(alpha: 0.28), width: 1.8),
            ),
            child: Row(
              children: [
                if (item.imagePath.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 82,
                      height: 82,
                      color: const Color(0xFFFFF7E8),
                      child: _MaddIllustration(
                        imagePath: item.imagePath,
                        cropRect: item.imageCropRect,
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: col.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$shortGlyph  +  $maddLetter  =  ${item.displayChar}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: col,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (item.exampleWord != null && item.exampleWord!.isNotEmpty)
                        _HighlightedMaddWord(
                          word: item.exampleWord!,
                          maddSegment: item.displayChar,
                          highlightColor: col,
                          fontSize: 24,
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _play(item.audioPath, tag: 'preview_$idx'),
                  icon: Icon(
                    isPlaying ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
                    color: col,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 2,
      shadowColor: col.withValues(alpha: 0.14),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _selectTab(idx + 1),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: col.withValues(alpha: 0.28), width: 1.8),
          ),
          child: Column(
            children: [
              // معادلة المد المختصرة (سَ + ا = سَا)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: col.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$shortGlyph  +  $maddLetter  =  ${item.displayChar}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: col,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // الصورة النقية
              if (item.imagePath.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 138,
                    width: double.infinity,
                    color: const Color(0xFFFFF7E8),
                    child: _MaddIllustration(
                      imagePath: item.imagePath,
                      cropRect: item.imageCropRect,
                    ),
                  ),
                ),
              const SizedBox(height: 10),

              if (item.exampleWord != null && item.exampleWord!.isNotEmpty)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: _HighlightedMaddWord(
                    word: item.exampleWord!,
                    maddSegment: item.displayChar,
                    highlightColor: col,
                    fontSize: 28,
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                _maddFullNames[idx % 3],
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _play(item.audioPath, tag: 'preview_$idx'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: col,
                    side: BorderSide(color: col.withValues(alpha: 0.5), width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPlaying ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'اسْتَمِعْ (${item.displayChar})',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w800,
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// شاشة التفصيل التفاعلي لكل نوع مد (مع مقارنة الحركة القصيرة مقابل المد الطويل)
  Widget _buildItemShowcase(MaddItem item, int idx, bool isWide) {
    final accent = item.accentColor ?? _maddColors[idx % _maddColors.length];
    final shortGlyph = _shortVowelDisplay(idx);
    final maddLetter = _maddLetters[idx % 3];
    final maddTitle = _maddFullNames[idx % 3];
    final isShortPlaying = _playingTag == 'short_$idx';
    final isMaddPlaying = _playingTag == 'madd_$idx';
    final isWordPlaying = _playingTag == 'word_$idx';

    return Column(
      key: ValueKey('madd_item_$idx'),
      children: [
        // ── 1. شريط المقارنة الصوتية البصرية: حركة قصيرة + حرف المد = مد طويل ──
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 22 : 12,
            vertical: isWide ? 16 : 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: accent.withValues(alpha: 0.26), width: 1.8),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'اضْغَطْ لِتُقَارِنَ بَيْنَ الصَّوْتِ الْقَصِيرِ وَالطَّوِيلِ:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // الحركة القصيرة (قابلة للمس والنطق!)
                    _buildSoundTile(
                      glyph: shortGlyph,
                      caption: 'حَرَكَةٌ قَصِيرَةٌ',
                      color: const Color(0xFF475569),
                      highlighted: isShortPlaying,
                      onTap: () => _play(_shortVowelAudioPath(idx), tag: 'short_$idx'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                    // حرف المد
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                      ),
                      child: Column(
                        children: [
                          Text(
                            maddLetter,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: accent,
                              height: 1.1,
                            ),
                          ),
                          const Text(
                            'حَرْفُ الْمَدِّ',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '=',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                    // المد الطويل (قابل للمس والنطق!)
                    _buildSoundTile(
                      glyph: item.displayChar,
                      caption: 'مَدٌّ طَوِيلٌ',
                      color: accent,
                      highlighted: isMaddPlaying,
                      emphasized: true,
                      onTap: () => _play(item.audioPath, tag: 'madd_$idx'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── 2. بطاقة المثال المصوّر الكبيرة ──
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isWide ? 22 : 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: accent.withValues(alpha: 0.28), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (item.imagePath.isNotEmpty) ...[
                      Expanded(
                        flex: 46,
                        child: _buildHeroIllustration(item, accent, height: 248),
                      ),
                      const SizedBox(width: 22),
                    ],
                    Expanded(
                      flex: 54,
                      child: _buildHeroDetails(
                        item: item,
                        idx: idx,
                        accent: accent,
                        maddTitle: maddTitle,
                        isMaddPlaying: isMaddPlaying,
                        isWordPlaying: isWordPlaying,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    if (item.imagePath.isNotEmpty) ...[
                      _buildHeroIllustration(item, accent, height: 196),
                      const SizedBox(height: 16),
                    ],
                    _buildHeroDetails(
                      item: item,
                      idx: idx,
                      accent: accent,
                      maddTitle: maddTitle,
                      isMaddPlaying: isMaddPlaying,
                      isWordPlaying: isWordPlaying,
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildSoundTile({
    required String glyph,
    required String caption,
    required Color color,
    required bool highlighted,
    bool emphasized = false,
    required VoidCallback onTap,
  }) {
    return Material(
      color: emphasized
          ? (highlighted ? color : color.withValues(alpha: 0.14))
          : (highlighted ? color.withValues(alpha: 0.18) : const Color(0xFFF8FAFC)),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: emphasized ? 22 : 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: emphasized ? color : color.withValues(alpha: 0.35),
              width: emphasized ? 2.2 : 1.5,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    glyph,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: emphasized ? 36 : 32,
                      fontWeight: FontWeight.w900,
                      color: emphasized && highlighted ? Colors.white : color,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    highlighted ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
                    size: 18,
                    color: emphasized && highlighted ? Colors.white : color,
                  ),
                ],
              ),
              Text(
                caption,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: emphasized && highlighted
                      ? Colors.white.withValues(alpha: 0.92)
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroIllustration(MaddItem item, Color accent, {required double height}) {
    return GestureDetector(
      onTap: () => _play(
        (item.wordAudioPath != null && item.wordAudioPath!.isNotEmpty)
            ? item.wordAudioPath!
            : item.audioPath,
        tag: 'word_${_selected - 1}',
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7E8),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: accent.withValues(alpha: 0.25), width: 2),
          ),
          child: _MaddIllustration(
            imagePath: item.imagePath,
            cropRect: item.imageCropRect,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroDetails({
    required MaddItem item,
    required int idx,
    required Color accent,
    required String maddTitle,
    required bool isMaddPlaying,
    required bool isWordPlaying,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            maddTitle,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.5,
              fontWeight: FontWeight.w900,
              color: accent,
            ),
          ),
        ),
        const SizedBox(height: 12),

        if (item.exampleWord != null && item.exampleWord!.isNotEmpty)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: _HighlightedMaddWord(
              word: item.exampleWord!,
              maddSegment: item.displayChar,
              highlightColor: accent,
              fontSize: 46,
            ),
          ),
        const SizedBox(height: 10),

        if (item.explanation != null && item.explanation!.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              item.explanation!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
                height: 1.5,
              ),
            ),
          ),
        const SizedBox(height: 16),

        Wrap(
          spacing: 10,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _play(item.audioPath, tag: 'madd_$idx'),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                elevation: 1,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isMaddPlaying ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'اسْتَمِعْ لِلْمَدِّ (${item.displayChar})',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (item.wordAudioPath != null && item.wordAudioPath!.isNotEmpty)
              OutlinedButton(
                onPressed: () => _play(item.wordAudioPath!, tag: 'word_$idx'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: accent,
                  side: BorderSide(color: accent, width: 1.8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isWordPlaying
                            ? Icons.graphic_eq_rounded
                            : Icons.record_voice_over_rounded,
                        size: 19,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.exampleWord ?? 'الْكَلِمَةُ',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(int totalTabs, Color accent) {
    final isLastTab = _selected >= totalTabs - 1;
    final nextLabel = isLastTab
        ? 'الْكِتَابَةُ'
        : (_selected == 0 ? 'أَمْثِلَةُ الْمَدِّ' : 'الْمَدُّ التَّالِي');

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ElevatedButton(
                onPressed: _goPreviousStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  foregroundColor: AppColors.textPrimaryDay,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_forward_ios_rounded, size: 15),
                      SizedBox(width: 5),
                      Text(
                        'السَّابِقُ',
                        maxLines: 1,
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_selected + 1} / $totalTabs',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: accent,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: ElevatedButton(
                onPressed: _goNextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_ios_rounded, size: 15),
                      const SizedBox(width: 5),
                      Text(
                        nextLabel,
                        maxLines: 1,
                        style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// يُبرز مقطع المد (مثل: سَا / سُو / سِي) بلون زاهٍ واضح داخل الكلمة العربية المضبوطة بالشكل
class _HighlightedMaddWord extends StatelessWidget {
  final String word;
  final String maddSegment;
  final Color highlightColor;
  final double fontSize;

  const _HighlightedMaddWord({
    required this.word,
    required this.maddSegment,
    required this.highlightColor,
    required this.fontSize,
  });

  static bool _isDiacritic(int codeUnit) =>
      (codeUnit >= 0x064B && codeUnit <= 0x065F) || codeUnit == 0x0670;

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontFamily: 'Cairo',
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      color: const Color(0xFF1B2A4A),
      height: 1.2,
    );

    // نستخرج الحروف الأساسية فقط للعثور الدقيق على موقع مقطع المد مع الحفاظ على التشكيل الكامل
    final wordUnits = word.codeUnits;
    final cleanWordChars = <int>[];
    final cleanToOrigStart = <int>[];
    for (int i = 0; i < wordUnits.length; i++) {
      if (!_isDiacritic(wordUnits[i])) {
        cleanWordChars.add(wordUnits[i]);
        cleanToOrigStart.add(i);
      }
    }
    final cleanSeg = maddSegment.codeUnits.where((u) => !_isDiacritic(u)).toList();

    int matchCleanIdx = -1;
    if (cleanSeg.isNotEmpty && cleanWordChars.length >= cleanSeg.length) {
      for (int i = 0; i <= cleanWordChars.length - cleanSeg.length; i++) {
        bool ok = true;
        for (int j = 0; j < cleanSeg.length; j++) {
          if (cleanWordChars[i + j] != cleanSeg[j]) {
            ok = false;
            break;
          }
        }
        if (ok) {
          matchCleanIdx = i;
          break;
        }
      }
    }

    if (matchCleanIdx < 0) {
      return Text(word, style: baseStyle.copyWith(color: highlightColor));
    }

    final startOrig = cleanToOrigStart[matchCleanIdx];
    final endClean = matchCleanIdx + cleanSeg.length;
    final endOrig = endClean < cleanToOrigStart.length
        ? cleanToOrigStart[endClean]
        : word.length;

    final before = word.substring(0, startOrig);
    final middle = word.substring(startOrig, endOrig);
    final after = word.substring(endOrig);

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          if (before.isNotEmpty) TextSpan(text: before),
          TextSpan(
            text: middle,
            style: baseStyle.copyWith(color: highlightColor),
          ),
          if (after.isNotEmpty) TextSpan(text: after),
        ],
      ),
      textDirection: TextDirection.rtl,
    );
  }
}

/// يعرض صورة مثال المد سواء كاملة أو مقصوصة بدقة (`imageCropRect`) بدون تشويه أو زوائد
class _MaddIllustration extends StatefulWidget {
  final String imagePath;
  final Rect? cropRect;

  const _MaddIllustration({required this.imagePath, this.cropRect});

  @override
  State<_MaddIllustration> createState() => _MaddIllustrationState();
}

class _MaddIllustrationState extends State<_MaddIllustration> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  ui.Image? _image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.cropRect != null) _resolveImage();
  }

  @override
  void didUpdateWidget(covariant _MaddIllustration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath || oldWidget.cropRect != widget.cropRect) {
      if (widget.cropRect != null) {
        _resolveImage();
      } else {
        _unsubscribe();
      }
    }
  }

  void _unsubscribe() {
    if (_stream != null && _listener != null) {
      _stream!.removeListener(_listener!);
    }
    _stream = null;
    _listener = null;
  }

  void _resolveImage() {
    _unsubscribe();
    final provider = AssetImage(widget.imagePath);
    final stream = provider.resolve(createLocalImageConfiguration(context));
    _stream = stream;
    _listener = ImageStreamListener(
      (ImageInfo info, bool _) {
        if (mounted) setState(() => _image = info.image);
      },
      onError: (Object _, StackTrace? __) {},
    );
    stream.addListener(_listener!);
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crop = widget.cropRect;
    if (crop == null) {
      return Image.asset(
        widget.imagePath,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.image_outlined, size: 42, color: Color(0xFF94A3B8)),
        ),
      );
    }
    final img = _image;
    if (img == null) {
      return const ColoredBox(color: Color(0xFFFFF7E8));
    }
    return CustomPaint(
      painter: _CroppedMaddPainter(image: img, cropRect: crop),
    );
  }
}

class _CroppedMaddPainter extends CustomPainter {
  final ui.Image image;
  final Rect cropRect;

  const _CroppedMaddPainter({required this.image, required this.cropRect});

  @override
  void paint(Canvas canvas, Size size) {
    final w = image.width.toDouble();
    final h = image.height.toDouble();
    final src = Rect.fromLTRB(
      cropRect.left * w,
      cropRect.top * h,
      cropRect.right * w,
      cropRect.bottom * h,
    );
    if (src.width <= 0 || src.height <= 0 || size.isEmpty) return;
    final fitted = applyBoxFit(BoxFit.contain, src.size, size);
    final dst = Alignment.center.inscribe(fitted.destination, Offset.zero & size);
    canvas.drawImageRect(
      image,
      src,
      dst,
      Paint()..filterQuality = FilterQuality.medium,
    );
  }

  @override
  bool shouldRepaint(covariant _CroppedMaddPainter oldDelegate) =>
      oldDelegate.image != image || oldDelegate.cropRect != cropRect;
}

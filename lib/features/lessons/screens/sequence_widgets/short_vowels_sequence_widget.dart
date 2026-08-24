import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';

class ShortVowelsSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;
  final bool isActive;

  const ShortVowelsSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
    this.isActive = true,
  });

  @override
  State<ShortVowelsSequenceWidget> createState() =>
      _ShortVowelsSequenceWidgetState();
}

class _ShortVowelsSequenceWidgetState extends State<ShortVowelsSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // ─── Data: mirrors original CD ahdaf_a2 exactly ──────────────────────────
  // الفتحة: 3 أمثلة (أول/وسط/آخر الكلمة)
  // الضمة، الكسرة، السكون: مثالان لكل حركة
  List<Map<String, dynamic>> get _harakat => _getHarakatForLetter(widget.letterChar);

  static List<Map<String, dynamic>> _getHarakatForLetter(String letter) {
    if (letter == 'ب') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (بَ)',
          'vowelMark': 'بَ',
          'color': const Color(0xFFE53935),
          'explanation': 'ضَعْ شَفَتَيْكَ مَعًا ثُمَّ افْتَحْ وَقُلْ (بَ)',
          'ruleAudio': 'audio/letters/phrases/baa_fatha_demo.mp3',
          'examples': [
            {
              'word': 'بَقَرَة',
              'position': 'بَاءٌ فِي أَوَّلِ الْكَلِمَةِ مَفْتُوحَة',
              'audio': 'audio/letters/words/baa_word.mp3',
              'image': 'assets/images/lessons/baa/baa_words.jpg',
            },
            {
              'word': 'ثُعْبَان',
              'position': 'بَاءٌ مَفْتُوحَة فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/letters/words/baa_word2.mp3',
              'image': 'assets/images/lessons/baa/baa_fishing.jpg',
            },
            {
              'word': 'كَتَبَ',
              'position': 'بَاءٌ مَفْتُوحَة فِي آخِرِ الْكَلِمَةِ',
              'audio': 'audio/letters/words/baa_word3.mp3',
              'image': 'assets/images/lessons/baa/baa_writing.jpg',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (بُ)',
          'vowelMark': 'بُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'ضَعْ شَفَتَيْكَ مَعًا ثُمَّ افْتَحْ وَضُمَّ وَقُلْ (بُ)',
          'ruleAudio': 'audio/letters/phrases/baa_damma_demo.mp3',
          'examples': [
            {
              'word': 'بُرْتُقَال',
              'position': 'بَاءٌ مَضْمُومَة',
              'audio': 'audio/letters/words/baa_word.mp3',
              'image': 'assets/images/lessons/baa/baa_wheel.jpg',
            },
            {
              'word': 'حُبُوب',
              'position': 'بَاءٌ مَضْمُومَة فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/letters/short_vowels/baa_damma.mp3',
              'image': 'assets/images/lessons/baa/baa_bee.jpg',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (بِ)',
          'vowelMark': 'بِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'ضَعْ شَفَتَيْكَ مَعًا ثُمَّ افْتَحْ وَانْخَفِضْ وَقُلْ (بِ)',
          'ruleAudio': 'audio/letters/phrases/baa_kasra_demo.mp3',
          'examples': [
            {
              'word': 'بِنْت',
              'position': 'بَاءٌ مَكْسُورَة',
              'audio': 'audio/letters/short_vowels/baa_kasra.mp3',
              'image': 'assets/images/lessons/baa/baa_drag_words.jpg',
            },
            {
              'word': 'بِطِّيخ',
              'position': 'بَاءٌ مَكْسُورَة',
              'audio': 'audio/letters/words/baa_word4.mp3',
              'image': 'assets/images/lessons/baa/baa_sounds.jpg',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (بْ)',
          'vowelMark': 'بْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'حَرْفُ الْبَاءِ حَرْفٌ سَاكِنٌ تَضَعُ فِيهِ شَفَتَيْكَ مَعًا ثُمَّ تَفْتَحُهُمَا',
          'ruleAudio': 'audio/letters/short_vowels/baa_sukoon.mp3',
          'examples': [
            {
              'word': 'حَبْل',
              'position': 'بَاءٌ سَاكِنَة',
              'audio': 'audio/letters/words/baa_word3.mp3',
              'image': 'assets/images/lessons/baa/baa_circus.jpg',
            },
          ],
        },
      ];
    }

    // افتراضي لحرف الألف (مطابقة للأسطوانة الأصلية ahdaf_a2)
    return [
      {
        'id': 'fatha',
        'label': 'الْفَتْحَةُ (أَ)',
        'vowelMark': 'أَ',
        'color': const Color(0xFFE53935),
        'explanation': 'الْفَتْحَةُ عِبَارَةٌ عَنْ شَرْطَةٍ تُوضَعُ فَوْقَ الْحَرْفِ فَيُصْبِحُ (أَ)',
        'ruleAudio': 'audio/stories/alif_fatha_rule.mp3',
        'examples': [
          {
            'word': 'أَكَلَ',
            'position': 'أَلِفٌ فِي أَوَّلِ الْكَلِمَةِ',
            'audio': 'audio/stories/alif_word_akala.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_akala.jpg',
          },
          {
            'word': 'سَأَلَ',
            'position': 'أَلِفٌ فِي وَسَطِ الْكَلِمَةِ',
            'audio': 'audio/stories/alif_word_saala.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_saala.jpg',
          },
          {
            'word': 'قَرَأَ',
            'position': 'أَلِفٌ فِي آخِرِ الْكَلِمَةِ',
            'audio': 'audio/stories/alif_word_qaraa.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_qaraa.jpg',
          },
        ],
      },
      {
        'id': 'damma',
        'label': 'الضَّمَّةُ (أُ)',
        'vowelMark': 'أُ',
        'color': const Color(0xFFFF6F00),
        'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُغَيِّرُ صَوْتَهُ إِلَى (أُ)',
        'ruleAudio': 'audio/stories/alif_damma_rule.mp3',
        'examples': [
          {
            'word': 'أُذُن',
            'position': '',
            'audio': 'audio/stories/alif_word_udhun.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_udhun.jpg',
          },
          {
            'word': 'أُمِّي',
            'position': '',
            'audio': 'audio/stories/alif_word_ummi.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_ummi.jpg',
          },
        ],
      },
      {
        'id': 'kasra',
        'label': 'الْكَسْرَةُ (إِ)',
        'vowelMark': 'إِ',
        'color': const Color(0xFF1E88E5),
        'explanation': 'الشَّرْطَةُ الَّتِي تُوضَعُ أَسْفَلَ الْحَرْفِ تُسَمَّى كَسْرَةً (إِ)',
        'ruleAudio': 'audio/stories/alif_kasra_rule.mp3',
        'examples': [
          {
            'word': 'إِبْرَة',
            'position': '',
            'audio': 'audio/stories/alif_word_ibra.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_ibra.jpg',
          },
          {
            'word': 'إِينَاس',
            'position': '',
            'audio': 'audio/stories/alif_word_inas.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_inas.jpg',
          },
        ],
      },
      {
        'id': 'sukoon',
        'label': 'عَلَامَةُ السُّكُونِ (أْ)',
        'vowelMark': 'أْ',
        'color': const Color(0xFF5D4037),
        'explanation': 'السُّكُونُ فَوْقَ الْحَرْفِ يَجْعَلُ الْحَرْفَ بِدُونِ حَرَكَةٍ',
        'ruleAudio': 'audio/stories/alif_sukoon_rule.mp3',
        'examples': [
          {
            'word': 'فَأْس',
            'position': '',
            'audio': 'audio/stories/alif_word_faas.mp3',
            'image': 'assets/images/lessons/alif/alif_word_faas.jpg',
          },
          {
            'word': 'رَأْس',
            'position': '',
            'audio': 'audio/stories/alif_word_ras_explain.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_ras.jpg',
          },
        ],
      },
    ];
  }

  // Sub-example index per haraka page
  final Map<int, int> _exampleIndex = {0: 0, 1: 0, 2: 0, 3: 0};

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _triggerAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant ShortVowelsSequenceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _triggerAutoPlay();
    }
  }

  void _triggerAutoPlay() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _playRuleAudio(_harakat[_currentPage]);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playRuleAudio(Map<String, dynamic> haraka) async {
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset(haraka['ruleAudio'] as String);
    } catch (e) {
      debugPrint('Rule audio error: $e');
    }
  }

  void _playExampleAudio(String audioPath) async {
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset(audioPath);
    } catch (e) {
      debugPrint('Example audio error: $e');
    }
  }

  void _nextPage() {
    if (_currentPage < _harakat.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onPrevious();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // ─── 1. Header ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDay,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'الْحَرَكَاتُ الْقَصِيرَةُ — ${_harakat[_currentPage]['label']}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                  onPressed: () => _playRuleAudio(_harakat[_currentPage]),
                ),
              ],
            ),
          ),

          // ─── 2. PageView of harakat ───────────────────────────────────────
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _exampleIndex[index] = 0;
                });
                _playRuleAudio(_harakat[index]);
              },
              itemCount: _harakat.length,
              itemBuilder: (context, pageIdx) {
                final h = _harakat[pageIdx];
                final color = h['color'] as Color;
                final examples = h['examples'] as List<Map<String, dynamic>>;
                final currentEx = _exampleIndex[pageIdx] ?? 0;
                final ex = examples[currentEx];

                final isTablet = MediaQuery.sizeOf(context).width > 600;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isTablet ? 540 : double.infinity),
                      child: Column(
                        children: [
                          // ── 1. بطاقة الحركة والقاعدة ──────────────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    h['vowelMark'] as String,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 42,
                                      fontWeight: FontWeight.w900,
                                      color: color,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    h['explanation'] as String,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimaryDay,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ── 2. أزرار اختيار الأمثلة التفاعلية الكبيرة ────────
                          if (examples.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < examples.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() => _exampleIndex[pageIdx] = i);
                                            _playExampleAudio(examples[i]['audio'] as String);
                                          },
                                          borderRadius: BorderRadius.circular(20),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: currentEx == i ? color : Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                color: color.withValues(alpha: currentEx == i ? 1.0 : 0.4),
                                                width: 2,
                                              ),
                                              boxShadow: currentEx == i
                                                  ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))]
                                                  : const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  examples[i]['word'] as String,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: currentEx == i ? Colors.white : color,
                                                  ),
                                                ),
                                                if ((examples[i]['position'] as String).isNotEmpty) ...[
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    '(${examples[i]['position']})',
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: currentEx == i ? Colors.white.withValues(alpha: 0.9) : Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),

                          // ── 3. بطاقة المثال مع المشهد الأصلي بالكامل ──────────
                          GestureDetector(
                            onTap: () => _playExampleAudio(ex['audio'] as String),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 3))
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // عنوان الكلمة وموضع الحرف
                                  Row(
                                    children: [
                                      Text(
                                        ex['word'] as String,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 34,
                                          fontWeight: FontWeight.w900,
                                          color: color,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      if ((ex['position'] as String).isNotEmpty)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: color.withValues(alpha: 0.12),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            ex['position'] as String,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: color,
                                            ),
                                          ),
                                        ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.volume_up_rounded, color: color, size: 28),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // المشهد الأصلي الكامل بدون أي قص (نسبة 4:3 واضحة وكاملة)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Container(
                                        color: Colors.grey.shade100,
                                        child: Image.asset(
                                          ex['image'] as String,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) => Container(
                                            color: Colors.grey.shade100,
                                            child: const Icon(Icons.image, size: 48, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.touch_app_rounded, size: 16, color: Colors.grey),
                                      SizedBox(width: 6),
                                      Text(
                                        'اضْغَطْ لِسَمَاعِ نُطْقِ الْكَلِمَةِ',
                                        style: TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ── 4. أزرار التنقل بين الأمثلة بأزرار كبيرة مريحة ────
                          if (examples.length > 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: currentEx > 0
                                      ? () {
                                          setState(() => _exampleIndex[pageIdx] = currentEx - 1);
                                          _playExampleAudio(examples[currentEx - 1]['audio'] as String);
                                        }
                                      : null,
                                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                                  label: const Text('المثال السابق', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: color.withValues(alpha: 0.12),
                                    foregroundColor: color,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),

                                Row(
                                  children: [
                                    for (int i = 0; i < examples.length; i++)
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        margin: const EdgeInsets.symmetric(horizontal: 4),
                                        width: currentEx == i ? 24 : 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: currentEx == i ? color : Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                  ],
                                ),

                                ElevatedButton.icon(
                                  onPressed: currentEx < examples.length - 1
                                      ? () {
                                          setState(() => _exampleIndex[pageIdx] = currentEx + 1);
                                          _playExampleAudio(examples[currentEx + 1]['audio'] as String);
                                        }
                                      : null,
                                  label: const Text('المثال التالي', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14)),
                                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: color,
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ─── 3. Haraka navigation ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  label: const Text('السابق',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryDay,
                    side: const BorderSide(color: AppColors.primaryDay, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                Row(
                  children: List.generate(
                    _harakat.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == i ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == i ? AppColors.primaryDay : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _nextPage,
                  label: Text(
                    _currentPage == _harakat.length - 1 ? 'التالي: الْمُدُود' : 'التالي',
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDay,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


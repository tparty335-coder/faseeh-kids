import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/lessons/widgets/arabic_letter_tracing_canvas.dart';

class TraceSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;

  const TraceSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
  });

  @override
  State<TraceSequenceWidget> createState() => _TraceSequenceWidgetState();
}

class _TraceSequenceWidgetState extends State<TraceSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  List<Map<String, dynamic>> get _steps => _getStepsForLetter(widget.letterChar);

  static List<Map<String, dynamic>> _getStepsForLetter(String letter) {
    if (letter == 'ب') {
      return [
        // ── 1. الباء الكاملة المفردة ──────────────────────────────
        {
          'title': 'الْبَاءُ الْكَامِلَةُ (مُفْرَدَة)',
          'subtitle': 'سِنَّتَانِ يَمِينًا وَيَسَارًا، وَنُقْطَةٌ أَسْفَلَهَا',
          'positionCode': 'isolated',
          'letterShape': 'ب',
          'allForms': ['ب'],
          'formsNote': 'شَكْلٌ وَاحِدٌ فَقَطْ لِلْحَرْفِ الْمُفْرَدِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'بَقَرَة',
          'exampleEmoji': '🐄',
          'imageFile': 'assets/images/lessons/baa/sounds/baqara.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w8.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_baqara.mp3',
          'color': const Color(0xFF673AB7),
        },
        // ── 2. الباء في أول الكلمة ───────────────────────────────
        {
          'title': 'الْبَاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'شَكْلٌ وَاحِدٌ فَقَطْ — تَتَّصِلُ بِمَا بَعْدَهَا مِنَ الْيَسَارِ',
          'positionCode': 'start',
          'letterShape': 'بـ',
          'allForms': ['بـ'],
          'formsNote': 'لَيْسَ لِلْبَاءِ فِي الْبِدَايَةِ إِلَّا هَذَا الشَّكْلُ',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'بَاب',
          'exampleEmoji': '🚪',
          'imageFile': 'assets/images/lessons/baa/sounds/bab.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w9.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_bab.mp3',
          'color': const Color(0xFFE53935),
        },
        // ── 3. الباء في وسط الكلمة (شكل ①: بعد حرف متصل) ───────
        {
          'title': 'الْبَاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الأَوَّلُ: بَعْدَ حَرْفٍ يَتَّصِلُ بِمَا بَعْدَهُ مِثْلَ (ث، ع، ن...)',
          'positionCode': 'middle',
          'letterShape': 'ـبـ',
          'allForms': ['ـبـ', 'بـ'],
          'formsNote': 'شَكْلَانِ حَسَبَ الْحَرْفِ الَّذِي قَبْلَهَا',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'وَسَطُ الْكَلِمَة (١)',
          'exampleWord': 'حُبُوب',
          'exampleEmoji': '🌾',
          'imageFile': 'assets/images/lessons/baa/sounds/hobob.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w10.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_hobob.mp3',
          'color': const Color(0xFFFF8F00),
        },
        // ── 4. الباء في وسط الكلمة (شكل ②: بعد حرف رافسة) ──────
        {
          'title': 'الْبَاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الثَّانِي: بَعْدَ حَرْفٍ رَافِسٍ (ا، و، ر، ز، د، ذ، ...) تَبْدُو كَأَوَّلِ الْكَلِمَةِ',
          'positionCode': 'mid_disconnected',
          'letterShape': 'بـ',
          'allForms': ['ـبـ', 'بـ'],
          'formsNote': 'الْحُرُوفُ الرَّافِسَةُ: ا و ر ز د ذ',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'وَسَطُ الْكَلِمَة (٢)',
          'exampleWord': 'إِبْرَة',
          'exampleEmoji': '🪡',
          'imageFile': 'assets/images/lessons/baa/sounds/ibra.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w10.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_ibra.mp3',
          'color': const Color(0xFF1976D2),
        },
        // ── 5. الباء في آخر الكلمة (شكل ①: بعد حرف متصل) ───────
        {
          'title': 'الْبَاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الأَوَّلُ: بَعْدَ حَرْفٍ يَتَّصِلُ بِمَا بَعْدَهُ',
          'positionCode': 'end',
          'letterShape': 'ـب',
          'allForms': ['ـب', 'ب'],
          'formsNote': 'شَكْلَانِ حَسَبَ الْحَرْفِ الَّذِي قَبْلَهَا',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'آخِرُ الْكَلِمَة (١)',
          'exampleWord': 'يَكْتُب',
          'exampleEmoji': '✍️',
          'imageFile': 'assets/images/lessons/baa/sounds/yaktb.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w11.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_yaktb.mp3',
          'color': const Color(0xFF43A047),
        },
        // ── 6. الباء في آخر الكلمة (شكل ②: بعد حرف رافسة) ──────
        {
          'title': 'الْبَاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الثَّانِي: بَعْدَ حَرْفٍ رَافِسٍ — تُشْبِهُ شَكْلَهَا الْمُفْرَدَ',
          'positionCode': 'end_disconnected',
          'letterShape': 'ب',
          'allForms': ['ـب', 'ب'],
          'formsNote': 'مِثَالٌ: باب، ذَهَب',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'آخِرُ الْكَلِمَة (٢)',
          'exampleWord': 'بَاب',
          'exampleEmoji': '🚪',
          'imageFile': 'assets/images/lessons/baa/sounds/bab.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w11.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_bab.mp3',
          'color': const Color(0xFF00838F),
        },
      ];
    }

    // افتراضي لحرف الألف (مطابقة للأسطوانة الأصلية ahdaf_a3)
    return [
      {
        'title': 'كَيْفِيَّةُ كِتَابَةِ حَرْفِ الْأَلِفِ',
        'subtitle': 'نَبْدَأُ مِنْ أَعْلَى إِلَى أَسْفَلَ، ثُمَّ نَكْتُبُ الْهَمْزَةَ',
        'positionCode': 'isolated',
        'letterShape': 'أ',
        'position': 'رَسْمُ الْحَرْفِ',
        'exampleWord': 'أَسَد',
        'exampleEmoji': '🦁',
        'imageFile': 'assets/images/lessons/alif/alif_word_asad.jpg',
        'audio': 'audio/stories/alif_trace_intro.mp3',
        'wordAudio': 'audio/stories/alif_word_asad.mp3',
        'color': const Color(0xFF673AB7),
      },
      {
        'title': 'الْأَلِفُ فِي أَوَّلِ الْكَلِمَةِ',
        'subtitle': 'يَأْتِي مُنْفَصِلاً غَيْرَ مُتَّصِلٍ بِمَا بَعْدَهُ: أَكَلَ',
        'positionCode': 'start',
        'letterShape': 'أ',
        'position': 'أَوَّلُ الْكَلِمَةِ',
        'exampleWord': 'أَكَلَ',
        'exampleEmoji': '🍽️',
        'imageFile': 'assets/images/lessons/alif/alif_scene_akala.jpg',
        'audio': 'audio/stories/alif_pos_start.mp3',
        'wordAudio': 'audio/stories/alif_word_akala.mp3',
        'color': const Color(0xFFE53935),
      },
      {
        'title': 'الْأَلِفُ فِي وَسَطِ الْكَلِمَةِ',
        'subtitle': 'يَتَّصِلُ بِمَا قَبْلَهُ وَلَا يَتَّصِلُ بِمَا بَعْدَهُ: سَأَلَ',
        'positionCode': 'middle',
        'letterShape': 'ـأ',
        'position': 'وَسَطُ الْكَلِمَةِ',
        'exampleWord': 'سَأَلَ',
        'exampleEmoji': '🙋‍♂️',
        'imageFile': 'assets/images/lessons/alif/alif_scene_saala.jpg',
        'audio': 'audio/stories/alif_pos_middle.mp3',
        'wordAudio': 'audio/stories/alif_word_saala.mp3',
        'color': const Color(0xFFFF8F00),
      },
      {
        'title': 'الْأَلِفُ فِي آخِرِ الْكَلِمَةِ',
        'subtitle': 'يَأْتِي مُتَّصِلاً بِمَا قَبْلَهُ أَوْ مُنْفَصِلاً: قَرَأَ',
        'positionCode': 'end',
        'letterShape': 'ـأ',
        'position': 'آخِرُ الْكَلِمَةِ',
        'exampleWord': 'قَرَأَ',
        'exampleEmoji': '📖',
        'imageFile': 'assets/images/lessons/alif/alif_scene_qaraa.jpg',
        'audio': 'audio/stories/alif_pos_end.mp3',
        'wordAudio': 'audio/stories/alif_word_qaraa.mp3',
        'color': const Color(0xFF43A047),
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted && _steps.isNotEmpty) _playAudio(_steps[0]['audio'] as String);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playAudio(String path) async {
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset(path);
    } catch (e) {
      debugPrint('Trace audio error: $e');
    }
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
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
    final isTablet = MediaQuery.sizeOf(context).width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // ─── Header ───
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
                    'كِتَابَةُ وَمَوَاضِعُ الْحَرْفِ (${_currentStep + 1}/${_steps.length}) — ${_steps[_currentStep]['position']}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                  onPressed: () => _playAudio(_steps[_currentStep]['audio'] as String),
                ),
              ],
            ),
          ),

          // ─── PageView of Steps ───
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // منع إزاحة الشاشة أثناء سحب الإصبع والرسم
              onPageChanged: (index) {
                setState(() => _currentStep = index);
                _playAudio(_steps[index]['audio'] as String);
              },
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                final s = _steps[index];
                final color = s['color'] as Color;
                final shape = s['letterShape'] as String;
                final example = s['exampleWord'] as String;
                final imageFile = s['imageFile'] as String;
                final positionCode = s['positionCode'] as String;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isTablet ? 700 : double.infinity),
                      child: Column(
                        children: [
                          // 1. بطاقة العنوان + الصورة + المثال
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── عنوان كبير واضح ──
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        s['title'] as String,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: isTablet ? 22 : 18,
                                          fontWeight: FontWeight.w900,
                                          color: color,
                                        ),
                                      ),
                                    ),
                                    // زر استماع للشرح الصوتي الأصلي
                                    GestureDetector(
                                      onTap: () => _playAudio(s['audio'] as String),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(Icons.volume_up_rounded,
                                            color: Colors.white, size: 22),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s['subtitle'] as String,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // ── الصورة + المثال ──
                                GestureDetector(
                                  onTap: () => _playAudio(s['wordAudio'] as String),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: SizedBox(
                                          width: isTablet ? 130.0 : 100.0,
                                          height: isTablet ? 100.0 : 75.0,
                                          child: Image.asset(
                                            imageFile,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Container(
                                              color: Colors.grey.shade200,
                                              child: const Icon(Icons.image, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'مِثَالٌ: $example ${s['exampleEmoji']}',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Icon(Icons.volume_up_rounded, size: 18, color: color),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // 2. ── شريط أشكال الحرف في هذا الموضع ──
                          if (s.containsKey('allForms')) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: color.withValues(alpha: 0.25), width: 1.5),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
                              ),
                              child: Column(
                                children: [
                                  // ملاحظة الشكل
                                  Text(
                                    s['formsNote'] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: color.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // الأشكال
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: () {
                                      final forms = s['allForms'] as List<dynamic>;
                                      final labels = s['formsLabels'] as List<dynamic>?;
                                      return List.generate(forms.length, (fi) {
                                        final f = forms[fi] as String;
                                        final isActive = f == shape;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 6),
                                          child: Column(
                                            children: [
                                              AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: isActive ? color : Colors.grey.shade100,
                                                  borderRadius: BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: isActive ? color : Colors.grey.shade300,
                                                    width: isActive ? 2.5 : 1,
                                                  ),
                                                  boxShadow: isActive ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))] : [],
                                                ),
                                                child: Text(
                                                  f,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w900,
                                                    color: isActive ? Colors.white : Colors.grey.shade500,
                                                  ),
                                                ),
                                              ),
                                              if (labels != null && fi < labels.length) ...[
                                                const SizedBox(height: 4),
                                                Text(
                                                  labels[fi] as String,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14,
                                                    color: isActive ? color : Colors.grey,
                                                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        );
                                      });
                                    }(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],

                          // 3. لوحة التتبع والكتابة التفاعلية
                          ArabicLetterTracingCanvas(
                            letterChar: widget.letterChar,
                            position: positionCode,
                            exampleWord: example,
                            exampleEmoji: s['exampleEmoji'] as String,
                            primaryColor: color,
                            onComplete: () {
                              _playAudio(s['wordAudio'] as String);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ─── Navigation Buttons ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: _prevStep,
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  label: const Text(
                    'السابق',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryDay,
                    side: const BorderSide(color: AppColors.primaryDay, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),

                // Dots
                Row(
                  children: List.generate(
                    _steps.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentStep == i ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentStep == i ? AppColors.primaryDay : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: _nextStep,
                  label: Text(
                    _currentStep == _steps.length - 1 ? 'التالي: ألعاب الحرف 🎮' : 'التالي',
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    _currentStep == _steps.length - 1 ? Icons.videogame_asset_rounded : Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentStep == _steps.length - 1 ? AppColors.oasisGreen : AppColors.primaryDay,
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



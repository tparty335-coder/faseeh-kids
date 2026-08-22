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

  // ─── مراحل كتابة ومواضع حرف الألف (مطابقة للأسطوانة الأصلية ahdaf_a3) ───
  static const List<Map<String, dynamic>> _steps = [
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
      'color': Color(0xFF673AB7),
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
      'color': Color(0xFFE53935),
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
      'color': Color(0xFFFF8F00),
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
      'color': Color(0xFF43A047),
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _playAudio(_steps[0]['audio'] as String);
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
                      fontSize: 13,
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
                      constraints: BoxConstraints(maxWidth: isTablet ? 600 : double.infinity),
                      child: Column(
                        children: [
                          // 1. بطاقة الصورة الأصلية للدرس ومثال الموضع
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
                            ),
                            child: Row(
                              children: [
                                // صورة الدرس الأصلية
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: SizedBox(
                                    width: 80,
                                    height: 60,
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
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            s['title'] as String,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: color,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: color,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              shape,
                                              style: const TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'مِثَالٌ: $example',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // 2. لوحة التتبع والكتابة التفاعلية بأسلوب لينغو بنانا
                          ArabicLetterTracingCanvas(
                            letterChar: widget.letterChar,
                            position: positionCode,
                            exampleWord: example,
                            exampleEmoji: s['exampleEmoji'] as String,
                            primaryColor: color,
                            onComplete: () {
                              AudioService.instance.playAsset('audio/instructions/alif_trace_praise.mp3');
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
                    _currentStep == _steps.length - 1 ? 'إنهاء الدرس 🎉' : 'التالي',
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    _currentStep == _steps.length - 1 ? Icons.check_circle_rounded : Icons.arrow_forward_ios_rounded,
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



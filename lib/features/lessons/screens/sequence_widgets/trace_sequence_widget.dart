import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';

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
      'letterShape': 'أ',
      'position': 'رَسْمُ الْحَرْفِ',
      'exampleWord': '',
      'audio': 'audio/stories/alif_trace_intro.mp3',
      'color': Color(0xFF1E88E5),
      'icon': Icons.edit_rounded,
    },
    {
      'title': 'الْأَلِفُ فِي أَوَّلِ الْكَلِمَةِ',
      'subtitle': 'يَأْتِي مُنْفَصِلاً غَيْرَ مُتَّصِلٍ بِمَا بَعْدَهُ',
      'letterShape': 'أ',
      'position': 'أَوَّلُ الْكَلِمَةِ',
      'exampleWord': 'أَكَلَ',
      'audio': 'audio/stories/alif_pos_start.mp3',
      'color': Color(0xFFE53935),
      'icon': Icons.start_rounded,
    },
    {
      'title': 'الْأَلِفُ فِي وَسَطِ الْكَلِمَةِ',
      'subtitle': 'يَتَّصِلُ بِمَا قَبْلَهُ وَلَا يَتَّصِلُ بِمَا بَعْدَهُ',
      'letterShape': 'ـأ',
      'position': 'وَسَطُ الْكَلِمَةِ',
      'exampleWord': 'سَأَلَ',
      'audio': 'audio/stories/alif_pos_middle.mp3',
      'color': Color(0xFFFF8F00),
      'icon': Icons.horizontal_rule_rounded,
    },
    {
      'title': 'الْأَلِفُ فِي آخِرِ الْكَلِمَةِ',
      'subtitle': 'يَأْتِي مُتَّصِلاً بِمَا قَبْلَهُ أَوْ مُنْفَصِلاً',
      'letterShape': 'ـأ / أ',
      'position': 'آخِرُ الْكَلِمَةِ',
      'exampleWord': 'قَرَأَ',
      'audio': 'audio/stories/alif_pos_end.mp3',
      'color': Color(0xFF43A047),
      'icon': Icons.check_circle_outline_rounded,
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
                    'كِتَابَةُ وَمَوَاضِعُ الْحَرْفِ (${_currentStep + 1}/${_steps.length})',
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

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Title & Subtitle Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
                        ),
                        child: Column(
                          children: [
                            Text(
                              s['title'] as String,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s['subtitle'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                color: AppColors.textPrimaryDay,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Large Letter Shape Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 3)),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Big Shape
                            Text(
                              shape,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 80,
                                fontWeight: FontWeight.w900,
                                color: color,
                              ),
                            ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),

                            const SizedBox(height: 8),

                            // Position tag
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                s['position'] as String,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),

                            if (example.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'مِثَالٌ: ',
                                    style: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    example,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
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


import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';

class LongVowelsSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;
  final bool isActive;

  const LongVowelsSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
    this.isActive = true,
  });

  @override
  State<LongVowelsSequenceWidget> createState() => _LongVowelsSequenceWidgetState();
}

class _LongVowelsSequenceWidgetState extends State<LongVowelsSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // ─────────────────────────────────────────────────────────────────────
  // خريطة المدود الأصلية لحرف الألف — موثقة من أسطوانة المنهج
  // ─────────────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> _mudud = [
    {
      'id': 'madd_alif',
      'label': 'الْمَدُّ بِالأَلِفِ (آ)',
      'maddChar': 'آ',
      'color': Color(0xFFD32F2F),
      'explanation': 'فَتْحَةٌ يَلِيهَا أَلِفٌ مِثْلُ: آمَال',
      'exampleWord': 'آمَال',
      'audioFile': 'audio/stories/alif_madd_amal.mp3',
      'imageFile': 'assets/images/lessons/alif/alif_word_amal.jpg',
    },
    {
      'id': 'madd_waw',
      'label': 'الْمَدُّ بِالْوَاوِ (أُو)',
      'maddChar': 'أُو',
      'color': Color(0xFFF57C00),
      'explanation': 'ضَمَّةٌ يَلِيهَا وَاوٌ مِثْلُ: الأُولَى',
      'exampleWord': 'الأُولَى',
      'audioFile': 'audio/stories/alif_madd_oula.mp3',
      'imageFile': 'assets/images/lessons/alif/alif_word_oula.jpg',
    },
    {
      'id': 'madd_yaa',
      'label': 'الْمَدُّ بِالْيَاءِ (إِي)',
      'maddChar': 'إِي',
      'color': Color(0xFF1976D2),
      'explanation': 'كَسْرَةٌ يَلِيهَا يَاءٌ مِثْلُ: إِينَاس',
      'exampleWord': 'إِينَاس',
      'audioFile': 'audio/stories/alif_madd_inas.mp3',
      'imageFile': 'assets/images/lessons/alif/alif_scene_inas.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _triggerAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant LongVowelsSequenceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _triggerAutoPlay();
    }
  }

  void _triggerAutoPlay() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _playMaddAudio(_mudud[_currentPage]);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playMaddAudio(Map<String, dynamic> madd) async {
    await AudioService.instance.stop();
    try {
      final path = madd['audioFile'] as String;
      await AudioService.instance.playAsset(path);
    } catch (e) {
      debugPrint('Madd audio error: $e');
    }
  }

  void _nextMadd() {
    if (_currentPage < _mudud.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _previousMadd() {
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
    final isTablet = MediaQuery.sizeOf(context).width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // ─── 1. شريط العنوان العلوي ───
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
                    'الْحَرَكَاتُ الطَّوِيلَةُ (الْمُدُودُ) — ${_mudud[_currentPage]['label']}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                  onPressed: () => _playMaddAudio(_mudud[_currentPage]),
                ),
              ],
            ),
          ),

          // ─── 2. عرض بطاقة المد الممتدة بجمال وتناسق ───
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                _playMaddAudio(_mudud[index]);
              },
              itemCount: _mudud.length,
              itemBuilder: (context, index) {
                final m = _mudud[index];
                final color = m['color'] as Color;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isTablet ? 560 : double.infinity),
                      child: Column(
                        children: [
                          // ── بطاقة القاعدة وشكل المد ──
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    m['maddChar'] as String,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: color,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        m['label'] as String,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        m['explanation'] as String,
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimaryDay,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          // ── بطاقة المثال المركزية الكبيرة ──
                          GestureDetector(
                            onTap: () => _playMaddAudio(m),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // عنوان الكلمة
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'مِثَالٌ: ',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        m['exampleWord'] as String,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 36,
                                          fontWeight: FontWeight.w900,
                                          color: color,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // الصورة المركزية الكبيرة المتناسقة
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Container(
                                        color: Colors.grey.shade100,
                                        child: Image.asset(
                                          m['imageFile'] as String,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) => Container(
                                            color: Colors.grey.shade100,
                                            child: const Icon(Icons.image, size: 64, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // زر الاستماع التفاعلي
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.volume_up_rounded, color: color, size: 24),
                                        const SizedBox(width: 8),
                                        Text(
                                          'اضْغَطْ لِسَمَاعِ شَرْحِ الْمَدِّ',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ─── 3. أزرار التنقل ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: _previousMadd,
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
                  children: List.generate(_mudud.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == i ? 24 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _currentPage == i ? AppColors.primaryDay : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                ),

                ElevatedButton.icon(
                  onPressed: _nextMadd,
                  label: Text(
                    _currentPage == _mudud.length - 1 ? 'التالي: الْكَلِمَات' : 'التالي',
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

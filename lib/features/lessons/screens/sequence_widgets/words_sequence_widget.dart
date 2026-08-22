import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/services/audio_registry.dart';

/// WordsSequenceWidget
/// يعرض كلمات الحرف من الأسطوانة الأصلية مع صور وأصوات أصيلة
/// الترتيب: فتحة ← ضمة ← كسرة ← مد الألف
class WordsSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;
  final bool isActive;

  const WordsSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
    this.isActive = true,
  });

  @override
  State<WordsSequenceWidget> createState() => _WordsSequenceWidgetState();
}

class _WordsSequenceWidgetState extends State<WordsSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // ─── بيانات كلمات حرف الألف (مطابقة تماماً للأسطوانة الأصلية) ───
  static const List<Map<String, dynamic>> _alifWords = [
    {
      'word': 'أَكَلَ',
      'haraka': 'الْفَتْحَة (أَوَّل الْكَلِمَة)',
      'harakaChar': 'َ',
      'color': Color(0xFFE53935),
      'image': 'alif_word_akala.jpg',
      'audio': 'stories/alif_word_akala.mp3',
      'emoji': '🍽️',
    },
    {
      'word': 'سَأَلَ',
      'haraka': 'الْفَتْحَة (وَسَط الْكَلِمَة)',
      'harakaChar': 'َ',
      'color': Color(0xFFE53935),
      'image': 'alif_word_saala.jpg',
      'audio': 'stories/alif_word_saala.mp3',
      'emoji': '🙋‍♂️',
    },
    {
      'word': 'قَرَأَ',
      'haraka': 'الْفَتْحَة (آخِر الْكَلِمَة)',
      'harakaChar': 'َ',
      'color': Color(0xFFE53935),
      'image': 'alif_word_qaraa.jpg',
      'audio': 'stories/alif_word_qaraa.mp3',
      'emoji': '📖',
    },
    {
      'word': 'أُذُن',
      'haraka': 'الضَّمَّةُ (أُ)',
      'harakaChar': 'ُ',
      'color': Color(0xFFFF6F00),
      'image': 'alif_word_udhun.jpg',
      'audio': 'stories/alif_word_udhun.mp3',
      'emoji': '👂',
    },
    {
      'word': 'أُمِّي',
      'haraka': 'الضَّمَّةُ (أُ)',
      'harakaChar': 'ُ',
      'color': Color(0xFFFF6F00),
      'image': 'alif_word_ummi.jpg',
      'audio': 'stories/alif_word_ummi.mp3',
      'emoji': '👩‍👧',
    },
    {
      'word': 'إِبْرَة',
      'haraka': 'الْكَسْرَةُ (إِ)',
      'harakaChar': 'ِ',
      'color': Color(0xFF1E88E5),
      'image': 'alif_word_ibra.jpg',
      'audio': 'stories/alif_word_ibra.mp3',
      'emoji': '🪡',
    },
    {
      'word': 'إِينَاس',
      'haraka': 'الْمَدُّ بِالْيَاءِ',
      'harakaChar': 'ِي',
      'color': Color(0xFF8E24AA),
      'image': 'alif_word_inas.jpg',
      'audio': 'stories/alif_word_inas.mp3',
      'emoji': '👧',
    },
    {
      'word': 'فَأْس',
      'haraka': 'السُّكُونُ (أْ)',
      'harakaChar': 'ْ',
      'color': Color(0xFF5D4037),
      'image': 'alif_word_faas.jpg',
      'audio': 'stories/alif_word_faas.mp3',
      'emoji': '🪓',
    },
  ];

  static const List<Map<String, dynamic>> _defaultWords = [
    {
      'word': 'أَسَد',
      'haraka': 'الْفَتْحَة',
      'harakaChar': 'َ',
      'color': Color(0xFFE53935),
      'image': '{lk}_word_asad.jpg',
      'audio': 'letters/words/{lk}_word.mp3',
      'emoji': '🦁',
    },
    {
      'word': 'أُذُن',
      'haraka': 'الضَّمَّة',
      'harakaChar': 'ُ',
      'color': Color(0xFFFF6F00),
      'image': '{lk}_word_udhun.jpg',
      'audio': 'letters/words/{lk}_word2.mp3',
      'emoji': '👂',
    },
    {
      'word': 'إِبْرَة',
      'haraka': 'الْكَسْرَة',
      'harakaChar': 'ِ',
      'color': Color(0xFF1E88E5),
      'image': '{lk}_word_ibra.jpg',
      'audio': 'letters/words/{lk}_word3.mp3',
      'emoji': '🪡',
    },
    {
      'word': 'إِينَاس',
      'haraka': 'الْمَدُّ بِالْيَاءِ',
      'harakaChar': 'ِي',
      'color': Color(0xFF8E24AA),
      'image': '{lk}_word_inas.jpg',
      'audio': 'letters/words/{lk}_word4.mp3',
      'emoji': '👧',
    },
  ];

  List<Map<String, dynamic>> get _words =>
      widget.letterChar == 'أ' ? _alifWords : _defaultWords;

  String _resolve(String template) {
    final lk = AudioRegistry.letterKeyFromChar(widget.letterChar);
    return template.replaceAll('{lk}', lk);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _triggerAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant WordsSequenceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _triggerAutoPlay();
    }
  }

  void _triggerAutoPlay() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _playWordAudio(_words[_currentPage]);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage < _words.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _goPrev() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      AudioService.instance.stop();
      widget.onPrevious();
    }
  }

  void _playWordAudio(Map<String, dynamic> w) async {
    await AudioService.instance.stop();
    await AudioService.instance.playAsset('audio/${_resolve(w['audio'])}');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          const SizedBox(height: 8),
          // عنوان القسم
          Text(
            'كَلِمَاتُ حَرْفِ (${widget.letterChar})',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDay,
              fontFamily: 'Cairo',
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 6),

          // PageView للكلمات
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) {
                setState(() => _currentPage = i);
                _playWordAudio(_words[i]);
              },
              itemCount: _words.length,
              itemBuilder: (_, i) => _buildWordPage(_words[i]),
            ),
          ),

          // أزرار التنقل
          _buildNavRow(),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildWordPage(Map<String, dynamic> w) {
    final color = w['color'] as Color;
    final lk = AudioRegistry.letterKeyFromChar(widget.letterChar);
    final imgPath = 'assets/images/lessons/$lk/${_resolve(w['image'])}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 6),

          // شارة الحركة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.6), width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  w['haraka'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  w['emoji'] as String,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2),

          const SizedBox(height: 10),

          // الصورة
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imgPath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
                  ),
                  child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        w['emoji'] as String,
                        style: const TextStyle(fontSize: 80),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        w['word'] as String,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.88, 0.88), duration: 400.ms, curve: Curves.easeOutBack),

          const SizedBox(height: 10),

          // الكلمة الكبيرة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Text(
              w['word'] as String,
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: color,
                fontFamily: 'Cairo',
                height: 1.2,
              ),
            ),
          ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.15),

          const SizedBox(height: 10),

          // زر الاستماع
          ElevatedButton.icon(
            onPressed: () => _playWordAudio(w),
            icon: const Icon(Icons.volume_up_rounded, size: 26),
            label: const Text(
              'استمع',
              style: TextStyle(fontSize: 20, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              elevation: 4,
            ),
          ).animate().fadeIn(delay: 220.ms).slideY(begin: 0.15),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildNavRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton.icon(
            onPressed: _goPrev,
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            label: Text(
              _currentPage == 0 ? 'السابق: المدود' : 'السابق',
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 15),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimaryDay,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),

          // نقاط التقدم
          Row(
            children: List.generate(_words.length, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == i ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == i ? AppColors.primaryDay : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            )),
          ),

          ElevatedButton.icon(
            onPressed: _goNext,
            icon: Text(
              _currentPage == _words.length - 1 ? 'التالي: الكتابة' : 'التالي',
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold),
            ),
            label: const Icon(Icons.arrow_forward_ios, size: 16),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDay,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StorySequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final String letterChar;

  const StorySequenceWidget({
    super.key,
    required this.onNext,
    required this.letterChar,
  });

  @override
  State<StorySequenceWidget> createState() => _StorySequenceWidgetState();
}

class _StorySequenceWidgetState extends State<StorySequenceWidget> {
  final PageController _pageController = PageController();
  int _currentFrameIndex = 0;
  bool _foundRabbit = false;
  late final ConfettiController _confettiController;

  List<Map<String, dynamic>> get _storyFrames => _getStoryFramesForLetter(widget.letterChar);

  static List<Map<String, dynamic>> _getStoryFramesForLetter(String letter) {
    if (letter == 'ب') {
      return [
        {
          'title': 'الْمَشْهَدُ الْأَوَّلُ — تَعَرَّفْ عَلَى الْحَرْفِ',
          'caption': 'حَرْفُ الْبَاءِ — صَوْتُهُ (بَ) مِثْلُ: بَطَّة وَبَاب وَبَقَرَة',
          'image': 'assets/images/lessons/baa/baa_story.jpg',
          'audio': 'audio/letters/core/baa_name.mp3',
          'isInteractive': false,
        },
        {
          'title': 'الْمَشْهَدُ الثَّانِي — الْبَاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'caption': 'يَأْتِي حَرْفُ الْبَاءِ فِي أَوَّلِ الْكَلِمَةِ — مِثَالٌ: بَقَرَة',
          'image': 'assets/images/lessons/baa/baa_words.jpg',
          'audio': 'audio/letters/core/baa_pos_start.mp3',
          'isInteractive': false,
        },
        {
          'title': 'الْمَشْهَدُ الثَّالِثُ — الْبَاءُ فِي وَسَطِ الْكَلِمَةِ',
          'caption': 'يَأْتِي حَرْفُ الْبَاءِ فِي وَسَطِ الْكَلِمَةِ — مِثَالٌ: ثُعْبَان',
          'image': 'assets/images/lessons/baa/baa_fishing.jpg',
          'audio': 'audio/letters/core/baa_pos_middle.mp3',
          'isInteractive': false,
        },
        {
          'title': 'الْمَشْهَدُ الرَّابِعُ — الْبَاءُ فِي آخِرِ الْكَلِمَةِ',
          'caption': 'يَأْتِي حَرْفُ الْبَاءِ فِي آخِرِ الْكَلِمَةِ — مِثَالٌ: بَاب',
          'image': 'assets/images/lessons/baa/baa_madd.jpg',
          'audio': 'audio/letters/core/baa_pos_end.mp3',
          'isInteractive': false,
        },
        {
          'title': 'الْمَشْهَدُ الْخَامِسُ — جُمْلَةُ الْحَرْفِ',
          'caption': 'اسْتَمِعْ إِلَى جُمْلَةِ حَرْفِ الْبَاءِ وَأَعِدْ تَرْدِيدَهَا',
          'image': 'assets/images/lessons/baa/baa_bee.jpg',
          'audio': 'audio/letters/phrases/baa_sentence.mp3',
          'isInteractive': false,
        },
        {
          'title': 'سُؤَالُ الْفَهْمِ — أَيْنَ حَرْفُ الْبَاءِ؟',
          'caption': 'اضْغَطْ عَلَى الصُّورَةِ الَّتِي تَبْدَأُ بِحَرْفِ الْبَاءِ!',
          'image': 'assets/images/lessons/baa/baa_words.jpg',
          'audio': 'audio/letters/phrases/baa_fatha_demo.mp3',
          'isInteractive': true,
        },
      ];
    }

    // افتراضي لحرف الألف (مطابقة للأسطوانة الأصلية)
    return [
      {
        'title': 'الْمَشْهَدُ الْأَوَّلُ',
        'caption': 'فِي يَوْمٍ مِنَ الْأَيَّامِ، كَانَ الْأَسَدُ يَسِيرُ فِي الْغَابَةِ يُفَكِّرُ فِي طَعَامِهِ',
        'image': 'assets/images/lessons/alif/alif_cd_story_1.png',
        'audio': 'audio/stories/alif_story_1.mp3',
        'isInteractive': false,
      },
      {
        'title': 'الْمَشْهَدُ الثَّانِي',
        'caption': 'فَهُوَ لَمْ يَأْكُلِ الْيَوْمَ شَيْئًا. وَفَجْأَةً شَاهَدَ أَرْنَبًا فِي الطَّرِيقِ',
        'image': 'assets/images/lessons/alif/alif_cd_story_2.png',
        'audio': 'audio/stories/alif_story_2.mp3',
        'isInteractive': false,
      },
      {
        'title': 'الْمَشْهَدُ الثَّالِثُ',
        'caption': 'حَاوَلَ الْأَسَدُ الْجَرْيَ وَرَاءَ الْأَرْنَبِ، وَلَكِنَّهُ فَشِلَ',
        'image': 'assets/images/lessons/alif/alif_cd_story_3.png',
        'audio': 'audio/stories/alif_story_3.mp3',
        'isInteractive': false,
      },
      {
        'title': 'الْمَشْهَدُ الرَّابِعُ',
        'caption': 'وَفَجْأَةً اخْتَفَى الْأَرْنَبُ. قَالَ الْأَسَدُ: أَيْنَ ذَهَبَ الْأَرْنَبُ؟',
        'image': 'assets/images/lessons/alif/alif_cd_story_4.png',
        'audio': 'audio/stories/alif_story_4.mp3',
        'isInteractive': false,
      },
      {
        'title': 'الْمَشْهَدُ الْخَامِسُ',
        'caption': 'فَكِّرْ مَعَنَا: أَيْنَ اخْتَفَى الْأَرْنَبُ؟',
        'image': 'assets/images/lessons/alif/alif_cd_story_5.png',
        'audio': 'audio/stories/alif_story_5.mp3',
        'isInteractive': false,
      },
      {
        'title': 'سُؤَالُ الْفَهْمِ',
        'caption': 'مَنْ يَعْرِفُ مَكَانَ الْأَرْنَبِ يَضْغَطْ عَلَيْهِ!',
        'image': 'assets/images/lessons/alif/alif_cd_story_6.png',
        'audio': 'audio/stories/alif_story_6.mp3',
        'isInteractive': true,
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 1200));
    _playCurrentAudio();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playCurrentAudio() async {
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset(_storyFrames[_currentFrameIndex]['audio'] as String);
    } catch (e) {
      debugPrint('Story audio error: $e');
    }
  }

  void _goToFrame(int index) {
    if (index >= 0 && index < _storyFrames.length) {
      setState(() {
        _currentFrameIndex = index;
        if (index != 5) _foundRabbit = false;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      _playCurrentAudio();
    }
  }

  void _onRabbitTapped() async {
    if (_foundRabbit) return;
    setState(() => _foundRabbit = true);
    _confettiController.play();
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset('audio/stories/alif_correct.mp3');
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final frame = _storyFrames[_currentFrameIndex];
    final isTablet = MediaQuery.sizeOf(context).width > 600;
    final isLast = _currentFrameIndex == _storyFrames.length - 1;
    final isFirst = _currentFrameIndex == 0;
    final isInteractive = frame['isInteractive'] as bool;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Column(
            children: [
              // ─── 1. شريط العنوان ───
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDay,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Text(
                          'قِصَّةُ (${widget.letterChar}) — ${frame['title']}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                      onPressed: _playCurrentAudio,
                    ),
                  ],
                ),
              ),

              // ─── 2. لوحة الصورة ───
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _storyFrames.length,
                          itemBuilder: (_, i) => Image.asset(
                            _storyFrames[i]['image'] as String,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.amber.shade100,
                              child: Center(
                                child: Text(
                                  _storyFrames[i]['caption'] as String,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ─── أسهم التنقل التفاعلية المدمجة في أسفل الصورة ───
                        LayoutBuilder(builder: (ctx, box) {
                          const imgAspect = 800.0 / 600.0;
                          final boxAspect = box.maxWidth / box.maxHeight;
                          double imgW, imgH, ox, oy;
                          if (boxAspect > imgAspect) {
                            imgH = box.maxHeight;
                            imgW = imgH * imgAspect;
                            ox = (box.maxWidth - imgW) / 2;
                            oy = 0;
                          } else {
                            imgW = box.maxWidth;
                            imgH = imgW / imgAspect;
                            ox = 0;
                            oy = (box.maxHeight - imgH) / 2;
                          }

                          // السهم الأيمن (السابق / الرجوع للخلف في قراءة العربية)
                          final rightBtnLeft = ox + imgW * 0.60;
                          final rightBtnTop = oy + imgH * 0.84;
                          final rightBtnWidth = imgW * 0.28;
                          final rightBtnHeight = imgH * 0.15;

                          // السهم الأيسر (التالي / التقدم للأمام في قراءة العربية)
                          final leftBtnLeft = ox + imgW * 0.12;
                          final leftBtnTop = oy + imgH * 0.84;
                          final leftBtnWidth = imgW * 0.28;
                          final leftBtnHeight = imgH * 0.15;

                          // نقطة الأرنب التفاعلية (مطابقة لمركز الأرنب تماماً في المشهد 6)
                          final rl = ox + imgW * 0.258 - 44;
                          final rt = oy + imgH * 0.704 - 44;

                          return Stack(children: [
                            // ── زر السهم الأيسر (التقدم للأمام) ──
                            Positioned(
                              left: leftBtnLeft,
                              top: leftBtnTop,
                              width: leftBtnWidth,
                              height: leftBtnHeight,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (isLast) {
                                    AudioService.instance.stop();
                                    widget.onNext();
                                  } else {
                                    _goToFrame(_currentFrameIndex + 1);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),

                            // ── زر السهم الأيمن (الرجوع للخلف) ──
                            if (!isFirst)
                              Positioned(
                                left: rightBtnLeft,
                                top: rightBtnTop,
                                width: rightBtnWidth,
                                height: rightBtnHeight,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => _goToFrame(_currentFrameIndex - 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),

                            // ── نقطة الأرنب التفاعلية (المشهد السادس فقط) ──
                            if (isInteractive) ...[
                              if (!_foundRabbit)
                                Positioned(
                                  left: rl, top: rt,
                                  child: GestureDetector(
                                    onTap: _onRabbitTapped,
                                    child: Container(
                                      width: 88, height: 88,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.yellow.shade600.withValues(alpha: 0.9),
                                          width: 3.5,
                                        ),
                                        color: Colors.white.withValues(alpha: 0.12),
                                      ),
                                      child: const Center(
                                        child: Text('?', style: TextStyle(
                                          fontSize: 34, fontWeight: FontWeight.bold, color: Colors.yellow,
                                        )),
                                      ),
                                    ),
                                  ).animate(onPlay: (c) => c.repeat(reverse: true))
                                   .scale(begin: const Offset(0.88, 0.88), end: const Offset(1.15, 1.15), duration: 700.ms),
                                ),

                              if (_foundRabbit)
                                Positioned(
                                  left: rl, top: rt,
                                  child: Container(
                                    width: 88, height: 88,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber.withValues(alpha: 0.92),
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 12, spreadRadius: 2)],
                                    ),
                                    child: const Center(child: Text('🐰', style: TextStyle(fontSize: 46))),
                                  ).animate().scale(duration: 450.ms, curve: Curves.elasticOut),
                                ),

                              if (_foundRabbit)
                                Positioned(
                                  top: 12, left: 12, right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.successDay,
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star_rounded, color: Colors.yellow, size: 26),
                                        SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            'أَحْسَنْتَ! وَجَدْتَ الْأَرْنَبَ الْمُخْتَبِئَ! 🎉',
                                            style: TextStyle(
                                              fontFamily: 'Cairo', fontSize: 16,
                                              fontWeight: FontWeight.bold, color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
                                ),
                            ],
                          ]);
                        }),
                      ],
                    ),
                  ),
                ),
              ),

              // ─── 3. صندوق النص (خط كبير وواضح للأطفال) ───
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryDay.withValues(alpha: 0.5), width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                child: Text(
                  frame['caption'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: isTablet ? 28 : 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimaryDay,
                    height: 1.4,
                  ),
                ),
              ),

              // ─── 4. أزرار التنقل ───
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: isFirst ? null : () => _goToFrame(_currentFrameIndex - 1),
                      icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                      label: const Text('السابق',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryDay,
                        side: const BorderSide(color: AppColors.primaryDay, width: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),

                    Row(
                      children: List.generate(_storyFrames.length, (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _currentFrameIndex == i ? 22 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentFrameIndex == i ? AppColors.primaryDay : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )),
                    ),

                    ElevatedButton.icon(
                      onPressed: () {
                        if (isLast) {
                          AudioService.instance.stop();
                          widget.onNext();
                        } else {
                          _goToFrame(_currentFrameIndex + 1);
                        }
                      },
                      label: Text(
                        isLast ? 'التالي: الْحَرَكَات' : 'التالي',
                        style: const TextStyle(
                          fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDay,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),

          // ─── الاحتفالية ───
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.amber, Colors.orange, Colors.pink, Colors.green, Colors.blue],
              numberOfParticles: 25,
            ),
          ),
        ],
      ),
    );
  }
}

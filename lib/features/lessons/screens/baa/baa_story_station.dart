import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// ═══════════════════════════════════════════════════════════════════
/// محطة قصة حرف الباء — المعتمدة بدقة الصفر-خطأ من أسطوانة الوزارة الأصلية
/// 6 مشاهد متسلسلة + سؤال تفاعلي ذكي في المشهد الرابع + نشيد الحرف الأصلي
/// ═══════════════════════════════════════════════════════════════════

class BaaStoryStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaStoryStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<BaaStoryStation> createState() => _BaaStoryStationState();
}

class _BaaStoryStationState extends State<BaaStoryStation> {
  final PageController _pageController = PageController();
  int _currentSceneIndex = 0;
  bool _isPlayingAudio = false;

  // حالة السؤال التفاعلي في المشهد الرابع
  bool _scene4Answered = false;
  String? _selectedOption; // 'milk', 'clover', 'egg'
  late final ConfettiController _confettiController;

  static const List<Map<String, dynamic>> _scenes = [
    {
      'sceneNumber': 1,
      'title': 'المشهد الأول',
      'caption': 'اَلْفَلَّاحُ رَجُلٌ نَشِيطٌ يَذْهَبُ إِلَى اَلْحَقْلِ مُبَكِّرًا.',
      'image': 'assets/images/lessons/baa/baa_cd_story_1.png',
      'audio': 'audio/stories/baa_story_1.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 2,
      'title': 'المشهد الثاني',
      'caption': 'وَيَأْخُذُ مَعَهُ بَقَرَةً وَكَلْبَ حِرَاسَةٍ.',
      'image': 'assets/images/lessons/baa/baa_cd_story_2.png',
      'audio': 'audio/stories/baa_story_2.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 3,
      'title': 'المشهد الثالث',
      'caption': 'فِي اَلْحَقْلِ يَعْمَلُ اَلْفَلَّاحُ بِنَشَاطٍ، وَتَأْكُلُ اَلْبَقَرَةُ اَلْبِرْسِيمَ، وَاَلْبَطُّ يَسْبَحُ فِي اَلْمَاءِ.',
      'image': 'assets/images/lessons/baa/baa_cd_story_3.png',
      'audio': 'audio/stories/baa_story_3.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 4,
      'title': 'المشهد الرابع: سؤال الفهم',
      'caption': 'مَاذَا نَأْخُذُ مِنَ اَلْبَقَرَةِ؟',
      'image': 'assets/images/lessons/baa/baa_cd_story_4.png',
      'audio': 'audio/stories/baa_story_4.mp3',
      'isInteractive': true,
    },
    {
      'sceneNumber': 5,
      'title': 'المشهد الخامس',
      'caption': 'وَفِي اَلْمَسَاءِ يَعُودُ اَلْفَلَّاحُ إِلَى بَيْتِهِ مَسْرُورًا.',
      'image': 'assets/images/lessons/baa/baa_cd_story_5.png',
      'audio': 'audio/stories/baa_story_5.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 6,
      'title': 'المشهد السادس: نشيد الحرف 🎵',
      'caption': 'بَاءٌ بَطَّةْ .. وَضَعَتْ بَيْضَةْ\nخَلْفَ الْبَقَرَةْ .. جَنْبَ الشَّجَرَةْ',
      'image': 'assets/images/lessons/baa/baa_cd_story_6.png',
      'audio': 'audio/stories/baa_story_6.mp3',
      'isInteractive': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playSceneAudio(_currentSceneIndex);
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playSceneAudio(int index) async {
    if (!mounted) return;
    setState(() => _isPlayingAudio = true);
    await AudioService.instance.stop();
    try {
      final audioPath = _scenes[index]['audio'] as String;
      await AudioService.instance.playAsset(audioPath);
    } catch (e) {
      debugPrint('Baa story audio error: $e');
    }
    if (mounted) setState(() => _isPlayingAudio = false);
  }

  void _goToScene(int index) {
    if (index >= 0 && index < _scenes.length) {
      setState(() {
        _currentSceneIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _playSceneAudio(index);
    }
  }

  void _nextScene() {
    if (_currentSceneIndex == 3 && !_scene4Answered) {
      // إشعار لطيف عند محاولة تخطي السؤال
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🥛', style: TextStyle(fontSize: 22)),
              SizedBox(width: 8),
              Text(
                'اختر الإجابة الصحيحة أولاً يا بطل: ماذا نأخذ من البقرة؟',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.amber.shade900,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      );
      return;
    }

    if (_currentSceneIndex < _scenes.length - 1) {
      _goToScene(_currentSceneIndex + 1);
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _previousScene() {
    if (_currentSceneIndex > 0) {
      _goToScene(_currentSceneIndex - 1);
    } else {
      widget.onPrevious();
    }
  }

  // ── منطق السؤال التفاعلي للمشهد الرابع ────────────────────────
  Future<void> _handleOptionSelected(String option) async {
    setState(() => _selectedOption = option);

    if (option == 'milk') {
      // إجابة صحيحة!
      setState(() => _scene4Answered = true);
      _confettiController.play();
      await AudioService.instance.stop();
      // صوت الإجابة الصحيحة الأصلي المفرغ من الأسطوانة: "أحسنت نأخذ من البقرة اللبن ونصنع منه الجبن والزبد"
      await AudioService.instance.playAsset('audio/stories/baa_story_4_correct.mp3');
    } else {
      // إجابة خاطئة — صوت الأسطوانة الأصلي: "حاول مرة أخرى"
      await AudioService.instance.stop();
      await AudioService.instance.playAsset('audio/stories/baa_story_4_wrong.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentScene = _scenes[_currentSceneIndex];
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          // خلفية دافئة لطيفة متناسقة مع طبيعة الريف المصري
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFDE7), // أصفر شمس هادئ
                  Color(0xFFF1F8E9), // أخضر مروج ناعم
                  Color(0xFFE8F5E9),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── 1. الشريط العلوي لمشاهد القصة ────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // شارة رقم وعنوان المشهد
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6D4C41),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_stories_rounded, color: Colors.amber, size: 22),
                            const SizedBox(width: 8),
                            Text(
                              currentScene['title'] as String,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: isTablet ? 18 : 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // مؤشرات التقدم بين المشاهد (6 نقاط تفاعلية)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_scenes.length, (idx) {
                          final isActive = idx == _currentSceneIndex;
                          return GestureDetector(
                            onTap: () => _goToScene(idx),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: isActive ? (isTablet ? 32 : 24) : (isTablet ? 12 : 9),
                              height: isTablet ? 12 : 9,
                              decoration: BoxDecoration(
                                color: isActive ? const Color(0xFF2E7D32) : Colors.brown.shade200,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isActive ? Colors.white : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      // زر إعادة الاستماع الصوتي
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF4CAF50), width: 2.5),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isPlayingAudio ? Icons.volume_up_rounded : Icons.volume_up_outlined,
                            color: const Color(0xFF2E7D32),
                            size: isTablet ? 28 : 24,
                          ),
                          tooltip: 'استمع للصوت',
                          onPressed: () => _playSceneAudio(_currentSceneIndex),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── 2. إطار لوحة المشهد البصري الأصلي المستخلص ───────────
                Expanded(
                  flex: isTablet ? 7 : 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 28 : 16, vertical: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFF8D6E63), width: 4),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _scenes.length,
                          itemBuilder: (context, index) {
                            final imgAsset = _scenes[index]['image'] as String;
                            return Center(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  width: 1024,
                                  height: 398,
                                  child: Stack(
                                    children: [
                                      // الصورة الأصلية للمشهد بأبعادها الكاملة 1024x398
                                      Positioned.fill(
                                        child: Image.asset(
                                          imgAsset,
                                          width: 1024,
                                          height: 398,
                                          fit: BoxFit.fill,
                                        ),
                                      ),

                                      // تفاعلية المشهد الرابع: مناطق اللمس المطبقة بالمليمتر فوق الدوائر
                                      if (index == 3) ...[
                                        // 1. لبن (صحيح) - الإحداثيات الدقيقة بالبكسل: x:15, y:30, w:160, h:105
                                        Positioned(
                                          left: 15,
                                          top: 30,
                                          width: 160,
                                          height: 105,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () => _handleOptionSelected('milk'),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.elliptical(80, 52.5)),
                                                border: Border.all(
                                                  color: _scene4Answered
                                                      ? Colors.greenAccent
                                                      : Colors.amber.withValues(alpha: 0.85),
                                                  width: _scene4Answered ? 5 : 3.5,
                                                ),
                                                color: _scene4Answered
                                                    ? Colors.green.withValues(alpha: 0.25)
                                                    : Colors.transparent,
                                              ),
                                            ).animate(onPlay: (c) => c.repeat(reverse: true))
                                             .scale(begin: const Offset(0.97, 0.97), end: const Offset(1.03, 1.03), duration: 750.ms),
                                          ),
                                        ),

                                        // 2. برسيم - الإحداثيات الدقيقة بالبكسل: x:170, y:155, w:160, h:105
                                        Positioned(
                                          left: 170,
                                          top: 155,
                                          width: 160,
                                          height: 105,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () => _handleOptionSelected('clover'),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.elliptical(80, 52.5)),
                                                border: Border.all(
                                                  color: _selectedOption == 'clover'
                                                      ? Colors.red
                                                      : Colors.transparent,
                                                  width: 3.5,
                                                ),
                                                color: _selectedOption == 'clover'
                                                    ? Colors.red.withValues(alpha: 0.2)
                                                    : Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // 3. بيض - الإحداثيات الدقيقة بالبكسل: x:15, y:255, w:160, h:105
                                        Positioned(
                                          left: 15,
                                          top: 255,
                                          width: 160,
                                          height: 105,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () => _handleOptionSelected('egg'),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.elliptical(80, 52.5)),
                                                border: Border.all(
                                                  color: _selectedOption == 'egg'
                                                      ? Colors.red
                                                      : Colors.transparent,
                                                  width: 3.5,
                                                ),
                                                color: _selectedOption == 'egg'
                                                    ? Colors.red.withValues(alpha: 0.2)
                                                    : Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // شارة التهنئة المبهجة عند الإجابة الصحيحة
                                        if (_scene4Answered)
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(24),
                                                border: Border.all(color: const Color(0xFF4CAF50), width: 3.5),
                                                boxShadow: const [
                                                  BoxShadow(color: Colors.black26, blurRadius: 14, offset: Offset(0, 4)),
                                                ],
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('🥛', style: TextStyle(fontSize: 34)),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    'مُمْتَازٌ! نَأْخُذُ مِنَ الْبَقَرَةِ اللَّبَنَ!',
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.w900,
                                                      color: Color(0xFF2E7D32),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
                                          ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // ── 3. المنطقة التفاعلية (أزرار السؤال في المشهد 4 أو بطاقة النص) ──
                if (_currentSceneIndex == 3)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFF81C784), width: 2.5),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'مَاذَا نَأْخُذُ مِنَ الْبَقَرَةِ؟',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: isTablet ? 22 : 18,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF1B5E20),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildLargeChoiceButton(
                                label: 'لَبَنٌ',
                                emoji: '🥛',
                                isCorrect: true,
                                isSelected: _selectedOption == 'milk',
                                isAnswered: _scene4Answered,
                                isTablet: isTablet,
                                onTap: () => _handleOptionSelected('milk'),
                              ),
                              _buildLargeChoiceButton(
                                label: 'بِرْسِيمٌ',
                                emoji: '🌿',
                                isCorrect: false,
                                isSelected: _selectedOption == 'clover',
                                isAnswered: _scene4Answered,
                                isTablet: isTablet,
                                onTap: () => _handleOptionSelected('clover'),
                              ),
                              _buildLargeChoiceButton(
                                label: 'بَيْضٌ',
                                emoji: '🥚',
                                isCorrect: false,
                                isSelected: _selectedOption == 'egg',
                                isAnswered: _scene4Answered,
                                isTablet: isTablet,
                                onTap: () => _handleOptionSelected('egg'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  // بطاقة النص المشكول بخط Cairo كبير وواضح
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16, vertical: 8),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isTablet ? 16 : 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFF8D6E63), width: 2.5),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Text(
                        currentScene['caption'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isTablet ? 24 : 19,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),

                // ── 4. أزرار التنقل السفلية ───────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 36 : 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // زر السابق
                      OutlinedButton.icon(
                        onPressed: _previousScene,
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                        label: Text(
                          _currentSceneIndex == 0 ? 'المحطة السابقة' : 'المشهد السابق',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: isTablet ? 18 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF5D4037),
                          side: const BorderSide(color: Color(0xFF8D6E63), width: 2),
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 24 : 18,
                            vertical: isTablet ? 14 : 10,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),

                      // زر التالي
                      ElevatedButton.icon(
                        onPressed: _nextScene,
                        icon: Text(
                          _currentSceneIndex == _scenes.length - 1 ? 'المحطة التالية' : 'المشهد التالي',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: isTablet ? 18 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        label: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentSceneIndex == 3 && !_scene4Answered
                              ? Colors.grey
                              : const Color(0xFFFF9800),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 28 : 20,
                            vertical: isTablet ? 14 : 10,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // كونفيتي الاحتفال في أعلى الشاشة
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 40,
              colors: const [
                Colors.green,
                Colors.amber,
                Colors.orange,
                Colors.blue,
                Colors.pink,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeChoiceButton({
    required String label,
    required String emoji,
    required bool isCorrect,
    required bool isSelected,
    required bool isAnswered,
    required bool isTablet,
    required VoidCallback onTap,
  }) {
    Color bg = Colors.white;
    Color border = const Color(0xFFBDBDBD);

    if (isSelected) {
      if (isCorrect) {
        bg = const Color(0xFFE8F5E9);
        border = const Color(0xFF4CAF50);
      } else {
        bg = const Color(0xFFFFEBEE);
        border = const Color(0xFFE53935);
      }
    } else if (isAnswered && isCorrect) {
      bg = const Color(0xFFE8F5E9);
      border = const Color(0xFF4CAF50);
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 28 : 18,
          vertical: isTablet ? 12 : 8,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: border.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: isTablet ? 28 : 22)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isTablet ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: isSelected && !isCorrect ? Colors.red.shade800 : const Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// ═══════════════════════════════════════════════════════════════════
/// محطة قصة حرف الألف — نسخة مرآة من BaaStoryStation بمشاهد الأسطوانة الأصلية
/// 6 مشاهد متسلسلة + اكتشاف الأرنب التفاعلي في المشهد السادس + نشيد الحرف الأصلي
/// ═══════════════════════════════════════════════════════════════════

class AlifStoryStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const AlifStoryStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<AlifStoryStation> createState() => _AlifStoryStationState();
}

class _AlifStoryStationState extends State<AlifStoryStation> {
  final PageController _pageController = PageController();
  int _currentSceneIndex = 0;
  bool _isPlayingAudio = false;
  bool _foundRabbit = false;
  late final ConfettiController _confettiController;

  static const List<Map<String, dynamic>> _scenes = [
    {
      'sceneNumber': 1,
      'title': 'المشهد الأول',
      'caption': 'فِي يَوْمٍ مِنَ الْأَيَّامِ، كَانَ الْأَسَدُ يَسِيرُ فِي الْغَابَةِ يُفَكِّرُ فِي طَعَامِهِ.',
      'image': 'assets/images/lessons/alif/alif_cd_story_1.png',
      'audio': 'audio/stories/alif_story_1.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 2,
      'title': 'المشهد الثاني',
      'caption': 'فَهُوَ لَمْ يَأْكُلِ الْيَوْمَ شَيْئًا، وَفَجْأَةً شَاهَدَ أَرْنَبًا فِي الطَّرِيقِ.',
      'image': 'assets/images/lessons/alif/alif_cd_story_2.png',
      'audio': 'audio/stories/alif_story_2.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 3,
      'title': 'المشهد الثالث',
      'caption': 'حَاوَلَ الْأَسَدُ الْجَرْيَ وَرَاءَ الْأَرْنَبِ، وَلَكِنَّهُ فَشِلَ.',
      'image': 'assets/images/lessons/alif/alif_cd_story_3.png',
      'audio': 'audio/stories/alif_story_3.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 4,
      'title': 'المشهد الرابع',
      'caption': 'وَفَجْأَةً اخْتَفَى الْأَرْنَبُ. قَالَ الْأَسَدُ: أَيْنَ ذَهَبَ الْأَرْنَبُ؟',
      'image': 'assets/images/lessons/alif/alif_cd_story_4.png',
      'audio': 'audio/stories/alif_story_4.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 5,
      'title': 'المشهد الخامس',
      'caption': 'فَكِّرْ مَعَنَا: أَيْنَ اخْتَفَى الْأَرْنَبُ؟',
      'image': 'assets/images/lessons/alif/alif_cd_story_5.png',
      'audio': 'audio/stories/alif_story_5.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 6,
      'title': 'المشهد السادس: سؤال الفهم',
      'caption': 'مَنْ يَعْرِفُ مَكَانَ الْأَرْنَبِ يَضْغَطْ عَلَيْهِ!',
      'image': 'assets/images/lessons/alif/alif_cd_story_6.png',
      'audio': 'audio/stories/alif_story_6.mp3',
      'isInteractive': true,
    },
    {
      'sceneNumber': 7,
      'title': 'المشهد السابع: نشيد الحرف 🎵',
      'caption': 'أَلِفٌ أَرْنَبٌ يَجْرِي يَلْعَبُ .. أَسَدٌ يَزْأَرُ خَلْفَ الْأَرْنَبِ',
      'image': 'assets/images/lessons/alif/alif_cd_story_nasheed.png',
      'audio': 'audio/stories/alif_nasheed.mp3',
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
      debugPrint('Alif story audio error: $e');
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
    if (_currentSceneIndex == 5 && !_foundRabbit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🐰', style: TextStyle(fontSize: 22)),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'ابحث عن الأرنب المختبئ واضغط عليه أولاً يا بطل!',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                ),
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
      AudioService.instance.stop();
      widget.onPrevious();
    }
  }

  Future<void> _onRabbitTapped() async {
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
    final currentScene = _scenes[_currentSceneIndex];
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          // خلفية دافئة متطابقة مع BaaStoryStation
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFDE7),
                  Color(0xFFF1F8E9),
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
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                              const Icon(Icons.auto_stories_rounded, color: Colors.amber, size: 20),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  currentScene['title'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: isTablet ? 18 : 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // مؤشرات التقدم بين المشاهد (7 نقاط تفاعلية)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_scenes.length, (idx) {
                          final isActive = idx == _currentSceneIndex;
                          return GestureDetector(
                            onTap: () => _goToScene(idx),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: isActive ? (isTablet ? 30 : 22) : (isTablet ? 12 : 8),
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
                            final isInteractive = _scenes[index]['isInteractive'] as bool;
                            return Center(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  width: 800,
                                  height: 600,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.asset(
                                          imgAsset,
                                          width: 800,
                                          height: 600,
                                          fit: BoxFit.fill,
                                        ),
                                      ),

                                      // الأسهم المدمجة داخل صورة الأسطوانة الأصلية
                                      Positioned(
                                        left: 800 * 0.12,
                                        top: 600 * 0.84,
                                        width: 800 * 0.28,
                                        height: 600 * 0.15,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: _nextScene,
                                          child: const SizedBox.expand(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 800 * 0.60,
                                        top: 600 * 0.84,
                                        width: 800 * 0.28,
                                        height: 600 * 0.15,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: _previousScene,
                                          child: const SizedBox.expand(),
                                        ),
                                      ),

                                      // تفاعلية المشهد السادس: اكتشاف الأرنب المختبئ
                                      if (isInteractive) ...[
                                        if (!_foundRabbit)
                                          Positioned(
                                            left: 800 * 0.258 - 48,
                                            top: 600 * 0.704 - 48,
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: _onRabbitTapped,
                                              child: Container(
                                                width: 96,
                                                height: 96,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.yellow.shade600.withValues(alpha: 0.9),
                                                    width: 4,
                                                  ),
                                                  color: Colors.white.withValues(alpha: 0.14),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    '?',
                                                    style: TextStyle(
                                                      fontSize: 38,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.yellow,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                                .scale(
                                                  begin: const Offset(0.88, 0.88),
                                                  end: const Offset(1.15, 1.15),
                                                  duration: 700.ms,
                                                ),
                                          ),
                                        if (_foundRabbit)
                                          Positioned(
                                            left: 800 * 0.258 - 48,
                                            top: 600 * 0.704 - 48,
                                            child: Container(
                                              width: 96,
                                              height: 96,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.amber.withValues(alpha: 0.92),
                                                border: Border.all(color: Colors.white, width: 3.5),
                                                boxShadow: const [
                                                  BoxShadow(color: Colors.black38, blurRadius: 12, spreadRadius: 2),
                                                ],
                                              ),
                                              child: const Center(
                                                child: Text('🐰', style: TextStyle(fontSize: 50)),
                                              ),
                                            ).animate().scale(duration: 450.ms, curve: Curves.elasticOut),
                                          ),
                                        if (_foundRabbit)
                                          Positioned(
                                            top: 24,
                                            left: 80,
                                            right: 80,
                                            child: Center(
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
                                                    Text('🐰', style: TextStyle(fontSize: 34)),
                                                    SizedBox(width: 12),
                                                    Text(
                                                      'أَحْسَنْتَ! وَجَدْتَ الْأَرْنَبَ الْمُخْتَبِئَ!',
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

                // ── 3. بطاقة النص المشكول بخط Cairo كبير وواضح ──────────────
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

                // ── 4. أزرار التنقل السفلية (مطابقة لـ BaaStoryStation) ─────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 36 : 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: OutlinedButton.icon(
                          onPressed: _previousScene,
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                          label: Text(
                            _currentSceneIndex == 0 ? 'المحطة السابقة' : 'المشهد السابق',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                              horizontal: isTablet ? 24 : 14,
                              vertical: isTablet ? 14 : 10,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: _nextScene,
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                          label: Text(
                            _currentSceneIndex == _scenes.length - 1 ? 'المحطة التالية' : 'المشهد التالي',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: isTablet ? 18 : 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentSceneIndex == 5 && !_foundRabbit
                                ? Colors.grey
                                : const Color(0xFFFF9800),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 28 : 14,
                              vertical: isTablet ? 14 : 10,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

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
}

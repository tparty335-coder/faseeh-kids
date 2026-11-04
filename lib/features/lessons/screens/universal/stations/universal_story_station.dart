import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// ═══════════════════════════════════════════════════════════════════════
/// محطة قصة الحرف — عامة ومدفوعة بالبيانات (StorySpec)
/// مطابقة لتصميم محطة قصة حرف الباء (إطار مصور واضح + شريط عنوان + تنقل سلس)
/// ═══════════════════════════════════════════════════════════════════════
class UniversalStoryStation extends StatefulWidget {
  final StorySpec spec;
  final String letter;
  final Color accentColor;
  final String mascotEmoji;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalStoryStation({
    super.key,
    required this.spec,
    required this.letter,
    required this.accentColor,
    required this.mascotEmoji,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<UniversalStoryStation> createState() => _UniversalStoryStationState();
}

class _UniversalStoryStationState extends State<UniversalStoryStation> {
  final PageController _pageController = PageController();
  int _currentSceneIndex = 0;
  bool _isPlayingAudio = false;
  bool _interactionCompleted = false;
  final Set<String> _foundTargets = {};
  String? _wrongFeedbackLabel;
  late final ConfettiController _confettiController;

  List<StoryScene> get _scenes => widget.spec.scenes;

  static const List<String> _sceneTitles = [
    'المشهد الأول',
    'المشهد الثاني',
    'المشهد الثالث',
    'المشهد الرابع',
    'المشهد الخامس',
    'المشهد السادس',
    'نشيد الحرف 🎵',
    'المشهد الثامن',
  ];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _playSceneAudio(0));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playSceneAudio(int sceneIndex) async {
    if (!mounted || sceneIndex >= _scenes.length) return;
    setState(() {
      _isPlayingAudio = true;
      _interactionCompleted = false;
    });
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(_scenes[sceneIndex].audioPath);
      final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
      if (done != null) {
        await done.first.timeout(const Duration(seconds: 60), onTimeout: () {});
      }
    } catch (_) {}
    if (mounted) setState(() => _isPlayingAudio = false);
  }

  void _goToScene(int index) {
    if (index < 0 || index >= _scenes.length) return;
    setState(() {
      _currentSceneIndex = index;
      _interactionCompleted = false;
      _foundTargets.clear();
      _wrongFeedbackLabel = null;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
    _playSceneAudio(index);
  }

  Future<void> _onTargetTapped(
      StoryTargetItem target, WordFindStoryInteraction wf) async {
    if (target.isCorrect) {
      if (_foundTargets.contains(target.label)) return;
      setState(() {
        _foundTargets.add(target.label);
        _wrongFeedbackLabel = null;
      });
      try {
        await AudioService.instance.stop();
        if (target.wordAudioPath != null) {
          await AudioService.instance.playAsset(target.wordAudioPath!);
          final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
          if (done != null) {
            await done.first.timeout(const Duration(milliseconds: 2000), onTimeout: () {});
          } else {
            await Future.delayed(const Duration(milliseconds: 1000));
          }
        } else {
          await AudioService.instance.playAsset(wf.correctAudioPath);
        }
      } catch (_) {}

      final correctCount = wf.targets.where((t) => t.isCorrect).length;
      if (_foundTargets.length >= correctCount) {
        setState(() => _interactionCompleted = true);
        _confettiController.play();
        try {
          await Future.delayed(const Duration(milliseconds: 400));
          await AudioService.instance.playAsset(wf.correctAudioPath);
        } catch (_) {}
      }
    } else {
      setState(() => _wrongFeedbackLabel = target.label);
      try {
        await AudioService.instance.stop();
        await AudioService.instance.playAsset(wf.wrongAudioPath);
      } catch (_) {}
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted && _wrongFeedbackLabel == target.label) {
          setState(() => _wrongFeedbackLabel = null);
        }
      });
    }
  }

  Widget _buildWordFindOverlay(WordFindStoryInteraction wf) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxW = constraints.maxWidth;
        final boxH = constraints.maxHeight;
        const imgAspect = 4.0 / 3.0;
        double dW, dH, ox, oy;
        if (boxW / boxH < imgAspect) {
          dW = boxW;
          dH = boxW / imgAspect;
          ox = 0;
          oy = (boxH - dH) / 2;
        } else {
          dH = boxH;
          dW = boxH * imgAspect;
          ox = (boxW - dW) / 2;
          oy = 0;
        }

        return Stack(
          children: [
            for (final target in wf.targets)
              Positioned(
                left: ox + target.left * dW,
                top: oy + target.top * dH,
                width: (target.right - target.left) * dW,
                height: (target.bottom - target.top) * dH,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onTargetTapped(target, wf),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _foundTargets.contains(target.label)
                            ? Colors.green
                            : (_wrongFeedbackLabel == target.label
                                ? Colors.red
                                : Colors.transparent),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      color: _foundTargets.contains(target.label)
                          ? Colors.green.withValues(alpha: 0.25)
                          : (_wrongFeedbackLabel == target.label
                              ? Colors.red.withValues(alpha: 0.25)
                              : Colors.transparent),
                    ),
                    child: _foundTargets.contains(target.label)
                        ? const Center(
                            child: Icon(Icons.check_circle_rounded,
                                color: Colors.green, size: 36),
                          )
                        : null,
                  ),
                ),
              ),
            if (wf.instructionText != null && !_interactionCompleted)
              Positioned(
                top: oy + 8,
                left: ox + 12,
                right: ox + 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.touch_app_rounded,
                          color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          wf.instructionText!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _nextScene() {
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

  Future<void> _onHotspotTapped(HotspotInteraction hotspot) async {
    if (_interactionCompleted) return;
    setState(() => _interactionCompleted = true);
    _confettiController.play();
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(hotspot.revealAudioPath);
    } catch (_) {}
  }

  Widget _buildHotspotOverlay(HotspotInteraction hotspot, Size screenSize) {
    final left = hotspot.left * screenSize.width;
    final top = hotspot.top * screenSize.height;
    final width = (hotspot.right - hotspot.left) * screenSize.width;
    final height = (hotspot.bottom - hotspot.top) * screenSize.height;

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () => _onHotspotTapped(hotspot),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            border: _interactionCompleted
                ? null
                : Border.all(
                    color: Colors.yellow.withValues(alpha: 0.7), width: 3),
            borderRadius: BorderRadius.circular(12),
            color: _interactionCompleted
                ? Colors.green.withValues(alpha: 0.25)
                : Colors.yellow.withValues(alpha: 0.08),
          ),
          child: _interactionCompleted
              ? const Center(
                  child: Text('✅', style: TextStyle(fontSize: 36)))
              : Center(
                  child: Text(
                    hotspot.hintText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceOverlay(
      MultipleChoiceInteraction mc, Size screenSize) {
    return Positioned(
      bottom: 80,
      left: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.accentColor, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mc.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: widget.accentColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(mc.choiceImagePaths.length, (i) {
                return GestureDetector(
                  onTap: () async {
                    if (_interactionCompleted) return;
                    final isCorrect = mc.correctAnswers[i];
                    setState(() => _interactionCompleted = isCorrect);
                    if (isCorrect) {
                      _confettiController.play();
                      await AudioService.instance
                          .playAsset(mc.correctAudioPath);
                    } else {
                      await AudioService.instance.playAsset(mc.wrongAudioPath);
                    }
                  },
                  child: Container(
                    width: screenSize.width * 0.25,
                    height: screenSize.width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: widget.accentColor.withValues(alpha: 0.4),
                          width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        mc.choiceImagePaths[i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Text('${i + 1}',
                                style: const TextStyle(fontSize: 28)),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scene = _scenes[_currentSceneIndex];
    final screenSize = MediaQuery.of(context).size;
    final isLastScene = _currentSceneIndex == _scenes.length - 1;
    final sceneTitle = scene.isNasheed
        ? 'نشيد حرف (${widget.letter}) 🎵'
        : (_currentSceneIndex < _sceneTitles.length
            ? '${_sceneTitles[_currentSceneIndex]} — قِصَّةُ حَرْفِ (${widget.letter})'
            : 'مَشْهَدُ (${_currentSceneIndex + 1})');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          // ── خلفية طبيعية هادئة ──────────────────────────────────────────
          Positioned.fill(
            child: Container(
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
          ),

          Column(
            children: [
              // ── 1. الشريط العلوي للمشهد ─────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // شارة عنوان المشهد
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                            const Icon(Icons.auto_stories_rounded, color: Colors.amber, size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                sceneTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // نقاط المشاهد
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(_scenes.length, (i) {
                        final isActive = i == _currentSceneIndex;
                        return GestureDetector(
                          onTap: () => _goToScene(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: isActive ? 22 : 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? widget.accentColor
                                  : Colors.brown.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(width: 8),

                    // زر إعادة الصوت
                    GestureDetector(
                      onTap: () => _playSceneAudio(_currentSceneIndex),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _isPlayingAudio ? Colors.orange.shade700 : widget.accentColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isPlayingAudio
                                  ? Icons.volume_up_rounded
                                  : Icons.replay_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${_currentSceneIndex + 1}/${_scenes.length}',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── 2. إطار المشهد المصور ────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF795548), width: 4),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _scenes.length,
                        itemBuilder: (_, i) {
                          final sc = _scenes[i];
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                sc.imagePath,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Text(
                                    widget.mascotEmoji,
                                    style: const TextStyle(fontSize: 72),
                                  ),
                                ),
                              ),
                              if (sc.interaction is WordFindStoryInteraction)
                                _buildWordFindOverlay(sc.interaction as WordFindStoryInteraction),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // ── 3. شريط أزرار التنقل السفلي ──────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _previousScene,
                        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                        label: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _currentSceneIndex == 0 ? 'الأهداف' : 'المشهد السابق',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.accentColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _nextScene,
                        icon: Icon(
                          isLastScene
                              ? Icons.check_circle_rounded
                              : Icons.arrow_back_rounded,
                          size: 20,
                        ),
                        label: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            isLastScene
                                ? 'إِنْهَاءُ الْقِصَّةِ 🎉'
                                : 'الْمَشْهَدُ التَّالِي',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLastScene
                              ? AppColors.oasisGreen
                              : widget.accentColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── التفاعل (hotspot أو اختيار متعدد) ─────────────────────────
          if (scene.interaction is HotspotInteraction)
            _buildHotspotOverlay(
                scene.interaction as HotspotInteraction, screenSize),
          if (scene.interaction is MultipleChoiceInteraction)
            _buildMultipleChoiceOverlay(
                scene.interaction as MultipleChoiceInteraction, screenSize),

          // ── كونفيتي للتفاعل ───────────────────────────────────────────
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green, Colors.blue, Colors.yellow, Colors.orange
              ],
            ),
          ),
        ],
      ),
    );
  }
}

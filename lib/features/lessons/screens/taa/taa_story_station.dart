import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// â•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گ
/// ظ…ط­ط·ط© ظ‚طµط© ط­ط±ظپ ط§ظ„ط¨ط§ط، â€” ط§ظ„ظ…ط¹طھظ…ط¯ط© ط¨ط¯ظ‚ط© ط§ظ„طµظپط±-ط®ط·ط£ ظ…ظ† ط£ط³ط·ظˆط§ظ†ط© ط§ظ„ظˆط²ط§ط±ط© ط§ظ„ط£طµظ„ظٹط©
/// 6 ظ…ط´ط§ظ‡ط¯ ظ…طھط³ظ„ط³ظ„ط© + ط³ط¤ط§ظ„ طھظپط§ط¹ظ„ظٹ ط°ظƒظٹ ظپظٹ ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط±ط§ط¨ط¹ + ظ†ط´ظٹط¯ ط§ظ„ط­ط±ظپ ط§ظ„ط£طµظ„ظٹ
/// â•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گâ•گ

class TaaStoryStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const TaaStoryStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<TaaStoryStation> createState() => _TaaStoryStationState();
}

class _TaaStoryStationState extends State<TaaStoryStation> {
  final PageController _pageController = PageController();
  int _currentSceneIndex = 0;
  bool _isPlayingAudio = false;

  // ط­ط§ظ„ط© ط§ظ„ط³ط¤ط§ظ„ ط§ظ„طھظپط§ط¹ظ„ظٹ ظپظٹ ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط±ط§ط¨ط¹
  bool _scene4Answered = false;
  String? _selectedOption; // 'milk', 'clover', 'egg'
  late final ConfettiController _confettiController;

  static const List<Map<String, dynamic>> _scenes = [
    {
      'sceneNumber': 1,
      'title': 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط£ظˆظ„',
      'caption': 'ط§ظژظ„ظ’ظپظژظ„ظژظ‘ط§ط­ظڈ ط±ظژط¬ظڈظ„ظŒ ظ†ظژط´ظگظٹط·ظŒ ظٹظژط°ظ’ظ‡ظژط¨ظڈ ط¥ظگظ„ظژظ‰ ط§ظژظ„ظ’ط­ظژظ‚ظ’ظ„ظگ ظ…ظڈط¨ظژظƒظگظ‘ط±ظ‹ط§.',
      'image': 'assets/images/lessons/Taa/taa_cd_story_1.png',
      'audio': 'audio/stories/taa_story_1.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 2,
      'title': 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط«ط§ظ†ظٹ',
      'caption': 'ظˆظژظٹظژط£ظ’ط®ظڈط°ظڈ ظ…ظژط¹ظژظ‡ظڈ ط¨ظژظ‚ظژط±ظژط©ظ‹ ظˆظژظƒظژظ„ظ’ط¨ظژ ط­ظگط±ظژط§ط³ظژط©ظچ.',
      'image': 'assets/images/lessons/Taa/taa_cd_story_2.png',
      'audio': 'audio/stories/taa_story_2.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 3,
      'title': 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط«ط§ظ„ط«',
      'caption': 'ظپظگظٹ ط§ظژظ„ظ’ط­ظژظ‚ظ’ظ„ظگ ظٹظژط¹ظ’ظ…ظژظ„ظڈ ط§ظژظ„ظ’ظپظژظ„ظژظ‘ط§ط­ظڈ ط¨ظگظ†ظژط´ظژط§ط·ظچطŒ ظˆظژطھظژط£ظ’ظƒظڈظ„ظڈ ط§ظژظ„ظ’ط¨ظژظ‚ظژط±ظژط©ظڈ ط§ظژظ„ظ’ط¨ظگط±ظ’ط³ظگظٹظ…ظژطŒ ظˆظژط§ظژظ„ظ’ط¨ظژط·ظڈظ‘ ظٹظژط³ظ’ط¨ظژط­ظڈ ظپظگظٹ ط§ظژظ„ظ’ظ…ظژط§ط،ظگ.',
      'image': 'assets/images/lessons/Taa/taa_cd_story_3.png',
      'audio': 'audio/stories/taa_story_3.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 4,
      'title': 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط±ط§ط¨ط¹: ط³ط¤ط§ظ„ ط§ظ„ظپظ‡ظ…',
      'caption': 'ظ…ظژط§ط°ظژط§ ظ†ظژط£ظ’ط®ظڈط°ظڈ ظ…ظگظ†ظژ ط§ظژظ„ظ’ط¨ظژظ‚ظژط±ظژط©ظگطں',
      'image': 'assets/images/lessons/Taa/taa_cd_story_4.png',
      'audio': 'audio/stories/taa_story_4.mp3',
      'isInteractive': true,
    },
    {
      'sceneNumber': 5,
      'title': 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط®ط§ظ…ط³',
      'caption': 'ظˆظژظپظگظٹ ط§ظژظ„ظ’ظ…ظژط³ظژط§ط،ظگ ظٹظژط¹ظڈظˆط¯ظڈ ط§ظژظ„ظ’ظپظژظ„ظژظ‘ط§ط­ظڈ ط¥ظگظ„ظژظ‰ ط¨ظژظٹظ’طھظگظ‡ظگ ظ…ظژط³ظ’ط±ظڈظˆط±ظ‹ط§.',
      'image': 'assets/images/lessons/Taa/taa_cd_story_5.png',
      'audio': 'audio/stories/taa_story_5.mp3',
      'isInteractive': false,
    },
    {
      'sceneNumber': 6,
      'title': 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط³ط§ط¯ط³: ظ†ط´ظٹط¯ ط§ظ„ط­ط±ظپ ًںژµ',
      'caption': 'ط¨ظژط§ط،ظŒ ط¨ظژط·ظژظ‘ط©ظ’ .. ظˆظژط¶ظژط¹ظژطھظ’ ط¨ظژظٹظ’ط¶ظژط©ظ’\nط®ظژظ„ظ’ظپظژ ط§ظ„ظ’ط¨ظژظ‚ظژط±ظژط©ظ’ .. ط¬ظژظ†ظ’ط¨ظژ ط§ظ„ط´ظژظ‘ط¬ظژط±ظژط©ظ’',
      'image': 'assets/images/lessons/Taa/taa_cd_story_6.png',
      'audio': 'audio/stories/taa_story_6.mp3',
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
      debugPrint('Taa story audio error: $e');
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
      // ط¥ط´ط¹ط§ط± ظ„ط·ظٹظپ ط¹ظ†ط¯ ظ…ط­ط§ظˆظ„ط© طھط®ط·ظٹ ط§ظ„ط³ط¤ط§ظ„
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ًں¥›', style: TextStyle(fontSize: 22)),
              SizedBox(width: 8),
              Text(
                'ط§ط®طھط± ط§ظ„ط¥ط¬ط§ط¨ط© ط§ظ„طµط­ظٹط­ط© ط£ظˆظ„ط§ظ‹ ظٹط§ ط¨ط·ظ„: ظ…ط§ط°ط§ ظ†ط£ط®ط° ظ…ظ† ط§ظ„ط¨ظ‚ط±ط©طں',
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

  // â”€â”€ ظ…ظ†ط·ظ‚ ط§ظ„ط³ط¤ط§ظ„ ط§ظ„طھظپط§ط¹ظ„ظٹ ظ„ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط±ط§ط¨ط¹ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Future<void> _handleOptionSelected(String option) async {
    setState(() => _selectedOption = option);

    if (option == 'milk') {
      // ط¥ط¬ط§ط¨ط© طµط­ظٹط­ط©!
      setState(() => _scene4Answered = true);
      _confettiController.play();
      await AudioService.instance.stop();
      // طµظˆطھ ط§ظ„ط¥ط¬ط§ط¨ط© ط§ظ„طµط­ظٹط­ط© ط§ظ„ط£طµظ„ظٹ ط§ظ„ظ…ظپط±ط؛ ظ…ظ† ط§ظ„ط£ط³ط·ظˆط§ظ†ط©: "ط£ط­ط³ظ†طھ ظ†ط£ط®ط° ظ…ظ† ط§ظ„ط¨ظ‚ط±ط© ط§ظ„ظ„ط¨ظ† ظˆظ†طµظ†ط¹ ظ…ظ†ظ‡ ط§ظ„ط¬ط¨ظ† ظˆط§ظ„ط²ط¨ط¯"
      await AudioService.instance.playAsset('audio/stories/taa_story_4_correct.mp3');
    } else {
      // ط¥ط¬ط§ط¨ط© ط®ط§ط·ط¦ط© â€” طµظˆطھ ط§ظ„ط£ط³ط·ظˆط§ظ†ط© ط§ظ„ط£طµظ„ظٹ: "ط­ط§ظˆظ„ ظ…ط±ط© ط£ط®ط±ظ‰"
      await AudioService.instance.stop();
      await AudioService.instance.playAsset('audio/stories/taa_story_4_wrong.mp3');
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
          // ط®ظ„ظپظٹط© ط¯ط§ظپط¦ط© ظ„ط·ظٹظپط© ظ…طھظ†ط§ط³ظ‚ط© ظ…ط¹ ط·ط¨ظٹط¹ط© ط§ظ„ط±ظٹظپ ط§ظ„ظ…طµط±ظٹ
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFDE7), // ط£طµظپط± ط´ظ…ط³ ظ‡ط§ط¯ط¦
                  Color(0xFFF1F8E9), // ط£ط®ط¶ط± ظ…ط±ظˆط¬ ظ†ط§ط¹ظ…
                  Color(0xFFE8F5E9),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // â”€â”€ 1. ط§ظ„ط´ط±ظٹط· ط§ظ„ط¹ظ„ظˆظٹ ظ„ظ…ط´ط§ظ‡ط¯ ط§ظ„ظ‚طµط© â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ط´ط§ط±ط© ط±ظ‚ظ… ظˆط¹ظ†ظˆط§ظ† ط§ظ„ظ…ط´ظ‡ط¯
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

                      // ظ…ط¤ط´ط±ط§طھ ط§ظ„طھظ‚ط¯ظ… ط¨ظٹظ† ط§ظ„ظ…ط´ط§ظ‡ط¯ (6 ظ†ظ‚ط§ط· طھظپط§ط¹ظ„ظٹط©)
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

                      // ط²ط± ط¥ط¹ط§ط¯ط© ط§ظ„ط§ط³طھظ…ط§ط¹ ط§ظ„طµظˆطھظٹ
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
                          tooltip: 'ط§ط³طھظ…ط¹ ظ„ظ„طµظˆطھ',
                          onPressed: () => _playSceneAudio(_currentSceneIndex),
                        ),
                      ),
                    ],
                  ),
                ),

                // â”€â”€ 2. ط¥ط·ط§ط± ظ„ظˆط­ط© ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط¨طµط±ظٹ ط§ظ„ط£طµظ„ظٹ ط§ظ„ظ…ط³طھط®ظ„طµ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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
                                      // ط§ظ„طµظˆط±ط© ط§ظ„ط£طµظ„ظٹط© ظ„ظ„ظ…ط´ظ‡ط¯ ط¨ط£ط¨ط¹ط§ط¯ظ‡ط§ ط§ظ„ظƒط§ظ…ظ„ط© 1024x398
                                      Positioned.fill(
                                        child: Image.asset(
                                          imgAsset,
                                          width: 1024,
                                          height: 398,
                                          fit: BoxFit.fill,
                                        ),
                                      ),

                                      // طھظپط§ط¹ظ„ظٹط© ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط±ط§ط¨ط¹: ظ…ظ†ط§ط·ظ‚ ط§ظ„ظ„ظ…ط³ ط§ظ„ظ…ط·ط¨ظ‚ط© ط¨ط§ظ„ظ…ظ„ظٹظ…طھط± ظپظˆظ‚ ط§ظ„ط¯ظˆط§ط¦ط±
                                      if (index == 3) ...[
                                        // 1. ظ„ط¨ظ† (طµط­ظٹط­) - ط§ظ„ط¥ط­ط¯ط§ط«ظٹط§طھ ط§ظ„ط¯ظ‚ظٹظ‚ط© ط¨ط§ظ„ط¨ظƒط³ظ„: x:15, y:30, w:160, h:105
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

                                        // 2. ط¨ط±ط³ظٹظ… - ط§ظ„ط¥ط­ط¯ط§ط«ظٹط§طھ ط§ظ„ط¯ظ‚ظٹظ‚ط© ط¨ط§ظ„ط¨ظƒط³ظ„: x:170, y:155, w:160, h:105
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

                                        // 3. ط¨ظٹط¶ - ط§ظ„ط¥ط­ط¯ط§ط«ظٹط§طھ ط§ظ„ط¯ظ‚ظٹظ‚ط© ط¨ط§ظ„ط¨ظƒط³ظ„: x:15, y:255, w:160, h:105
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

                                        // ط´ط§ط±ط© ط§ظ„طھظ‡ظ†ط¦ط© ط§ظ„ظ…ط¨ظ‡ط¬ط© ط¹ظ†ط¯ ط§ظ„ط¥ط¬ط§ط¨ط© ط§ظ„طµط­ظٹط­ط©
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
                                                  Text('ًں¥›', style: TextStyle(fontSize: 34)),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    'ظ…ظڈظ…ظ’طھظژط§ط²ظŒ! ظ†ظژط£ظ’ط®ظڈط°ظڈ ظ…ظگظ†ظژ ط§ظ„ظ’ط¨ظژظ‚ظژط±ظژط©ظگ ط§ظ„ظ„ظژظ‘ط¨ظژظ†ظژ!',
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

                // â”€â”€ 3. ط§ظ„ظ…ظ†ط·ظ‚ط© ط§ظ„طھظپط§ط¹ظ„ظٹط© (ط£ط²ط±ط§ط± ط§ظ„ط³ط¤ط§ظ„ ظپظٹ ط§ظ„ظ…ط´ظ‡ط¯ 4 ط£ظˆ ط¨ط·ط§ظ‚ط© ط§ظ„ظ†طµ) â”€â”€
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
                            'ظ…ظژط§ط°ظژط§ ظ†ظژط£ظ’ط®ظڈط°ظڈ ظ…ظگظ†ظژ ط§ظ„ظ’ط¨ظژظ‚ظژط±ظژط©ظگطں',
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
                                label: 'ظ„ظژط¨ظژظ†ظŒ',
                                emoji: 'ًں¥›',
                                isCorrect: true,
                                isSelected: _selectedOption == 'milk',
                                isAnswered: _scene4Answered,
                                isTablet: isTablet,
                                onTap: () => _handleOptionSelected('milk'),
                              ),
                              _buildLargeChoiceButton(
                                label: 'ط¨ظگط±ظ’ط³ظگظٹظ…ظŒ',
                                emoji: 'ًںŒ؟',
                                isCorrect: false,
                                isSelected: _selectedOption == 'clover',
                                isAnswered: _scene4Answered,
                                isTablet: isTablet,
                                onTap: () => _handleOptionSelected('clover'),
                              ),
                              _buildLargeChoiceButton(
                                label: 'ط¨ظژظٹظ’ط¶ظŒ',
                                emoji: 'ًں¥ڑ',
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
                  // ط¨ط·ط§ظ‚ط© ط§ظ„ظ†طµ ط§ظ„ظ…ط´ظƒظˆظ„ ط¨ط®ط· Cairo ظƒط¨ظٹط± ظˆظˆط§ط¶ط­
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

                // â”€â”€ 4. ط£ط²ط±ط§ط± ط§ظ„طھظ†ظ‚ظ„ ط§ظ„ط³ظپظ„ظٹط© â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 36 : 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ط²ط± ط§ظ„ط³ط§ط¨ظ‚
                      OutlinedButton.icon(
                        onPressed: _previousScene,
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                        label: Text(
                          _currentSceneIndex == 0 ? 'ط§ظ„ظ…ط­ط·ط© ط§ظ„ط³ط§ط¨ظ‚ط©' : 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„ط³ط§ط¨ظ‚',
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

                      // ط²ط± ط§ظ„طھط§ظ„ظٹ
                      ElevatedButton.icon(
                        onPressed: _nextScene,
                        icon: Text(
                          _currentSceneIndex == _scenes.length - 1 ? 'ط§ظ„ظ…ط­ط·ط© ط§ظ„طھط§ظ„ظٹط©' : 'ط§ظ„ظ…ط´ظ‡ط¯ ط§ظ„طھط§ظ„ظٹ',
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

          // ظƒظˆظ†ظپظٹطھظٹ ط§ظ„ط§ط­طھظپط§ظ„ ظپظٹ ط£ط¹ظ„ظ‰ ط§ظ„ط´ط§ط´ط©
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



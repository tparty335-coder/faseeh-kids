import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── لعبة السيرك لحرف الثاء ──────────────────────────────────────────────────
// مطابقة تماماً لشاشات الأسطوانة الأصلية قبل وبعد الإجابة

const double _imgW = 1024;

class _ImageZone {
  final String label;
  final bool hasThaa;
  final double px, py;
  final String? wordAudio;
  const _ImageZone({
    required this.label,
    required this.hasThaa,
    required this.px,
    required this.py,
    this.wordAudio,
  });
}

class _Round {
  final String imagePath;
  final double imgH;
  final String afterImagePath;
  final double afterImgH;
  final String praiseAudio;
  final String correctWord;
  final List<_ImageZone> zones;
  const _Round({
    required this.imagePath,
    required this.imgH,
    required this.afterImagePath,
    required this.afterImgH,
    required this.praiseAudio,
    required this.correctWord,
    required this.zones,
  });
}

const List<_Round> _rounds = [
  // الجولة 1: حِمَار (أعلى) ، دَجَاجَة (وسط) ، ثَعْلَب (أسفل) ← ثَعْلَب ✅
  _Round(
    imagePath: 'assets/images/games/circus/thaa_circus_round_1.png',
    imgH: 517,
    afterImagePath: 'assets/images/games/circus/thaa_circus_round_1_after.png',
    afterImgH: 500,
    praiseAudio: 'audio/games/beehive/4_momt.mp3',
    correctWord: 'ثَعْلَبُ',
    zones: [
      _ImageZone(label: 'حِمَار',  hasThaa: false, px: 144.5, py: 109.5),
      _ImageZone(label: 'دَجَاجَة', hasThaa: false, px: 339.5, py: 249.5),
      _ImageZone(label: 'ثَعْلَب',  hasThaa: true,  px: 142.0, py: 395.5,
          wordAudio: 'audio/lessons/thaa/sounds/word_thalab.mp3'),
    ],
  ),
  // الجولة 2: أَسَد (أعلى) ، ثِيَاب (وسط) ، بُرْج (أسفل) ← ثِيَاب ✅
  _Round(
    imagePath: 'assets/images/games/circus/thaa_circus_round_2.png',
    imgH: 523,
    afterImagePath: 'assets/images/games/circus/thaa_circus_round_2_after.png',
    afterImgH: 516,
    praiseAudio: 'audio/games/beehive/3_raa.mp3',
    correctWord: 'ثِيَابُ',
    zones: [
      _ImageZone(label: 'أَسَد',   hasThaa: false, px: 142.0, py: 109.5),
      _ImageZone(label: 'ثِيَاب',  hasThaa: true,  px: 337.0, py: 249.5,
          wordAudio: 'audio/lessons/thaa/sounds/word_thiab.mp3'),
      _ImageZone(label: 'بُرْج',   hasThaa: false, px: 142.0, py: 398.5),
    ],
  ),
  // الجولة 3: ثِمَار (أعلى) ، زَهْرَة (وسط) ، قَلَم (أسفل) ← ثِمَار ✅
  _Round(
    imagePath: 'assets/images/games/circus/thaa_circus_round_3.png',
    imgH: 532,
    afterImagePath: 'assets/images/games/circus/thaa_circus_round_3_after.png',
    afterImgH: 516,
    praiseAudio: 'audio/games/beehive/2_sah.mp3',
    correctWord: 'ثِمَارٌ',
    zones: [
      _ImageZone(label: 'ثِمَار',   hasThaa: true,  px: 142.0, py: 110.5,
          wordAudio: 'audio/lessons/thaa/sounds/word_thimar.mp3'),
      _ImageZone(label: 'زَهْرَة',  hasThaa: false, px: 338.5, py: 249.5),
      _ImageZone(label: 'قَلَم',   hasThaa: false, px: 142.0, py: 401.5),
    ],
  ),
];

class ThaaCircusGame extends ConsumerStatefulWidget {
  final VoidCallback? onBack;
  const ThaaCircusGame({super.key, this.onBack});

  @override
  ConsumerState<ThaaCircusGame> createState() => _ThaaCircusGameState();
}

class _ThaaCircusGameState extends ConsumerState<ThaaCircusGame> {
  late ConfettiController _confetti;
  int _round = 0, _score = 0, _wrongAttempts = 0, _token = 0;
  int? _tapped;
  bool _roundDone = false, _gameOver = false, _showCorrectAnswer = false;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    final t = _token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 450), () {
        if (mounted && t == _token) _playInstruction();
      });
    });
  }

  @override
  void dispose() {
    _token++;
    AudioService.instance.stop();
    _confetti.dispose();
    super.dispose();
  }

  Future<void> _say(
    String path, {
    AudioChannel channel = AudioChannel.voice,
    Duration? explicitDuration,
    Duration pauseAfter = const Duration(milliseconds: 300),
  }) async {
    try {
      await AudioService.instance.playAssetAndWait(
        path,
        channel: channel,
        explicitDuration: explicitDuration,
        pauseAfter: pauseAfter,
      );
    } catch (_) {}
  }

  Future<void> _playInstruction() async {
    if (!mounted || _gameOver) return;
    ++_token;
    // صوت التعليمات الأصلي من الأسطوانة لحرف الثاء: "اضغط على الصورة التي اسمها به حرف الثاء"
    await _say('assets/audio/games/circus/thaa_circus_question.mp3', pauseAfter: const Duration(milliseconds: 400));
  }

  Future<void> _playWrong() => _say('audio/games/circus/4_hawe.mp3', pauseAfter: const Duration(milliseconds: 300));

  Future<void> _onTap(int idx) async {
    if (_roundDone || _showCorrectAnswer || _isBusy) return;
    HapticFeedback.lightImpact();
    final t = ++_token;
    _isBusy = true;
    try {
      final rd = _rounds[_round];
      final zone = rd.zones[idx];

      if (zone.hasThaa) {
        setState(() {
          _tapped = idx;
          _roundDone = true;
          _score++;
        });
        _confetti.play();

        // 1. صوت التشجيع الكامل دون بتر مع مهلة تنفس
        await _say(rd.praiseAudio, pauseAfter: const Duration(milliseconds: 400));
        if (!mounted || t != _token) return;

        // 2. سماع اسم الكلمة كاملاً بعد التشجيع (ثَعْلَب / ثِيَاب / ثِمَار)
        if (zone.wordAudio != null) {
          await _say(zone.wordAudio!, pauseAfter: const Duration(milliseconds: 700));
          if (!mounted || t != _token) return;
        }

        await Future.delayed(const Duration(milliseconds: 1500));
        if (!mounted || t != _token) return;

        _advance();
      } else {
        setState(() {
          _tapped = idx;
          _wrongAttempts++;
        });
        await _playWrong();
        if (!mounted || t != _token) return;

        if (_wrongAttempts >= 2) {
          setState(() {
            _showCorrectAnswer = true;
          });

          // تشغيل صوت الكلمة الصحيحة كاملاً عند إظهار الحل دون تداخل
          final correctZone = rd.zones.firstWhere((z) => z.hasThaa);
          if (correctZone.wordAudio != null) {
            await _say(correctZone.wordAudio!, pauseAfter: const Duration(milliseconds: 800));
            if (!mounted || t != _token) return;
          }

          await Future.delayed(const Duration(milliseconds: 1500));
          if (!mounted || t != _token) return;

          _advance();
        } else {
          setState(() {
            _tapped = null;
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }

  void _advance() {
    final t = ++_token;
    _isBusy = false;
    AudioService.instance.stop();
    if (_round + 1 >= _rounds.length) {
      setState(() => _gameOver = true);
      if (_score >= _rounds.length / 2) _confetti.play();
      try {
        AudioService.instance.playAsset(
          'audio/games/fishing/ahsnt.mp3',
          channel: AudioChannel.voice,
        );
      } catch (_) {}
    } else {
      setState(() {
        _round++;
        _tapped = null;
        _roundDone = false;
        _wrongAttempts = 0;
        _showCorrectAnswer = false;
      });
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted && t == _token) _playInstruction();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _gameOverScreen();
    return Column(
      children: [
        Expanded(child: _buildGameScene()),
        _buildBottomNavBar(context),
      ],
    );
  }

  Widget _buildGameScene() {
    final rd = _rounds[_round];
    final isAnswered = _roundDone || _showCorrectAnswer;
    final activeImgPath = isAnswered ? rd.afterImagePath : rd.imagePath;
    final activeImgH = isAnswered ? rd.afterImgH : rd.imgH;

    return Stack(
      children: [
        LayoutBuilder(
          builder: (ctx, c) {
            final sw = c.maxWidth, sh = c.maxHeight;
            final ia = _imgW / activeImgH, sa = sw / sh;
            double dW, dH, ox, oy;
            if (sa < ia) {
              dW = sw;
              dH = sw / ia;
              ox = 0;
              oy = (sh - dH) / 2;
            } else {
              dH = sh;
              dW = sh * ia;
              ox = (sw - dW) / 2;
              oy = 0;
            }

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(activeImgPath, fit: BoxFit.contain),
                ),
                // مناطق النقر على الفقاعات الثلاث
                ...List.generate(rd.zones.length, (i) {
                  final z = rd.zones[i];
                  final cx = ox + (z.px / _imgW) * dW;
                  final cy = oy + (z.py / activeImgH) * dH;
                  const r = 105.0;
                  final rScaled = r * (dW / _imgW);

                  Color fill = Colors.transparent;
                  Color ring = Colors.transparent;
                  Widget child = const SizedBox.shrink();

                  if (!isAnswered && _tapped == i && !z.hasThaa) {
                    fill = Colors.red.withValues(alpha: 0.30);
                    ring = Colors.redAccent;
                    child = const Text('❌', style: TextStyle(fontSize: 32));
                  }

                  return Positioned(
                    left: cx - rScaled,
                    top: cy - rScaled,
                    width: rScaled * 2,
                    height: rScaled * 2,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onTap(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fill,
                          border: ring == Colors.transparent
                              ? null
                              : Border.all(color: ring, width: 3.5),
                        ),
                        child: Center(child: child),
                      ),
                    ),
                  );
                }),
                Positioned(top: 10, left: 0, right: 0, child: _topBar()),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 25,
            gravity: 0.4,
            colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navBtn(
            'السابق',
            Icons.arrow_forward_rounded,
            true,
            () {
              HapticFeedback.lightImpact();
              if (_round == 0) {
                _token++;
                AudioService.instance.stop();
                if (widget.onBack != null) {
                  widget.onBack!();
                } else {
                  Navigator.of(context).pop();
                }
                return;
              }
              final t = ++_token;
              AudioService.instance.stop();
              setState(() {
                _round--;
                _tapped = null;
                _roundDone = false;
                _wrongAttempts = 0;
                _showCorrectAnswer = false;
                _isBusy = false;
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted && t == _token) _playInstruction();
              });
            },
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _token++;
              AudioService.instance.stop();
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
              ),
              child: const Icon(Icons.home_rounded, color: Colors.white, size: 26),
            ),
          ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms),
          _navBtn(
            'التالي',
            Icons.arrow_back_rounded,
            true,
            () {
              HapticFeedback.lightImpact();
              _advance();
            },
          ),
        ],
      ),
    );
  }

  Widget _navBtn(String label, IconData icon, bool enabled, VoidCallback onTap) {
    final isNext = label == 'التالي';
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE53935),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 6, offset: const Offset(0, 3)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isNext) Icon(icon, color: Colors.white, size: 18),
              if (isNext) const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (!isNext) const SizedBox(width: 6),
              if (!isNext) Icon(icon, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms);
  }

  Widget _topBar() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _chip('⭐ $_score'),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _playInstruction,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
              child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 10),
          _chip('${_round + 1} / ${_rounds.length}'),
        ],
      );

  Widget _chip(String t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          t,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _gameOverScreen() => Stack(
        children: [
          Positioned.fill(child: Image.asset(_rounds.last.imagePath, fit: BoxFit.contain)),
          Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.65))),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 50,
              gravity: 0.3,
              colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_score == _rounds.length ? '🏆' : '🎯', style: const TextStyle(fontSize: 90))
                    .animate()
                    .scale(begin: const Offset(0, 0), curve: Curves.elasticOut, duration: 800.ms),
                const SizedBox(height: 20),
                Text(
                  _score == _rounds.length
                      ? 'مُمْتَازٌ! أَجَبْتَ عَلَى كُلِّ الأَسْئِلَةِ!'
                      : 'أَحْسَنْتَ! إِجَابَتُكَ: $_score / ${_rounds.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                  ),
                ).animate(delay: 400.ms).fadeIn(),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    final t = ++_token;
                    AudioService.instance.stop();
                    setState(() {
                      _round = 0;
                      _score = 0;
                      _gameOver = false;
                      _tapped = null;
                      _roundDone = false;
                      _wrongAttempts = 0;
                      _showCorrectAnswer = false;
                    });
                    Future.delayed(const Duration(milliseconds: 400), () {
                      if (mounted && t == _token) _playInstruction();
                    });
                  },
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text('الْعَبْ مَرَّةً أُخْرَى', style: TextStyle(fontFamily: 'Cairo', fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ).animate(delay: 700.ms).fadeIn().scale(begin: const Offset(0.8, 0.8)),
              ],
            ),
          ),
        ],
      );
}

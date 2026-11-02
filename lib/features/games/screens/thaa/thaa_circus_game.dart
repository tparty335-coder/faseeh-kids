import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── لعبة السيرك لحرف الباء ──────────────────────────────────────────────────
// مطابقة تماماً لشاشات الأسطوانة الأصلية وتصميم لعبة سيرك حرف الألف
// أبعاد الشاشة الأصلية: 1024 × 499

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
  final String praiseAudio;
  final List<_ImageZone> zones;
  const _Round({
    required this.imagePath,
    required this.imgH,
    required this.praiseAudio,
    required this.zones,
  });
}

const List<_Round> _rounds = [
  // الجولة 1: تِمْسَاح (أعلى) ، أَسَد (وسط) ، أَرْنَب (أسفل) ← أَرْنَب ✅
  _Round(
    imagePath: 'assets/images/games/circus/thaa_circus_round_1.png',
    imgH: 390,
    praiseAudio: 'audio/games/circus/7_ba62.mp3',
    zones: [
      _ImageZone(label: 'تِمْسَاح', hasThaa: false, px: 138, py: 114),
      _ImageZone(label: 'أَسَد',    hasThaa: false, px: 326, py: 255),
      _ImageZone(label: 'ثَعْلَب',  hasThaa: true,  px: 138, py: 392,
          wordAudio: 'audio/lessons/thaa/sounds/word_thalab.mp3'),
    ],
  ),
  // الجولة 2: حِمَار (أعلى) ، ثُعْبَان (وسط) ، فِيل (أسفل) ← ثُعْبَان ✅
  _Round(
    imagePath: 'assets/images/games/circus/thaa_circus_round_2.png',
    imgH: 390,
    praiseAudio: 'audio/games/circus/6_ba59.mp3',
    zones: [
      _ImageZone(label: 'حِمَار',  hasThaa: false, px: 138, py: 114),
      _ImageZone(label: 'ثُعْبَان', hasThaa: true,  px: 326, py: 258,
          wordAudio: 'audio/lessons/thaa/sounds/word_thoban.mp3'),
      _ImageZone(label: 'فِيل',    hasThaa: false, px: 138, py: 398),
    ],
  ),
  // الجولة 3: حِصَان (أعلى) ، مِطْرَقَة (وسط) ، ثَوْر (أسفل) ← ثَوْر ✅
  _Round(
    imagePath: 'assets/images/games/circus/thaa_circus_round_3.png',
    imgH: 390,
    praiseAudio: 'audio/games/circus/6_ba53.mp3',
    zones: [
      _ImageZone(label: 'حِصَان',  hasThaa: false, px: 138, py: 116),
      _ImageZone(label: 'مِطْرَقَة', hasThaa: false, px: 326, py: 262),
      _ImageZone(label: 'ثَوْر',    hasThaa: true,  px: 138, py: 404,
          wordAudio: 'audio/lessons/thaa/sounds/word_thawr.mp3'),
    ],
  ),
];

class ThaaCircusGame extends ConsumerStatefulWidget {
  const ThaaCircusGame({super.key});

  @override
  ConsumerState<ThaaCircusGame> createState() => _ThaaCircusGameState();
}

class _ThaaCircusGameState extends ConsumerState<ThaaCircusGame> {
  late ConfettiController _confetti;
  int _round = 0, _score = 0, _wrongAttempts = 0, _token = 0;
  int? _tapped;
  bool _roundDone = false, _gameOver = false, _showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
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

  Future<void> _say(String path, {int maxMs = 4000}) async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
      final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
      if (done != null) {
        await done.first.timeout(
          Duration(milliseconds: maxMs),
          onTimeout: () {},
        );
      } else {
        await Future.delayed(Duration(milliseconds: maxMs));
      }
    } catch (_) {}
  }

  Future<void> _playInstruction() async {
    if (!mounted || _gameOver) return;
    ++_token;
    // صوت التعليمات الأصلي من الأسطوانة: "اضغط على الصورة التي بها حرف ب" (1.24s)
    await _say('audio/games/circus/8_al13.mp3', maxMs: 2500);
  }

  Future<void> _playWrong() => _say('audio/games/circus/4_hawe.mp3', maxMs: 2500);

  Future<void> _onTap(int idx) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.lightImpact();
    final t = ++_token;
    final rd = _rounds[_round];
    final zone = rd.zones[idx];

    if (zone.hasThaa) {
      setState(() {
        _tapped = idx;
        _roundDone = true;
        _score++;
      });
      _confetti.play();

      // 1. صوت التشجيع الكامل دون بتر
      await _say(rd.praiseAudio, maxMs: 2500);
      if (!mounted || t != _token) return;

      // 2. سماع اسم الكلمة كاملاً بعد التشجيع (أَرْنَب / ثُعْبَان / بَاب)
      if (zone.wordAudio != null) {
        await _say(zone.wordAudio!, maxMs: 2500);
        if (!mounted || t != _token) return;
        await Future.delayed(const Duration(milliseconds: 400));
        if (!mounted || t != _token) return;
      }

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
          await _say(correctZone.wordAudio!, maxMs: 2500);
          if (!mounted || t != _token) return;
          await Future.delayed(const Duration(milliseconds: 500));
          if (!mounted || t != _token) return;
        }

        _advance();
      } else {
        setState(() {
          _tapped = null;
        });
      }
    }
  }

  void _advance() {
    final t = ++_token;
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
      Future.delayed(const Duration(milliseconds: 400), () {
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
    return Stack(
      children: [
        LayoutBuilder(
          builder: (ctx, c) {
            final sw = c.maxWidth, sh = c.maxHeight;
            final ia = _imgW / rd.imgH, sa = sw / sh;
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
                  child: Image.asset(rd.imagePath, fit: BoxFit.contain),
                ),
                // مناطق النقر على الفقاعات الثلاث
                ...List.generate(rd.zones.length, (i) {
                  final z = rd.zones[i];
                  final cx = ox + (z.px / _imgW) * dW;
                  final cy = oy + (z.py / rd.imgH) * dH;
                  const r = 70.0;
                  final rScaled = r * (dW / _imgW);

                  Color fill = Colors.transparent;
                  Color ring = Colors.transparent;
                  Widget child = const SizedBox.shrink();

                  if (_showCorrectAnswer) {
                    if (z.hasThaa) {
                      fill = Colors.green.withValues(alpha: 0.35);
                      ring = Colors.greenAccent;
                      child = const Text('✅', style: TextStyle(fontSize: 34));
                    }
                  } else if (_tapped == i) {
                    fill = z.hasThaa
                        ? Colors.green.withValues(alpha: 0.35)
                        : Colors.red.withValues(alpha: 0.35);
                    ring = z.hasThaa ? Colors.greenAccent : Colors.redAccent;
                    child = Text(z.hasThaa ? '✅' : '❌', style: const TextStyle(fontSize: 34));
                  } else if (_roundDone && z.hasThaa) {
                    fill = Colors.green.withValues(alpha: 0.20);
                    ring = Colors.greenAccent.withValues(alpha: 0.70);
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
            'التالي',
            Icons.arrow_back_rounded,
            _roundDone || _showCorrectAnswer,
            () {
              if (_roundDone || _showCorrectAnswer) {
                HapticFeedback.lightImpact();
                _advance();
              }
            },
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _token++;
              AudioService.instance.stop();
              Navigator.of(context).popUntil((route) => route.isFirst);
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
            'السابق',
            Icons.arrow_forward_rounded,
            _round > 0 && !_roundDone && !_showCorrectAnswer,
            () {
              if (_round > 0 && !_roundDone && !_showCorrectAnswer) {
                HapticFeedback.lightImpact();
                final t = ++_token;
                AudioService.instance.stop();
                setState(() {
                  _round--;
                  _tapped = null;
                  _roundDone = false;
                  _wrongAttempts = 0;
                  _showCorrectAnswer = false;
                });
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted && t == _token) _playInstruction();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _navBtn(String label, IconData icon, bool enabled, VoidCallback onTap) {
    final isNext = label == 'التالي';
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: enabled ? const Color(0xFFE53935) : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(24),
            boxShadow: enabled
                ? [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 6, offset: const Offset(0, 3))]
                : [],
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

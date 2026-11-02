import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── لعبة صيد الكلمات لحرف الباء ─────────────────────────────────────────────
// مطابقة تماماً لشاشات الأسطوانة الأصلية ومحرك لعبة صيد حرف الألف
// أبعاد الشاشة الأصلية: 1024 × 465

const double _imgW = 1024;
const double _imgH = 465;

class _FishZone {
  final String word;
  final bool hasHa;
  final double px;
  final double py;
  final double w;
  final double h;
  const _FishZone({
    required this.word,
    required this.hasHa,
    required this.px,
    required this.py,
    this.w = 260,
    this.h = 95,
  });
}

class _RoundData {
  final String imagePath;
  final String correctWord;
  final String wordAudio;
  final String correctPraise;
  final String roundEndPraise;
  final List<_FishZone> zones;
  const _RoundData({
    required this.imagePath,
    required this.correctWord,
    required this.wordAudio,
    required this.correctPraise,
    required this.roundEndPraise,
    required this.zones,
  });
}

const List<_RoundData> _rounds = [
  // الجولة 1: خَرُوف ✅ | أَسَد ❌ | فَأْس ❌
  _RoundData(
    imagePath: 'assets/images/games/fishing/kha/kha_fishing_round_1.png',
    correctWord: 'خَرُوف',
    wordAudio: 'audio/lessons/kha/final/kha_word_p1_1.mp3',
    correctPraise: 'audio/games/fishing/momt.mp3',
    roundEndPraise: 'audio/games/fishing/ba62.mp3',
    zones: [
      _FishZone(word: 'خَرُوف', hasHa: true,  px: 160, py: 390),
      _FishZone(word: 'أَسَد',   hasHa: false, px: 500, py: 345, w: 290, h: 105),
      _FishZone(word: 'فَأْس',   hasHa: false, px: 810, py: 390),
    ],
  ),
  // الجولة 2: وَلَد ❌ | قَلَم ❌ | خِيمَة ✅
  _RoundData(
    imagePath: 'assets/images/games/fishing/kha/kha_fishing_round_2.png',
    correctWord: 'خِيمَة',
    wordAudio: 'audio/lessons/kha/final/kha_word_p2_1.mp3',
    correctPraise: 'audio/games/fishing/sah.mp3',
    roundEndPraise: 'audio/games/fishing/ba58.mp3',
    zones: [
      _FishZone(word: 'وَلَد',  hasHa: false, px: 160, py: 390),
      _FishZone(word: 'قَلَم',  hasHa: false, px: 500, py: 345, w: 290, h: 105),
      _FishZone(word: 'خِيمَة',  hasHa: true,  px: 810, py: 390),
    ],
  ),
  // الجولة 3: رَأْس ❌ | خُبْز ✅ | أُذُن ❌
  _RoundData(
    imagePath: 'assets/images/games/fishing/kha/kha_fishing_round_3.png',
    correctWord: 'خُبْز',
    wordAudio: 'audio/lessons/kha/final/kha_word_p3_1.mp3',
    correctPraise: 'audio/games/fishing/ahsnt.mp3',
    roundEndPraise: 'audio/games/fishing/ba56.mp3',
    zones: [
      _FishZone(word: 'رَأْس',  hasHa: false, px: 160, py: 390),
      _FishZone(word: 'خُبْز',  hasHa: true,  px: 500, py: 345, w: 290, h: 105),
      _FishZone(word: 'أُذُن',  hasHa: false, px: 810, py: 390),
    ],
  ),
  // الجولة 4: أُمِّي ❌ | أَسَد ❌ | خَاتَم ✅
  _RoundData(
    imagePath: 'assets/images/games/fishing/kha/kha_fishing_round_4.png',
    correctWord: 'خَاتَم',
    wordAudio: 'audio/lessons/kha/final/kha_word_p1_3.mp3',
    correctPraise: 'audio/games/fishing/momtt.mp3',
    roundEndPraise: 'audio/games/fishing/ba52.mp3',
    zones: [
      _FishZone(word: 'أُمِّي',  hasHa: false, px: 160, py: 390),
      _FishZone(word: 'أَسَد',   hasHa: false, px: 500, py: 345, w: 290, h: 105),
      _FishZone(word: 'خَاتَم', hasHa: true,  px: 810, py: 390),
    ],
  ),
];

class KhaWordFishingGame extends ConsumerStatefulWidget {
  const KhaWordFishingGame({super.key});

  @override
  ConsumerState<KhaWordFishingGame> createState() => _HaWordFishingGameState();
}

class _HaWordFishingGameState extends ConsumerState<KhaWordFishingGame> {
  late ConfettiController _confetti;

  int _round = 0;
  int _score = 0;
  int _token = 0;
  int? _tappedZoneIndex;
  bool _roundDone = false;
  bool _gameOver = false;
  int _wrongAttempts = 0;
  bool _showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    final t = _token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && t == _token) {
        _startRound(isFirstRound: true);
      }
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
    int maxMs = 4000,
  }) async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(path, channel: channel);
      final done = AudioService.instance.onPlayerComplete(channel);
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

  Future<void> _startRound({bool isFirstRound = false}) async {
    if (!mounted || _gameOver) return;
    final t = ++_token;
    if (isFirstRound) {
      // صوت المقدمة "صيد الكلمات" (1.64s) كاملاً دون بتر
      await _say('audio/games/fishing/sayd.mp3', maxMs: 2500);
      if (!mounted || _gameOver || t != _token) return;
    }
    // صوت السؤال "اضغط على الكلمة التي بها حرف ب" (3.33s)
    await _say('audio/games/fishing/qu1.mp3', maxMs: 4000);
  }

  Future<void> _playWrong() =>
      _say('audio/games/fishing/hawe.mp3', maxMs: 2500);

  Future<void> _onZoneTap(int zoneIndex) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.lightImpact();

    final t = ++_token;
    final rd = _rounds[_round];
    final zone = rd.zones[zoneIndex];
    final isCorrect = zone.hasHa;

    if (isCorrect) {
      setState(() {
        _tappedZoneIndex = zoneIndex;
        _roundDone = true;
        _score++;
      });
      _confetti.play();

      // 1. صوت التشجيع الكامل دون بتر
      await _say(rd.correctPraise, maxMs: 2500);
      if (!mounted || t != _token) return;

      // 2. سماع اسم الكلمة كاملاً بعد التشجيع (أَرْنَب / إِبْرَة / بُرْج / بَقَرَة)
      await _say(rd.wordAudio, maxMs: 2500);
      if (!mounted || t != _token) return;

      // 3. صوت صيد السمكة
      await _say(
        'audio/games/fishing/fish.mp3',
        channel: AudioChannel.sfx,
        maxMs: 1500,
      );
      if (!mounted || t != _token) return;

      // 4. تشجيع نهاية الجولة
      await _say(rd.roundEndPraise, maxMs: 2500);
      if (!mounted || t != _token) return;
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted || t != _token) return;

      _advanceRound();
    } else {
      setState(() {
        _tappedZoneIndex = zoneIndex;
        _wrongAttempts++;
      });
      await _playWrong();
      if (!mounted || t != _token) return;

      if (_wrongAttempts >= 2) {
        setState(() {
          _showCorrectAnswer = true;
        });

        // سماع اسم الكلمة الصحيحة كاملاً عند إظهار الحل دون تداخل
        await _say(rd.wordAudio, maxMs: 2500);
        if (!mounted || t != _token) return;
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted || t != _token) return;

        _advanceRound();
      } else {
        setState(() {
          _tappedZoneIndex = null;
        });
      }
    }
  }

  void _advanceRound() {
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
        _tappedZoneIndex = null;
        _roundDone = false;
        _wrongAttempts = 0;
        _showCorrectAnswer = false;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && t == _token) _startRound();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver();
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
            final ia = _imgW / _imgH, sa = sw / sh;
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

            final scaleX = dW / _imgW;
            final scaleY = dH / _imgH;

            return Stack(
              children: [
                // صورة الشاشة الأصلية من الأسطوانة
                Positioned.fill(
                  child: Image.asset(rd.imagePath, fit: BoxFit.contain),
                ),
                // مناطق النقر على الأسماك الثلاث
                ...List.generate(rd.zones.length, (i) {
                  final z = rd.zones[i];
                  final cx = ox + z.px * scaleX;
                  final cy = oy + z.py * scaleY;
                  final zw = z.w * scaleX;
                  final zh = z.h * scaleY;

                  Color fill = Colors.transparent;
                  Color ring = Colors.transparent;
                  Widget child = const SizedBox.shrink();

                  if (_showCorrectAnswer) {
                    if (z.hasHa) {
                      fill = Colors.green.withValues(alpha: 0.35);
                      ring = Colors.greenAccent;
                      child = const Text('✅', style: TextStyle(fontSize: 32));
                    }
                  } else if (_tappedZoneIndex == i) {
                    fill = z.hasHa
                        ? Colors.green.withValues(alpha: 0.35)
                        : Colors.red.withValues(alpha: 0.35);
                    ring = z.hasHa ? Colors.greenAccent : Colors.redAccent;
                    child = Text(z.hasHa ? '✅' : '❌', style: const TextStyle(fontSize: 32));
                  } else if (_roundDone && z.hasHa) {
                    fill = Colors.green.withValues(alpha: 0.20);
                    ring = Colors.greenAccent.withValues(alpha: 0.70);
                  }

                  return Positioned(
                    left: cx - zw / 2,
                    top: cy - zh / 2,
                    width: zw,
                    height: zh,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onZoneTap(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(zh / 2),
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
                _advanceRound();
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
                  _tappedZoneIndex = null;
                  _roundDone = false;
                  _wrongAttempts = 0;
                  _showCorrectAnswer = false;
                });
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted && t == _token) _startRound();
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
            onTap: () => _startRound(),
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

  Widget _buildGameOver() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(_rounds.last.imagePath, fit: BoxFit.contain),
            ),
            Container(color: Colors.black.withValues(alpha: 0.65)),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🎣', style: TextStyle(fontSize: 85))
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scaleXY(begin: 0.9, end: 1.1, duration: 800.ms),
                  const SizedBox(height: 16),
                  Text(
                    _score == _rounds.length
                        ? 'مُمْتَازٌ! صِدْتَ كُلَّ الأَسْمَاكِ! 🌟'
                        : 'أَحْسَنْتَ! نَتِيجَتُكَ: $_score / ${_rounds.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Colors.amber,
                    ),
                  ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.7, curve: Curves.elasticOut),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.replay_rounded, size: 26),
                    label: const Text(
                      'الْعَبْ مَرَّةً أُخْرَى',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                    ),
                    onPressed: () {
                      setState(() {
                        _gameOver = false;
                        _round = 0;
                        _score = 0;
                        _roundDone = false;
                        _wrongAttempts = 0;
                        _showCorrectAnswer = false;
                        _tappedZoneIndex = null;
                      });
                      _startRound(isFirstRound: true);
                    },
                  ).animate(delay: 800.ms).fadeIn().scaleXY(begin: 0.8),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confetti,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 40,
                gravity: 0.2,
                colors: const [Colors.amber, Colors.green, Colors.blue, Colors.orange, Colors.red],
              ),
            ),
          ],
        );
      },
    );
  }
}


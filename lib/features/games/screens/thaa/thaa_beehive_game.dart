import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── لعبة خلية الحرف لحرف الباء ──────────────────────────────────────────────
// مطابقة تماماً للميكانيكية الأصلية وتصميم لعبة خلية حرف الألف
// أبعاد الشاشة الأصلية: 1024 × 481

const double _imgW = 1024;

class _CellZone {
  final String label;
  final bool isCorrect;
  final double px, py;
  const _CellZone({
    required this.label,
    required this.isCorrect,
    required this.px,
    required this.py,
  });
}

class _Round {
  final String imagePath;
  final double imgH;
  final String wordAudio;
  final String praiseAudio;
  final List<_CellZone> cells;
  const _Round({
    required this.imagePath,
    required this.imgH,
    required this.wordAudio,
    required this.praiseAudio,
    required this.cells,
  });
}

const List<_Round> _rounds = [
  // الجولة 1: ثَعْلَب ← ثَ (يسار)
  _Round(
    imagePath: 'assets/images/games/beehive/thaa_beehive_round_1.png',
    imgH: 375,
    wordAudio: 'audio/lessons/thaa/sounds/word_thalab.mp3',
    praiseAudio: 'audio/games/beehive/4_momt.mp3',
    cells: [
      _CellZone(label: 'ثُ', isCorrect: false, px: 880, py: 170), // أعلى
      _CellZone(label: 'ثَ', isCorrect: true,  px: 694, py: 272), // يسار (ثَعْلَب - فتحة)
      _CellZone(label: 'ثِ', isCorrect: false, px: 946, py: 253), // يمين
      _CellZone(label: 'ثْ', isCorrect: false, px: 754, py: 339), // أسفل
    ],
  ),
  // الجولة 2: ثِمَار ← ثِ (يمين)
  _Round(
    imagePath: 'assets/images/games/beehive/thaa_beehive_round_2.png',
    imgH: 483,
    wordAudio: 'audio/lessons/thaa/sounds/word_thimar.mp3',
    praiseAudio: 'audio/games/beehive/3_raa.mp3',
    cells: [
      _CellZone(label: 'ثُ', isCorrect: false, px: 880, py: 160), // أعلى
      _CellZone(label: 'ثَ', isCorrect: false, px: 694, py: 274), // يسار
      _CellZone(label: 'ثِ', isCorrect: true,  px: 946, py: 254), // يمين (ثِمَار - كسرة)
      _CellZone(label: 'ثْ', isCorrect: false, px: 754, py: 340), // أسفل
    ],
  ),
  // الجولة 3: ثُعْبَان ← ثُ (أعلى)
  _Round(
    imagePath: 'assets/images/games/beehive/thaa_beehive_round_3.png',
    imgH: 473,
    wordAudio: 'audio/lessons/thaa/sounds/word_thoban.mp3',
    praiseAudio: 'audio/games/beehive/2_sah.mp3',
    cells: [
      _CellZone(label: 'ثُ', isCorrect: true,  px: 886, py: 184), // أعلى (ثُعْبَان - ضمة)
      _CellZone(label: 'ثَ', isCorrect: false, px: 696, py: 271), // يسار
      _CellZone(label: 'ثِ', isCorrect: false, px: 946, py: 250), // يمين
      _CellZone(label: 'ثْ', isCorrect: false, px: 756, py: 335), // أسفل
    ],
  ),
  // الجولة 4: مِثْقَاب ← ثْ (أسفل)
  _Round(
    imagePath: 'assets/images/games/beehive/thaa_beehive_round_4.png',
    imgH: 478,
    wordAudio: 'audio/lessons/thaa/sounds/word_mithqab.mp3',
    praiseAudio: 'audio/games/beehive/4_momt.mp3',
    cells: [
      _CellZone(label: 'ثُ', isCorrect: false, px: 880, py: 172), // أعلى
      _CellZone(label: 'ثَ', isCorrect: false, px: 695, py: 274), // يسار
      _CellZone(label: 'ثِ', isCorrect: false, px: 946, py: 254), // يمين
      _CellZone(label: 'ثْ', isCorrect: true,  px: 755, py: 340), // أسفل (مِثْقَاب - سكون)
    ],
  ),
];

class ThaaBeeHiveGame extends ConsumerStatefulWidget {
  const ThaaBeeHiveGame({super.key});
  @override
  ConsumerState<ThaaBeeHiveGame> createState() => _ThaaBeeHiveGameState();
}

class _ThaaBeeHiveGameState extends ConsumerState<ThaaBeeHiveGame> {
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
    final t = ++_token;
    // 1. صوت التعليمات الأصلي من الأسطوانة لحرف الثاء ("اضغط على حرف الثاء بحركته المناسبة...")
    await _say('assets/audio/games/beehive/thaa_beehive_instruction.mp3', pauseAfter: const Duration(milliseconds: 400));
    if (!mounted || _gameOver || t != _token) return;
    // 2. سماع اسم الكلمة الحالية بعد انتهاء التعليمات
    await _playWordAudio(pauseAfter: const Duration(milliseconds: 400));
  }

  Future<void> _playWordAudio({Duration pauseAfter = const Duration(milliseconds: 300)}) async {
    await _say(_rounds[_round].wordAudio, pauseAfter: pauseAfter);
  }

  Future<void> _playCurrentWordStandalone() async {
    if (!mounted || _gameOver) return;
    ++_token;
    await _say(_rounds[_round].wordAudio, pauseAfter: const Duration(milliseconds: 400));
  }

  Future<void> _playWrong() => _say('audio/games/beehive/6_haw.mp3', pauseAfter: const Duration(milliseconds: 300));

  Future<void> _playThisIsCorrect() =>
      _say('audio/games/beehive/2_sah.mp3', pauseAfter: const Duration(milliseconds: 400));

  Future<void> _onCellTap(int idx) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.lightImpact();
    final t = ++_token;
    final round = _rounds[_round];
    final cell = round.cells[idx];
    if (cell.isCorrect) {
      setState(() {
        _tapped = idx;
        _roundDone = true;
        _score++;
      });
      _confetti.play();
      // 1. صوت التشجيع الكامل دون بتر (ممتاز / رائع / صح)
      await _say(round.praiseAudio, pauseAfter: const Duration(milliseconds: 400));
      if (!mounted || t != _token) return;

      // 2. سماع اسم الكلمة كاملاً بعد التشجيع
      await _playWordAudio(pauseAfter: const Duration(milliseconds: 700));
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
        await _playThisIsCorrect();
        if (!mounted || t != _token) return;
        // سماع الكلمة كاملة عند إظهار الإجابة الصحيحة
        await _playWordAudio(pauseAfter: const Duration(milliseconds: 800));
        if (!mounted || t != _token) return;
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
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted && t == _token) _playCurrentWordStandalone();
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
                // زر إعادة الاستماع (موضع السماعة في الصورة)
                Positioned(
                  left: ox + (618 / _imgW) * dW - 25,
                  top: oy + (148 / rd.imgH) * dH - 25,
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _playCurrentWordStandalone,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                // خلايا الحروف الأربعة على الخلية
                ...List.generate(rd.cells.length, (i) {
                  final cell = rd.cells[i];
                  final cx = ox + (cell.px / _imgW) * dW;
                  final cy = oy + (cell.py / rd.imgH) * dH;
                  const r = 42.0;
                  Color fill = Colors.transparent;
                  Color ring = Colors.transparent;
                  Widget child = const SizedBox.shrink();

                  if (_showCorrectAnswer) {
                    if (cell.isCorrect) {
                      fill = Colors.green.withValues(alpha: 0.45);
                      ring = Colors.greenAccent;
                      child = const Text('✅', style: TextStyle(fontSize: 28));
                    }
                  } else if (_tapped == i) {
                    if (cell.isCorrect) {
                      fill = Colors.green.withValues(alpha: 0.45);
                      ring = Colors.greenAccent;
                      child = const Text('✅', style: TextStyle(fontSize: 28));
                    } else {
                      fill = Colors.red.withValues(alpha: 0.45);
                      ring = Colors.redAccent;
                      child = const Text('❌', style: TextStyle(fontSize: 28));
                    }
                  } else if (_roundDone && cell.isCorrect) {
                    fill = Colors.green.withValues(alpha: 0.20);
                    ring = Colors.greenAccent.withValues(alpha: 0.70);
                  }

                  return Positioned(
                    left: cx - r,
                    top: cy - r,
                    width: r * 2,
                    height: r * 2,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onCellTap(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fill,
                          border: Border.all(color: ring, width: 3),
                        ),
                        child: Center(child: child),
                      ),
                    ),
                  );
                }),
                if (_showCorrectAnswer)
                  Positioned(
                    top: oy + dH * 0.35,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.greenAccent, width: 2),
                        ),
                        child: const Text(
                          'هَذِهِ هِيَ الْإِجَابَةُ الصَّحِيحَةُ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ).animate().fadeIn().scale(),
                  ),
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
            true,
            () {
              HapticFeedback.lightImpact();
              _advance();
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
            true,
            () {
              HapticFeedback.lightImpact();
              final t = ++_token;
              AudioService.instance.stop();
              setState(() {
                if (_round > 0) _round--;
                _tapped = null;
                _roundDone = false;
                _wrongAttempts = 0;
                _showCorrectAnswer = false;
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted && t == _token) _playCurrentWordStandalone();
              });
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

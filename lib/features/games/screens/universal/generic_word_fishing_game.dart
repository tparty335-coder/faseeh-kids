import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// لعبة صيد الكلمات الموحّدة — تُغذَّى بالكامل من LetterUnitManifest
class GenericWordFishingGame extends StatefulWidget {
  final LetterUnitManifest manifest;
  final VoidCallback? onExit;

  const GenericWordFishingGame({
    super.key,
    required this.manifest,
    this.onExit,
  });

  @override
  State<GenericWordFishingGame> createState() => _GenericWordFishingGameState();
}

class _GenericWordFishingGameState extends State<GenericWordFishingGame> {
  late ConfettiController _confetti;
  int _round = 0;
  int _score = 0;
  int _token = 0;
  int? _tappedZoneIndex;
  bool _roundDone = false;
  bool _gameOver = false;
  int _wrongAttempts = 0;
  bool _showCorrectAnswer = false;

  List<FishingRound> get _rounds => widget.manifest.games.fishing;
  GamesSpec get _games => widget.manifest.games;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    final t = _token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && t == _token && _rounds.isNotEmpty) {
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
    int maxMs = 4500,
  }) async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(path, channel: channel);
      final done = AudioService.instance.onPlayerComplete(channel);
      if (done != null) {
        await done.first.timeout(Duration(milliseconds: maxMs), onTimeout: () {});
      } else {
        await Future.delayed(Duration(milliseconds: maxMs));
      }
    } catch (_) {}
  }

  Future<void> _startRound({bool isFirstRound = false}) async {
    if (!mounted || _gameOver) return;
    final t = ++_token;
    if (isFirstRound) {
      final intro = _games.fishingIntroAudio ?? 'audio/games/fishing/sayd.mp3';
      await _say(intro, maxMs: 2800);
      if (!mounted || _gameOver || t != _token) return;
    }
    final prompt = _games.fishingPromptAudio;
    if (prompt != null && prompt.isNotEmpty) {
      await _say(prompt, maxMs: 4800);
    }
  }

  List<GameZoneChoice> _effectiveZones(FishingRound rd) {
    if (rd.zones != null && rd.zones!.isNotEmpty) return rd.zones!;
    // مواضع افتراضية مطابقة لشاشات الأسطوانة (800×490)
    return [
      GameZoneChoice(
        label: rd.word,
        isCorrect: rd.isCorrect,
        px: 120,
        py: 425,
        w: 215,
        h: 90,
      ),
      GameZoneChoice(
        label: 'كلمة ٢',
        isCorrect: !rd.isCorrect,
        px: 382,
        py: 382,
        w: 220,
        h: 90,
      ),
      GameZoneChoice(
        label: 'كلمة ٣',
        isCorrect: false,
        px: 625,
        py: 425,
        w: 215,
        h: 90,
      ),
    ];
  }

  Future<void> _onZoneTap(int idx) async {
    if (_roundDone || _showCorrectAnswer || _rounds.isEmpty) return;
    HapticFeedback.lightImpact();

    final t = ++_token;
    final rd = _rounds[_round];
    final zones = _effectiveZones(rd);
    final zone = zones[idx];

    if (zone.isCorrect) {
      setState(() {
        _tappedZoneIndex = idx;
        _roundDone = true;
        _score++;
      });
      _confetti.play();

      if (rd.correctPraiseAudio != null && rd.correctPraiseAudio!.isNotEmpty) {
        await _say(rd.correctPraiseAudio!, maxMs: 2500);
        if (!mounted || t != _token) return;
      }
      await _say(rd.audioPath, maxMs: 2800);
      if (!mounted || t != _token) return;
      await _say('audio/games/fishing/fish.mp3', channel: AudioChannel.sfx, maxMs: 1200);
      if (!mounted || t != _token) return;
      if (rd.roundEndPraiseAudio != null && rd.roundEndPraiseAudio!.isNotEmpty) {
        await _say(rd.roundEndPraiseAudio!, maxMs: 2500);
        if (!mounted || t != _token) return;
      }
      await Future.delayed(const Duration(milliseconds: 280));
      if (!mounted || t != _token) return;
      _advanceRound();
    } else {
      setState(() {
        _tappedZoneIndex = idx;
        _wrongAttempts++;
      });
      final wrongAudio = _games.fishingWrongAudio ?? 'audio/games/fishing/hawe.mp3';
      await _say(wrongAudio, maxMs: 2500);
      if (!mounted || t != _token) return;

      if (_wrongAttempts >= 2) {
        setState(() => _showCorrectAnswer = true);
        await _say(rd.audioPath, maxMs: 2800);
        if (!mounted || t != _token) return;
        await Future.delayed(const Duration(milliseconds: 450));
        if (!mounted || t != _token) return;
        _advanceRound();
      } else {
        setState(() => _tappedZoneIndex = null);
      }
    }
  }

  void _advanceRound() {
    final t = ++_token;
    AudioService.instance.stop();
    if (_round + 1 >= _rounds.length) {
      setState(() => _gameOver = true);
      if (_score >= _rounds.length / 2) _confetti.play();
      final fin = _games.praiseFinishAudio ?? 'audio/games/fishing/ahsnt.mp3';
      try {
        AudioService.instance.playAsset(fin, channel: AudioChannel.voice);
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

  void _prevRound() {
    if (_round <= 0) return;
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

  @override
  Widget build(BuildContext context) {
    if (_rounds.isEmpty) {
      return const Center(child: Text('لا توجد جولات متاحة', style: TextStyle(fontFamily: 'Cairo')));
    }
    if (_gameOver) return _buildGameOver();
    return Column(
      children: [
        Expanded(child: _buildScene()),
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildScene() {
    final rd = _rounds[_round];
    final zones = _effectiveZones(rd);
    return Stack(
      children: [
        LayoutBuilder(
          builder: (ctx, c) {
            final sw = c.maxWidth, sh = c.maxHeight;
            final ia = rd.imgW / rd.imgH, sa = sw / sh;
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
            final sx = dW / rd.imgW, sy = dH / rd.imgH;

            return Stack(
              children: [
                Positioned.fill(child: Image.asset(rd.imagePath, fit: BoxFit.contain)),
                ...List.generate(zones.length, (i) {
                  final z = zones[i];
                  final zw = z.w * sx, zh = z.h * sy;
                  final left = ox + z.px * sx - zw / 2;
                  final top = oy + z.py * sy - zh / 2;

                  Color fill = Colors.transparent;
                  Color ring = Colors.transparent;
                  String? badge;
                  if (_showCorrectAnswer && z.isCorrect) {
                    fill = Colors.green.withValues(alpha: 0.30);
                    ring = Colors.greenAccent;
                    badge = '✅';
                  } else if (_tappedZoneIndex == i) {
                    fill = (z.isCorrect ? Colors.green : Colors.red).withValues(alpha: 0.32);
                    ring = z.isCorrect ? Colors.greenAccent : Colors.redAccent;
                    badge = z.isCorrect ? '✅' : '❌';
                  }

                  return Positioned(
                    left: left,
                    top: top,
                    width: zw,
                    height: zh,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onZoneTap(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: fill,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ring, width: ring == Colors.transparent ? 0 : 3),
                        ),
                        child: badge != null
                            ? Center(child: Text(badge, style: const TextStyle(fontSize: 32)))
                            : null,
                      ),
                    ),
                  );
                }),
                Positioned(top: 8, left: 0, right: 0, child: _topScoreBar()),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 28,
          ),
        ),
      ],
    );
  }

  Widget _topScoreBar() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '🎣 الجولة ${_round + 1} / ${_rounds.length}  •  ⭐ $_score',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton.icon(
              onPressed: _round > 0 ? _prevRound : null,
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
              label: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('السابق', maxLines: 1, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _startRound(),
            icon: const Icon(Icons.volume_up_rounded),
            tooltip: 'إعادة الصوت',
          ),
          Flexible(
            child: TextButton.icon(
              onPressed: _advanceRound,
              icon: const Icon(Icons.arrow_back_ios_rounded, size: 15),
              label: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('التالي', maxLines: 1, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameOver() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🏆', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          Text(
            'أحسنت في صيد كلمات (${widget.manifest.letter})!',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, fontFamily: 'Cairo'),
          ),
          const SizedBox(height: 8),
          Text('النتيجة: $_score / ${_rounds.length}', style: const TextStyle(fontSize: 18, fontFamily: 'Cairo')),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _round = 0;
                    _score = 0;
                    _gameOver = false;
                    _roundDone = false;
                    _tappedZoneIndex = null;
                    _wrongAttempts = 0;
                    _showCorrectAnswer = false;
                  });
                  _startRound(isFirstRound: true);
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('العب مجدداً', style: TextStyle(fontFamily: 'Cairo')),
              ),
              if (widget.onExit != null)
                OutlinedButton(
                  onPressed: widget.onExit,
                  child: const Text('قائمة الألعاب', style: TextStyle(fontFamily: 'Cairo')),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

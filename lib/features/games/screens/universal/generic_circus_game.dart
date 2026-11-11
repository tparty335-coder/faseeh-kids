import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// لعبة السيرك الموحّدة — تُغذَّى بالكامل من LetterUnitManifest
class GenericCircusGame extends StatefulWidget {
  final LetterUnitManifest manifest;
  final VoidCallback? onExit;

  const GenericCircusGame({
    super.key,
    required this.manifest,
    this.onExit,
  });

  @override
  State<GenericCircusGame> createState() => _GenericCircusGameState();
}

class _GenericCircusGameState extends State<GenericCircusGame> {
  late ConfettiController _confetti;
  int _round = 0;
  int _score = 0;
  int _wrongAttempts = 0;
  int _token = 0;
  int? _tapped;
  bool _roundDone = false;
  bool _gameOver = false;
  bool _showCorrectAnswer = false;

  List<CircusRound> get _rounds => widget.manifest.games.circus;
  GamesSpec get _games => widget.manifest.games;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    final t = _token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 350), () {
        if (mounted && t == _token && _rounds.isNotEmpty) _playInstruction();
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

  Future<void> _say(String path, {int maxMs = 4500}) async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
      final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
      if (done != null) {
        await done.first.timeout(Duration(milliseconds: maxMs), onTimeout: () {});
      } else {
        await Future.delayed(Duration(milliseconds: maxMs));
      }
    } catch (_) {}
  }

  Future<void> _playInstruction() async {
    if (!mounted || _gameOver) return;
    ++_token;
    final prompt = _games.circusPromptAudio;
    if (prompt != null && prompt.isNotEmpty) {
      await _say(prompt, maxMs: 5500);
    }
  }

  List<GameZoneChoice> _effectiveZones(CircusRound rd) {
    if (rd.zones != null && rd.zones!.isNotEmpty) return rd.zones!;
    return [
      GameZoneChoice(label: rd.word, isCorrect: true, px: 137, py: 98, wordAudio: rd.audioPath),
      const GameZoneChoice(label: 'صورة ٢', isCorrect: false, px: 272, py: 240),
      const GameZoneChoice(label: 'صورة ٣', isCorrect: false, px: 135, py: 373),
    ];
  }

  Future<void> _onTap(int idx) async {
    if (_roundDone || _showCorrectAnswer || _rounds.isEmpty) return;
    HapticFeedback.lightImpact();
    final t = ++_token;
    final rd = _rounds[_round];
    final zones = _effectiveZones(rd);
    final zone = zones[idx];

    if (zone.isCorrect) {
      setState(() {
        _tapped = idx;
        _roundDone = true;
        _score++;
      });
      _confetti.play();
      final praise = rd.praiseAudio ?? 'audio/games/circus/7_ba62.mp3';
      await _say(praise, maxMs: 2500);
      if (!mounted || t != _token) return;
      final wordAudio = zone.wordAudio ?? rd.audioPath;
      if (wordAudio.isNotEmpty) {
        await _say(wordAudio, maxMs: 2800);
        if (!mounted || t != _token) return;
      }
      await Future.delayed(const Duration(milliseconds: 350));
      if (!mounted || t != _token) return;
      _advance();
    } else {
      setState(() {
        _tapped = idx;
        _wrongAttempts++;
      });
      final wrong = _games.circusWrongAudio ?? 'audio/games/circus/4_hawe.mp3';
      await _say(wrong, maxMs: 2500);
      if (!mounted || t != _token) return;

      if (_wrongAttempts >= 2) {
        setState(() => _showCorrectAnswer = true);
        final correctZone = zones.firstWhere((z) => z.isCorrect, orElse: () => zones.first);
        final wordAudio = correctZone.wordAudio ?? rd.audioPath;
        if (wordAudio.isNotEmpty) {
          await _say(wordAudio, maxMs: 2800);
          if (!mounted || t != _token) return;
        }
        await Future.delayed(const Duration(milliseconds: 450));
        if (!mounted || t != _token) return;
        _advance();
      } else {
        setState(() => _tapped = null);
      }
    }
  }

  void _advance() {
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
        _tapped = null;
        _roundDone = false;
        _wrongAttempts = 0;
        _showCorrectAnswer = false;
      });
      Future.delayed(const Duration(milliseconds: 350), () {
        if (mounted && t == _token) _playInstruction();
      });
    }
  }

  void _prev() {
    if (_round <= 0) return;
    final t = ++_token;
    AudioService.instance.stop();
    setState(() {
      _round--;
      _tapped = null;
      _roundDone = false;
      _wrongAttempts = 0;
      _showCorrectAnswer = false;
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted && t == _token) _playInstruction();
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
                  final cx = ox + z.px * sx;
                  final cy = oy + z.py * sy;
                  final r = 68.0 * sx;

                  Color fill = Colors.transparent;
                  Color ring = Colors.transparent;
                  String? badge;
                  if (_showCorrectAnswer && z.isCorrect) {
                    fill = Colors.green.withValues(alpha: 0.34);
                    ring = Colors.greenAccent;
                    badge = '✅';
                  } else if (_tapped == i) {
                    fill = (z.isCorrect ? Colors.green : Colors.red).withValues(alpha: 0.34);
                    ring = z.isCorrect ? Colors.greenAccent : Colors.redAccent;
                    badge = z.isCorrect ? '✅' : '❌';
                  }

                  return Positioned(
                    left: cx - r,
                    top: cy - r,
                    width: r * 2,
                    height: r * 2,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onTap(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fill,
                          border: Border.all(color: ring, width: ring == Colors.transparent ? 0 : 3),
                        ),
                        child: badge != null
                            ? Center(child: Text(badge, style: const TextStyle(fontSize: 32)))
                            : null,
                      ),
                    ),
                  );
                }),
                Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '🎪 الجولة ${_round + 1} / ${_rounds.length}  •  ⭐ $_score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
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

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton.icon(
              onPressed: _round > 0 ? _prev : null,
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
              label: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('السابق', maxLines: 1, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          IconButton(
            onPressed: _playInstruction,
            icon: const Icon(Icons.volume_up_rounded),
            tooltip: 'إعادة الصوت',
          ),
          Flexible(
            child: TextButton.icon(
              onPressed: _advance,
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
          const Text('🎪', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          Text(
            'رائع في سيرك (${widget.manifest.letter})!',
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
                    _tapped = null;
                    _wrongAttempts = 0;
                    _showCorrectAnswer = false;
                  });
                  _playInstruction();
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

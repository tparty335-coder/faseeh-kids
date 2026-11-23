import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/games/widgets/universal_game_bottom_bar.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// لعبة خلية النحل الموحّدة — تُغذَّى بالكامل من LetterUnitManifest
class GenericBeehiveGame extends StatefulWidget {
  final LetterUnitManifest manifest;
  final VoidCallback? onExit;

  const GenericBeehiveGame({
    super.key,
    required this.manifest,
    this.onExit,
  });

  @override
  State<GenericBeehiveGame> createState() => _GenericBeehiveGameState();
}

class _GenericBeehiveGameState extends State<GenericBeehiveGame> {
  late ConfettiController _confetti;
  int _round = 0;
  int _score = 0;
  int _wrongAttempts = 0;
  int _token = 0;
  int? _tapped;
  bool _roundDone = false;
  bool _gameOver = false;
  bool _showCorrectAnswer = false;

  List<BeehiveRound> get _rounds => widget.manifest.games.beehive;
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
      await () async {
        await AudioService.instance.stop();
        await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
        final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
        if (done != null) {
          await done.first;
        } else {
          await Future.delayed(Duration(milliseconds: maxMs));
        }
      }().timeout(Duration(milliseconds: maxMs), onTimeout: () {});
    } catch (_) {}
  }

  Future<void> _playInstruction() async {
    if (!mounted || _gameOver || _rounds.isEmpty) return;
    final t = ++_token;
    final prompt = _games.beehivePromptAudio ?? 'audio/games/beehive/5_khalea2.mp3';
    await _say(prompt, maxMs: 7500);
    if (!mounted || _gameOver || t != _token) return;
    await _say(_rounds[_round].audioPath, maxMs: 2800);
  }

  Future<void> _playCurrentWordOnly() async {
    if (!mounted || _gameOver || _rounds.isEmpty) return;
    ++_token;
    await _say(_rounds[_round].audioPath, maxMs: 2800);
  }

  int _detectCorrectCellIndex(String word, String letter) {
    final base = letter.replaceAll('ـ', '').trim();
    final target = base.isEmpty ? letter : base[0];
    for (int i = 0; i < word.length; i++) {
      if (word[i] == target) {
        for (int j = i + 1; j < word.length && j <= i + 2; j++) {
          final code = word.codeUnitAt(j);
          if (code == 0x064F) return 0; // ضمة ُ
          if (code == 0x064E) return 1; // فتحة َ
          if (code == 0x0650) return 2; // كسرة ِ
          if (code == 0x0652) return 3; // سكون ْ
        }
      }
    }
    const order = [1, 2, 0, 3];
    return order[_round % 4];
  }

  List<GameZoneChoice> _effectiveCells(BeehiveRound rd) {
    if (rd.cells != null && rd.cells!.isNotEmpty) return rd.cells!;
    final ch = widget.manifest.letter.replaceAll('ـ', '').trim();
    final corr = _detectCorrectCellIndex(rd.word, ch);
    return [
      GameZoneChoice(label: '$chُ', isCorrect: corr == 0, px: 692, py: 181),
      GameZoneChoice(label: '$chَ', isCorrect: corr == 1, px: 546, py: 269),
      GameZoneChoice(label: '$chِ', isCorrect: corr == 2, px: 739, py: 255),
      GameZoneChoice(label: '$chْ', isCorrect: corr == 3, px: 595, py: 350),
    ];
  }

  Future<void> _onCellTap(int idx) async {
    if (_roundDone || _showCorrectAnswer || _rounds.isEmpty) return;
    HapticFeedback.lightImpact();
    final t = ++_token;
    AudioService.instance.stop();
    final rd = _rounds[_round];
    final cells = _effectiveCells(rd);
    final cell = cells[idx];

    if (cell.isCorrect) {
      setState(() {
        _tapped = idx;
        _roundDone = true;
        _score++;
      });
      _confetti.play();
      final praise = rd.praiseAudio ?? 'audio/common/encourage_1.mp3';
      await _say(praise, maxMs: 2500);
      if (!mounted || t != _token) return;
      await _say(rd.audioPath, maxMs: 2800);
      if (!mounted || t != _token) return;
      await Future.delayed(const Duration(milliseconds: 350));
      if (!mounted || t != _token) return;
      _advance();
    } else {
      setState(() {
        _tapped = idx;
        _wrongAttempts++;
      });
      final wrong = _games.beehiveWrongAudio ?? 'audio/feedback/try_again.mp3';
      await _say(wrong, maxMs: 2500);
      if (!mounted || t != _token) return;

      if (_wrongAttempts >= 2) {
        setState(() => _showCorrectAnswer = true);
        await _say('audio/feedback/smart.mp3', maxMs: 2500);
        if (!mounted || t != _token) return;
        await _say(rd.audioPath, maxMs: 2800);
        if (!mounted || t != _token) return;
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
      final fin = _games.praiseFinishAudio ?? 'audio/feedback/correct.mp3';
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
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && t == _token) _playCurrentWordOnly();
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
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && t == _token) _playCurrentWordOnly();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_rounds.isEmpty) {
      return const Center(child: Text('لا توجد جولات متاحة', style: TextStyle(fontFamily: 'NotoNaskhArabic')));
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
    final cells = _effectiveCells(rd);
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
            final ref = rd.imgW / 800.0;

            return Stack(
              children: [
                Positioned.fill(child: Image.asset(rd.imagePath, fit: BoxFit.contain)),
                Positioned(
                  left: ox + rd.speakerPx * sx - 32 * sx * ref,
                  top: oy + rd.speakerPy * sy - 32 * sy * ref,
                  width: 64 * sx * ref,
                  height: 64 * sy * ref,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _playCurrentWordOnly,
                    child: const SizedBox.expand(),
                  ),
                ),
                ...List.generate(cells.length, (i) {
                  final cell = cells[i];
                  final r = 42.0 * sx * ref;
                  final cx = ox + cell.px * sx;
                  final cy = oy + cell.py * sy;

                  Color fill = Colors.transparent;
                  Color ring = Colors.transparent;
                  String? badge;
                  if (_showCorrectAnswer && cell.isCorrect) {
                    fill = Colors.green.withValues(alpha: 0.32);
                    ring = Colors.greenAccent;
                    badge = '✅';
                  } else if (_tapped == i) {
                    fill = (cell.isCorrect ? Colors.green : Colors.red).withValues(alpha: 0.34);
                    ring = cell.isCorrect ? Colors.greenAccent : Colors.redAccent;
                    badge = cell.isCorrect ? '✅' : '❌';
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
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fill,
                          border: Border.all(color: ring, width: ring == Colors.transparent ? 0 : 3),
                        ),
                        child: badge != null
                            ? Center(child: Text(badge, style: const TextStyle(fontSize: 28)))
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
                        '🍯 الجولة ${_round + 1} / ${_rounds.length}  •  ⭐ $_score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoNaskhArabic',
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
    return UniversalGameBottomBar(
      onPrevious: _round > 0 ? _prev : null,
      onNext: _advance,
      onReplayAudio: _playCurrentWordOnly,
      onGamesMenu: widget.onExit,
      accentColor: widget.manifest.topBarColor,
      isLastRound: _round + 1 >= _rounds.length,
    );
  }

  Widget _buildGameOver() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🍯', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          Text(
            'أحسنت في خلية (${widget.manifest.letter})!',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, fontFamily: 'NotoNaskhArabic'),
          ),
          const SizedBox(height: 8),
          Text('النتيجة: $_score / ${_rounds.length}', style: const TextStyle(fontSize: 18, fontFamily: 'NotoNaskhArabic')),
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
                label: const Text('العب مجدداً', style: TextStyle(fontFamily: 'NotoNaskhArabic')),
              ),
              if (widget.onExit != null)
                OutlinedButton(
                  onPressed: widget.onExit,
                  child: const Text('قائمة الألعاب', style: TextStyle(fontFamily: 'NotoNaskhArabic')),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

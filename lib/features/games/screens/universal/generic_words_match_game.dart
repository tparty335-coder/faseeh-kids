import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// لعبة مطابقة الكلمات الموحّدة — تُغذَّى بالكامل من LetterUnitManifest
class GenericWordsMatchGame extends StatefulWidget {
  final LetterUnitManifest manifest;
  final VoidCallback? onExit;

  const GenericWordsMatchGame({
    super.key,
    required this.manifest,
    this.onExit,
  });

  @override
  State<GenericWordsMatchGame> createState() => _GenericWordsMatchGameState();
}

class _GenericWordsMatchGameState extends State<GenericWordsMatchGame> {
  late ConfettiController _confetti;
  int _round = 0;
  int _score = 0;
  int _token = 0;
  bool _gameOver = false;
  bool _roundDone = false;
  bool _showCorrectAnswer = false;
  int _wrongAttempts = 0;
  String? _droppedWord;
  int? _shakingCard;
  bool _isDraggingOver = false;

  List<WordsMatchPair> get _rounds => widget.manifest.games.wordsMatch;
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
    final prompt = _games.wordsMatchPromptAudio ?? 'audio/instructions/words_drag_instruction.mp3';
    await _say(prompt, maxMs: 5600);
  }

  List<GameZoneChoice> _effectiveCards(WordsMatchPair rd) {
    if (rd.cards != null && rd.cards!.isNotEmpty) return rd.cards!;
    return [
      GameZoneChoice(label: rd.word, isCorrect: true, colorValue: 0xFF5AC8FA),
      const GameZoneChoice(label: 'كلمة ٢', isCorrect: false, colorValue: 0xFFFF9EB5),
      const GameZoneChoice(label: 'كلمة ٣', isCorrect: false, colorValue: 0xFFFFD17A),
    ];
  }

  Future<void> _onCardSelected(int cardIdx) async {
    if (_roundDone || _showCorrectAnswer || _rounds.isEmpty) return;
    HapticFeedback.mediumImpact();
    final t = ++_token;
    final rd = _rounds[_round];
    final cards = _effectiveCards(rd);
    final card = cards[cardIdx];

    if (card.isCorrect) {
      setState(() {
        _roundDone = true;
        _score++;
        _droppedWord = card.label;
      });
      _confetti.play();
      final praise = rd.praiseAudio ?? 'audio/games/beehive/4_momt.mp3';
      await _say(praise, maxMs: 2500);
      if (!mounted || t != _token) return;
      await _say(rd.audioPath, maxMs: 2800);
      if (!mounted || t != _token) return;
      await Future.delayed(const Duration(milliseconds: 350));
      if (!mounted || t != _token) return;
      _advance();
    } else {
      setState(() {
        _shakingCard = cardIdx;
        _wrongAttempts++;
      });
      final wrong = _games.wordsMatchWrongAudio ?? 'audio/games/fishing/hawe.mp3';
      await _say(wrong, maxMs: 2500);
      if (!mounted || t != _token) return;

      if (_wrongAttempts >= 2) {
        setState(() {
          _showCorrectAnswer = true;
          _droppedWord = rd.word;
        });
        await _say('audio/games/beehive/2_sah.mp3', maxMs: 2500);
        if (!mounted || t != _token) return;
        await _say(rd.audioPath, maxMs: 2800);
        if (!mounted || t != _token) return;
        await Future.delayed(const Duration(milliseconds: 450));
        if (!mounted || t != _token) return;
        _advance();
      } else {
        setState(() => _shakingCard = null);
      }
    }
  }

  void _advance() {
    ++_token;
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
        _roundDone = false;
        _wrongAttempts = 0;
        _showCorrectAnswer = false;
        _droppedWord = null;
        _shakingCard = null;
        _isDraggingOver = false;
      });
    }
  }

  void _prev() {
    if (_round <= 0) return;
    ++_token;
    AudioService.instance.stop();
    setState(() {
      _round--;
      _roundDone = false;
      _wrongAttempts = 0;
      _showCorrectAnswer = false;
      _droppedWord = null;
      _shakingCard = null;
      _isDraggingOver = false;
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
    final cards = _effectiveCards(rd);
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
                // منطقة الإسقاط
                Positioned(
                  left: ox + rd.dropPx * sx - 80 * sx,
                  top: oy + rd.dropPy * sy - 26 * sy,
                  width: 160 * sx,
                  height: 52 * sy,
                  child: DragTarget<int>(
                    onWillAcceptWithDetails: (_) {
                      setState(() => _isDraggingOver = true);
                      return !_roundDone && !_showCorrectAnswer;
                    },
                    onLeave: (_) => setState(() => _isDraggingOver = false),
                    onAcceptWithDetails: (d) {
                      setState(() => _isDraggingOver = false);
                      _onCardSelected(d.data);
                    },
                    builder: (_, __, ___) {
                      final hasWord = _droppedWord != null;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: hasWord
                              ? (_showCorrectAnswer ? Colors.amber.shade50 : Colors.green.shade50)
                              : (_isDraggingOver ? Colors.blue.shade50 : Colors.transparent),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: hasWord
                                ? (_showCorrectAnswer ? Colors.amber.shade700 : Colors.green)
                                : (_isDraggingOver ? Colors.blue : Colors.transparent),
                            width: hasWord || _isDraggingOver ? 2.5 : 0,
                          ),
                        ),
                        child: hasWord
                            ? Center(
                                child: Text(
                                  _droppedWord!,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: (22 * sx).clamp(12.0, 28.0),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade900,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
                // بطاقات الاختيار (نقر أو سحب)
                ...List.generate(cards.length, (i) {
                  final card = cards[i];
                  final py = rd.cardPyList[i % rd.cardPyList.length];
                  final cardW = 104 * sx, cardH = 68 * sy;
                  final cx = ox + rd.cardPx * sx;
                  final cy = oy + py * sy;
                  final isShaking = _shakingCard == i;
                  final isDone = _roundDone || _showCorrectAnswer;

                  final box = Container(
                    width: cardW,
                    height: cardH,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      border: (card.isCorrect && _showCorrectAnswer)
                          ? Border.all(color: Colors.green, width: 3)
                          : (isShaking ? Border.all(color: Colors.red, width: 3) : null),
                    ),
                  );

                  return Positioned(
                    left: cx - cardW / 2,
                    top: cy - cardH / 2,
                    width: cardW,
                    height: cardH,
                    child: isDone
                        ? box
                        : Draggable<int>(
                            data: i,
                            feedback: Material(
                              color: Colors.transparent,
                              child: Container(
                                width: cardW,
                                height: cardH,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(card.colorValue ?? 0xFF5AC8FA).withValues(alpha: 0.92),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  card.label,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: (20 * sx).clamp(12.0, 24.0),
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: Opacity(opacity: 0.3, child: box),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => _onCardSelected(i),
                              child: isShaking ? box.animate().shake(duration: 380.ms) : box,
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
                        '📝 الجولة ${_round + 1} / ${_rounds.length}  •  ⭐ $_score',
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
          const Text('📝', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          Text(
            'ممتاز في مطابقة (${widget.manifest.letter})!',
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
                    _wrongAttempts = 0;
                    _showCorrectAnswer = false;
                    _droppedWord = null;
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

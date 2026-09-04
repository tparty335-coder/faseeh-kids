import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

const double _imgW = 1270, _imgH = 950;

class _WordCard {
  final String word;
  final bool isCorrect;
  final Color color;
  final String audioPath; // Original CD audio for THIS word
  const _WordCard({
    required this.word,
    required this.isCorrect,
    required this.color,
    required this.audioPath,
  });
}

class _Round {
  final String imagePath;
  final List<_WordCard> cards;
  final List<double> cardPxList;
  final List<double> cardPyList;
  final double dropPx, dropPy;
  const _Round({
    required this.imagePath,
    required this.cards,
    required this.cardPxList,
    required this.cardPyList,
    required this.dropPx,
    required this.dropPy,
  });
}

// All distractors replaced with Alif-letter words that have ORIGINAL CD audio
const List<_Round> _rounds = [
  // Round 1: Picture = Rabbit (أَرْنَبٌ)
  _Round(
    imagePath: 'assets/images/games/words/words_round_1.png',
    cards: [
      _WordCard(
        word: 'أَسَدٌ',
        isCorrect: false,
        color: Color(0xFF5AC8FA),
        audioPath: 'audio/words_game/alif_word_lion.mp3',
      ),
      _WordCard(
        word: 'أَرْنَبٌ',
        isCorrect: true,
        color: Color(0xFFFF9EB5),
        audioPath: 'audio/words_game/alif_word_rabbit.mp3',
      ),
      _WordCard(
        word: 'أُمٌّ',
        isCorrect: false,
        color: Color(0xFFFFD17A),
        audioPath: 'audio/instructions/alif_trace_step_10.mp3',
      ),
    ],
    cardPxList: [230, 230, 230],
    cardPyList: [210, 450, 690],
    dropPx: 850, dropPy: 722,
  ),
  // Round 2: Picture = Pyramids (أَهْرَامٌ)
  _Round(
    imagePath: 'assets/images/games/words/words_round_2.png',
    cards: [
      _WordCard(
        word: 'أَهْرَامٌ',
        isCorrect: true,
        color: Color(0xFF5AC8FA),
        audioPath: 'audio/words_game/alif_word_pyramids.mp3',
      ),
      _WordCard(
        word: 'أَرْنَبٌ',
        isCorrect: false,
        color: Color(0xFFFF9EB5),
        audioPath: 'audio/words_game/alif_word_rabbit.mp3',
      ),
      _WordCard(
        word: 'أَسَدٌ',
        isCorrect: false,
        color: Color(0xFFFFD17A),
        audioPath: 'audio/words_game/alif_word_lion.mp3',
      ),
    ],
    cardPxList: [230, 230, 230],
    cardPyList: [210, 450, 690],
    dropPx: 850, dropPy: 722,
  ),
  // Round 3: Picture = Lion (أَسَدٌ)
  _Round(
    imagePath: 'assets/images/games/words/words_round_3.png',
    cards: [
      _WordCard(
        word: 'أَسَدٌ',
        isCorrect: true,
        color: Color(0xFF5AC8FA),
        audioPath: 'audio/words_game/alif_word_lion.mp3',
      ),
      _WordCard(
        word: 'أَهْرَامٌ',
        isCorrect: false,
        color: Color(0xFFFF9EB5),
        audioPath: 'audio/words_game/alif_word_pyramids.mp3',
      ),
      _WordCard(
        word: 'أَرْنَبٌ',
        isCorrect: false,
        color: Color(0xFFFFD17A),
        audioPath: 'audio/words_game/alif_word_rabbit.mp3',
      ),
    ],
    cardPxList: [230, 230, 230],
    cardPyList: [210, 450, 690],
    dropPx: 850, dropPy: 722,
  ),
  // Round 4: Picture = Apple (تُفَّاحَةٌ)
  _Round(
    imagePath: 'assets/images/games/words/words_round_4.png',
    cards: [
      _WordCard(
        word: 'أَسَدٌ',
        isCorrect: false,
        color: Color(0xFF5AC8FA),
        audioPath: 'audio/words_game/alif_word_lion.mp3',
      ),
      _WordCard(
        word: 'تُفَّاحَةٌ',
        isCorrect: true,
        color: Color(0xFFFF9EB5),
        audioPath: 'audio/words_game/alif_word_apple.mp3',
      ),
      _WordCard(
        word: 'أُمٌّ',
        isCorrect: false,
        color: Color(0xFFFFD17A),
        audioPath: 'audio/instructions/alif_trace_step_10.mp3',
      ),
    ],
    cardPxList: [230, 230, 230],
    cardPyList: [210, 450, 690],
    dropPx: 850, dropPy: 722,
  ),
  // Round 5: Picture = Book (كِتَابٌ)
  _Round(
    imagePath: 'assets/images/games/words/words_round_5.png',
    cards: [
      _WordCard(
        word: 'كِتَابٌ',
        isCorrect: true,
        color: Color(0xFF5AC8FA),
        audioPath: 'audio/words_game/alif_word_book.mp3',
      ),
      _WordCard(
        word: 'أَرْنَبٌ',
        isCorrect: false,
        color: Color(0xFFFF9EB5),
        audioPath: 'audio/words_game/alif_word_rabbit.mp3',
      ),
      _WordCard(
        word: 'بَابٌ',
        isCorrect: false,
        color: Color(0xFFFFD17A),
        audioPath: 'audio/words_game/alif_word_door.mp3',
      ),
    ],
    cardPxList: [230, 230, 230],
    cardPyList: [210, 450, 690],
    dropPx: 850, dropPy: 722,
  ),
];

class WordsMatchGame extends ConsumerStatefulWidget {
  const WordsMatchGame({super.key});
  @override
  ConsumerState<WordsMatchGame> createState() => _WordsMatchGameState();
}

class _WordsMatchGameState extends ConsumerState<WordsMatchGame>
    with TickerProviderStateMixin {
  late ConfettiController _confetti;
  int _round = 0, _score = 0;
  bool _gameOver = false,
      _roundDone = false,
      _showCorrectAnswer = false;
  int _wrongAttempts = 0;
  String? _droppedWord;
  int? _shakingCard;
  bool _isDraggingOver = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnim;

  // Instruction plays ONCE only at game start (or on speaker tap)
  bool _instructionPlayed = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _shakeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(_shakeController);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Future.delayed(const Duration(milliseconds: 700), _playInstructionOnce));
  }

  @override
  void dispose() {
    _confetti.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  // Original CD instruction: "اسحب اسم الصورة وضعها مكان النقط فيما يأتي"
  Future<void> _playInstructionOnce() async {
    if (_instructionPlayed) return;
    _instructionPlayed = true;
    await AudioService.instance.playAsset(
        'audio/instructions/words_drag_instruction.mp3',
        channel: AudioChannel.voice);
  }

  // Always plays on speaker button tap (re-reads instruction)
  Future<void> _playInstruction() => AudioService.instance.playAsset(
      'audio/instructions/words_drag_instruction.mp3',
      channel: AudioChannel.voice);

  Future<void> _playWrong() => AudioService.instance
      .playAsset('audio/instructions/try_again.mp3', channel: AudioChannel.sfx);

  Future<void> _playWordAudio(String path) =>
      AudioService.instance.playAsset(path, channel: AudioChannel.voice);

  Future<void> _onDropped(int cardIdx) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.mediumImpact();
    final rd = _rounds[_round];
    final card = rd.cards[cardIdx];

    if (card.isCorrect) {
      await _playWordAudio(card.audioPath); // Play ONLY when correct word is dropped
      setState(() {
        _roundDone = true;
        _score++;
        _droppedWord = card.word;
      });
      _confetti.play();
      await Future.delayed(const Duration(milliseconds: 1800));
      if (!mounted) return;
      _advance();
    } else {
      setState(() { _shakingCard = cardIdx; });
      _shakeController.forward(from: 0);
      await _playWrong();
      _wrongAttempts++;
      if (_wrongAttempts >= 2) {
        setState(() { _showCorrectAnswer = true; });
        await Future.delayed(const Duration(milliseconds: 400));
        final correct = rd.cards.firstWhere((c) => c.isCorrect);
        setState(() { _droppedWord = correct.word; });
        await _playWordAudio(correct.audioPath);
        await Future.delayed(const Duration(milliseconds: 2500));
        if (!mounted) return;
        _advance();
      } else {
        await Future.delayed(const Duration(milliseconds: 600));
        if (!mounted) return;
        setState(() { _shakingCard = null; });
      }
    }
  }

  void _advance() {
    if (_round + 1 >= _rounds.length) {
      setState(() => _gameOver = true);
      if (_score >= _rounds.length / 2) _confetti.play();
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
      // NO re-play of instruction between rounds
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _gameOverScreen();
    return Column(children: [
      Expanded(child: _buildGameScene()),
      _buildBottomNavBar(context),
    ]);
  }

  Widget _buildGameScene() {
    final rd = _rounds[_round];
    return Stack(children: [
      LayoutBuilder(builder: (ctx, c) {
        final sw = c.maxWidth, sh = c.maxHeight;
        final ia = _imgW / _imgH, sa = sw / sh;
        double dW, dH, ox, oy;
        if (sa < ia) {
          dW = sw; dH = sw / ia; ox = 0; oy = (sh - dH) / 2;
        } else {
          dH = sh; dW = sh * ia; ox = (sw - dW) / 2; oy = 0;
        }
        final scaleX = dW / _imgW, scaleY = dH / _imgH;
        return Stack(children: [
          // Background
          Positioned.fill(
              child: Image.asset(rd.imagePath, fit: BoxFit.contain)),
          // White mask over printed original text area on left side
          Positioned(
            left: ox + 155 * scaleX,
            top: oy + 140 * scaleY,
            width: 175 * scaleX,
            height: 580 * scaleY,
            child: Container(color: Colors.white),
          ),

          // Train mask (blue background)
          Positioned(
            right: ox,
            bottom: oy,
            width: 450 * scaleX,
            height: 115 * scaleY,
            child: Container(color: const Color(0xFF58AED7)),
          ),
          // Hand mask (blue background)
          Positioned(
            left: ox,
            bottom: oy,
            width: 250 * scaleX,
            height: 150 * scaleY,
            child: Container(color: const Color(0xFF58AED7)),
          ),
          // Drop target zone
          _buildDropTarget(rd, ox, oy, scaleX, scaleY),
          // Draggable word cards
          ...List.generate(rd.cards.length,
              (i) => _buildDraggableCard(rd, i, ox, oy, scaleX, scaleY)),
          // Top bar
          Positioned(top: 10, left: 0, right: 0, child: _topBar()),
        ]);
      }),
      Align(
        alignment: Alignment.topCenter,
        child: ConfettiWidget(
          confettiController: _confetti,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 30,
          gravity: 0.4,
          colors: const [
            Colors.yellow,
            Colors.green,
            Colors.red,
            Colors.purple,
            Colors.orange
          ],
        ),
      ),
    ]);
  }

  Widget _buildDropTarget(
      _Round rd, double ox, double oy, double scaleX, double scaleY) {
    final cx = ox + rd.dropPx * scaleX;
    final cy = oy + rd.dropPy * scaleY;
    const zW = 250.0, zH = 80.0;
    final tw = zW * scaleX, th = zH * scaleY;
    final hasWord = _droppedWord != null;

    return Positioned(
      left: cx - tw / 2,
      top: cy - th / 2,
      width: tw,
      height: th,
      child: DragTarget<int>(
        onWillAcceptWithDetails: (_) {
          setState(() => _isDraggingOver = true);
          return !_roundDone && !_showCorrectAnswer;
        },
        onLeave: (_) => setState(() => _isDraggingOver = false),
        onAcceptWithDetails: (details) {
          setState(() => _isDraggingOver = false);
          _onDropped(details.data);
        },
        builder: (ctx, candidates, rejected) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: hasWord
                  ? (_showCorrectAnswer
                      ? Colors.orange.shade50
                      : Colors.green.shade50)
                  : (_isDraggingOver
                      ? Colors.blue.shade50
                      : Colors.white.withValues(alpha: 0.85)),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: hasWord
                    ? (_showCorrectAnswer ? Colors.orange : Colors.green)
                    : (_isDraggingOver ? Colors.blue : Colors.grey.shade400),
                width: _isDraggingOver ? 3 : 2,
                style: hasWord ? BorderStyle.solid : BorderStyle.solid,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: hasWord
                ? Center(
                    child: Text(
                      _droppedWord!,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 42 * scaleX,
                        fontWeight: FontWeight.bold,
                        color: _showCorrectAnswer
                            ? Colors.orange.shade800
                            : Colors.green.shade800,
                      ),
                    ),
                  )
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (i) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 3 * scaleX),
                          width: 16 * scaleX,
                          height: 3 * scaleY,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildDraggableCard(
      _Round rd, int i, double ox, double oy, double scaleX, double scaleY) {
    final card = rd.cards[i];
    final cx = ox + rd.cardPxList[i] * scaleX;
    final cy = oy + rd.cardPyList[i] * scaleY;
    const cW = 165.0, cH = 85.0;
    final cardW = cW * scaleX, cardH = cH * scaleY;
    final isShaking = _shakingCard == i;
    final isDone = _roundDone || _showCorrectAnswer;
    final isHint = _showCorrectAnswer && card.isCorrect;

    Widget face = GestureDetector(
      child: Container(
        width: cardW,
        height: cardH,
        decoration: BoxDecoration(
          color: isHint ? Colors.green : card.color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isHint
                ? Colors.greenAccent
                : Colors.white.withValues(alpha: 0.8),
            width: isHint ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isHint ? Colors.green : card.color)
                  .withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            card.word,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 38 * scaleX,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    if (isShaking) {
      face = AnimatedBuilder(
        animation: _shakeAnim,
        builder: (ctx, child) =>
            Transform.translate(offset: Offset(_shakeAnim.value, 0), child: child),
        child: face,
      );
    }

    final content = isDone
        ? face
        : Draggable<int>(
            data: i,
            maxSimultaneousDrags: 1,
            feedback: Material(
              color: Colors.transparent,
              child: Opacity(
                opacity: 0.9,
                child: Transform.scale(
                  scale: 1.12,
                  child: Container(
                    width: cardW,
                    height: cardH,
                    decoration: BoxDecoration(
                      color: card.color,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        card.word,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 40 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            childWhenDragging: Opacity(opacity: 0.25, child: face),
            child: face,
          );

    return Positioned(
        left: cx - cardW / 2, top: cy - cardH / 2, child: content);
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          )
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _navBtn('التالي', Icons.arrow_back_rounded,
            _roundDone || _showCorrectAnswer, () {
          if (_roundDone || _showCorrectAnswer) {
            HapticFeedback.lightImpact();
            _advance();
          }
        }),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).popUntil((r) => r.isFirst);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child:
                const Icon(Icons.home_rounded, color: Colors.white, size: 28),
          ),
        ).animate().scale(
            begin: const Offset(0.9, 0.9),
            curve: Curves.easeOutBack,
            duration: 300.ms),
        _navBtn(
            'السابق',
            Icons.arrow_forward_rounded,
            _round > 0 && !_roundDone && !_showCorrectAnswer, () {
          if (_round > 0 && !_roundDone && !_showCorrectAnswer) {
            HapticFeedback.lightImpact();
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
        }),
      ]),
    );
  }

  Widget _navBtn(
      String label, IconData icon, bool enabled, VoidCallback onTap) {
    final isNext = label == 'التالي';
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: enabled ? const Color(0xFFE53935) : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(24),
            boxShadow: enabled
                ? [
                    BoxShadow(
                        color: Colors.red.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3))
                  ]
                : [],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (isNext) Icon(icon, color: Colors.white, size: 20),
            if (isNext) const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            if (!isNext) const SizedBox(width: 6),
            if (!isNext) Icon(icon, color: Colors.white, size: 20),
          ]),
        ),
      ),
    ).animate().scale(
        begin: const Offset(0.9, 0.9),
        curve: Curves.easeOutBack,
        duration: 300.ms);
  }

  Widget _topBar() => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _chip('⭐ $_score'),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _playInstruction,
          child: Container(
            padding: const EdgeInsets.all(9),
            decoration: const BoxDecoration(
                color: Colors.black54, shape: BoxShape.circle),
            child: const Icon(Icons.volume_up_rounded,
                color: Colors.white, size: 26),
          ),
        ),
        const SizedBox(width: 10),
        _chip('${_round + 1} / ${_rounds.length}'),
      ]);

  Widget _chip(String t) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20)),
        child: Text(t,
            style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      );

  Widget _gameOverScreen() => Stack(children: [
        Positioned.fill(
            child:
                Image.asset(_rounds.last.imagePath, fit: BoxFit.contain)),
        Positioned.fill(
            child: Container(
                color: Colors.black.withValues(alpha: 0.65))),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 50,
            gravity: 0.3,
            colors: const [
              Colors.yellow,
              Colors.green,
              Colors.red,
              Colors.purple,
              Colors.orange
            ],
          ),
        ),
        Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(_score == _rounds.length ? '🏆' : '🎯',
                    style: const TextStyle(fontSize: 90))
                .animate()
                .scale(
                    begin: const Offset(0, 0),
                    curve: Curves.elasticOut,
                    duration: 800.ms),
            const SizedBox(height: 20),
            Text(
              _score == _rounds.length
                  ? 'مُمْتَازٌ! طَابَقْتَ كُلَّ الْكَلِمَاتِ!'
                  : 'أَحْسَنْتَ! إِجَابَتُكَ: $_score / ${_rounds.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo'),
            ).animate(delay: 400.ms).fadeIn(),
            const SizedBox(height: 30),
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
                  _shakingCard = null;
                  _isDraggingOver = false;
                  _instructionPlayed = false;
                });
                Future.delayed(const Duration(milliseconds: 500),
                    _playInstructionOnce);
              },
              icon: const Icon(Icons.replay_rounded),
              label: const Text('الْعَبْ مَرَّةً أُخْرَى',
                  style:
                      TextStyle(fontFamily: 'Cairo', fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ).animate(delay: 700.ms).fadeIn().scale(
                begin: const Offset(0.8, 0.8)),
          ]),
        ),
      ]);
}
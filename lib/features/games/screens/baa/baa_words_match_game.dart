import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── لعبة الكلمات لحرف الباء ─────────────────────────────────────────────────
// مطابقة تماماً لشاشات الأسطوانة الأصلية ومحرك لعبة الكلمات لحرف الألف

const double _imgW = 1024;

class _WordCard {
  final String word;
  final bool isCorrect;
  final Color color;
  const _WordCard({
    required this.word,
    required this.isCorrect,
    required this.color,
  });
}

class _Round {
  final String imagePath;
  final double imgH;
  final double cardPx;
  final List<double> cardPyList;
  final double dropPx;
  final double dropPy;
  final String correctWord;
  final String wordAudio;
  final String praiseAudio;
  final List<_WordCard> cards;
  const _Round({
    required this.imagePath,
    required this.imgH,
    required this.cardPx,
    required this.cardPyList,
    required this.dropPx,
    required this.dropPy,
    required this.correctWord,
    required this.wordAudio,
    required this.praiseAudio,
    required this.cards,
  });
}

const List<_Round> _rounds = [
  // الجولة 1: بَقَرَة (1024 × 486)
  _Round(
    imagePath: 'assets/images/games/words/baa_words_round_1.png',
    imgH: 486,
    cardPx: 195.0,
    cardPyList: [125.0, 236.0, 350.0],
    dropPx: 643.0,
    dropPy: 394.0,
    correctWord: 'بَقَرَة',
    wordAudio: 'audio/lessons/baa/sounds/word_baqara.mp3',
    praiseAudio: 'audio/games/beehive/4_momt.mp3',
    cards: [
      _WordCard(word: 'أَسَد', isCorrect: false, color: Color(0xFF5AC8FA)),
      _WordCard(word: 'بَقَرَة', isCorrect: true,  color: Color(0xFFFF9EB5)),
      _WordCard(word: 'أَرْنَب', isCorrect: false, color: Color(0xFFFFD17A)),
    ],
  ),
  // الجولة 2: بَاب (1024 × 524)
  _Round(
    imagePath: 'assets/images/games/words/baa_words_round_2.png',
    imgH: 524,
    cardPx: 121.0,
    cardPyList: [140.0, 258.0, 385.0],
    dropPx: 598.0,
    dropPy: 442.0,
    correctWord: 'بَاب',
    wordAudio: 'audio/lessons/baa/sounds/word_bab.mp3',
    praiseAudio: 'audio/games/beehive/3_raa.mp3',
    cards: [
      _WordCard(word: 'بَاب', isCorrect: true,  color: Color(0xFF5AC8FA)),
      _WordCard(word: 'بُرْج', isCorrect: false, color: Color(0xFFFF9EB5)),
      _WordCard(word: 'بَلَح', isCorrect: false, color: Color(0xFFFFD17A)),
    ],
  ),
  // الجولة 3: بِطِّيخ (1024 × 574)
  _Round(
    imagePath: 'assets/images/games/words/baa_words_round_3.png',
    imgH: 574,
    cardPx: 136.0,
    cardPyList: [151.0, 280.0, 418.0],
    dropPx: 658.0,
    dropPy: 468.0,
    correctWord: 'بِطِّيخ',
    wordAudio: 'audio/lessons/baa/sounds/word_betteekh.mp3',
    praiseAudio: 'audio/games/beehive/2_sah.mp3',
    cards: [
      _WordCard(word: 'بِطِّيخ', isCorrect: true,  color: Color(0xFF5AC8FA)),
      _WordCard(word: 'بَلَح', isCorrect: false, color: Color(0xFFFF9EB5)),
      _WordCard(word: 'عِنَب', isCorrect: false, color: Color(0xFFFFD17A)),
    ],
  ),
  // الجولة 4: إِبْرَة (1024 × 538)
  _Round(
    imagePath: 'assets/images/games/words/baa_words_round_4.png',
    imgH: 538,
    cardPx: 132.0,
    cardPyList: [123.0, 254.0, 396.0],
    dropPx: 666.0,
    dropPy: 423.0,
    correctWord: 'إِبْرَة',
    wordAudio: 'audio/lessons/baa/sounds/word_ibra.mp3',
    praiseAudio: 'audio/games/beehive/4_momt.mp3',
    cards: [
      _WordCard(word: 'فَأْس', isCorrect: false, color: Color(0xFF5AC8FA)),
      _WordCard(word: 'قَلَم', isCorrect: false, color: Color(0xFFFF9EB5)),
      _WordCard(word: 'إِبْرَة', isCorrect: true,  color: Color(0xFFFFD17A)),
    ],
  ),
];

class BaaWordsMatchGame extends ConsumerStatefulWidget {
  const BaaWordsMatchGame({super.key});

  @override
  ConsumerState<BaaWordsMatchGame> createState() => _BaaWordsMatchGameState();
}

class _BaaWordsMatchGameState extends ConsumerState<BaaWordsMatchGame>
    with TickerProviderStateMixin {
  late ConfettiController _confetti;
  int _round = 0, _score = 0, _token = 0;
  bool _gameOver = false, _roundDone = false, _showCorrectAnswer = false;
  int _wrongAttempts = 0;
  String? _droppedWord;
  int? _shakingCard;
  bool _isDraggingOver = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(_shakeController);

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
    _shakeController.dispose();
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
    // صوت التعليمات: "اسحب اسم الصورة وضعها مكان النقط فيما يأتي" (5.08s)
    await _say('audio/instructions/words_drag_instruction.mp3', maxMs: 5600);
  }

  Future<void> _playWordAudio() async {
    await _say(_rounds[_round].wordAudio, maxMs: 2500);
  }

  Future<void> _playWrong() => _say('audio/games/fishing/hawe.mp3', maxMs: 2500);

  Future<void> _onCardSelected(int cardIdx) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.mediumImpact();
    final t = ++_token;
    final rd = _rounds[_round];
    final card = rd.cards[cardIdx];

    if (card.isCorrect) {
      setState(() {
        _roundDone = true;
        _score++;
        _droppedWord = card.word;
      });
      _confetti.play();

      // 1. صوت التشجيع الكامل دون بتر
      await _say(rd.praiseAudio, maxMs: 2500);
      if (!mounted || t != _token) return;

      // 2. سماع اسم الكلمة كاملاً بعد التشجيع (بَقَرَة / بَاب / بِطِّيخ / إِبْرَة)
      await _playWordAudio();
      if (!mounted || t != _token) return;
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted || t != _token) return;

      _advance();
    } else {
      setState(() {
        _shakingCard = cardIdx;
        _wrongAttempts++;
      });
      _shakeController.forward(from: 0);
      await _playWrong();
      if (!mounted || t != _token) return;

      if (_wrongAttempts >= 2) {
        setState(() {
          _showCorrectAnswer = true;
          _droppedWord = rd.correctWord;
        });

        // إظهار الحل مع سماع اسم الكلمة كاملاً دون تداخل صوتي
        await _say('audio/games/beehive/2_sah.mp3', maxMs: 2500);
        if (!mounted || t != _token) return;
        await _playWordAudio();
        if (!mounted || t != _token) return;
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted || t != _token) return;

        _advance();
      } else {
        setState(() {
          _shakingCard = null;
        });
      }
    }
  }

  void _advance() {
    _token++;
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
        _roundDone = false;
        _wrongAttempts = 0;
        _showCorrectAnswer = false;
        _droppedWord = null;
        _shakingCard = null;
        _isDraggingOver = false;
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
            final scaleX = dW / _imgW, scaleY = dH / rd.imgH;

            return Stack(
              children: [
                // صورة الشاشة الأصلية للأسطوانة
                Positioned.fill(
                  child: Image.asset(rd.imagePath, fit: BoxFit.contain),
                ),
                // منطقة إسقاط الكلمة (مكان النقط)
                _buildDropTarget(rd, ox, oy, scaleX, scaleY),
                // بطاقات الكلمات القابلة للسحب والنقر
                ...List.generate(
                  rd.cards.length,
                  (i) => _buildCardWidget(rd, i, ox, oy, scaleX, scaleY),
                ),
                // شريط الدرجات بالأعلى
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
            numberOfParticles: 30,
            gravity: 0.4,
            colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange],
          ),
        ),
      ],
    );
  }

  Widget _buildDropTarget(
    _Round rd,
    double ox,
    double oy,
    double scaleX,
    double scaleY,
  ) {
    final cx = ox + rd.dropPx * scaleX;
    final cy = oy + rd.dropPy * scaleY;
    const zW = 180.0, zH = 56.0;
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
          _onCardSelected(details.data);
        },
        builder: (ctx, candidates, rejected) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: hasWord
                  ? (_showCorrectAnswer ? Colors.amber.shade50 : Colors.green.shade50)
                  : (_isDraggingOver ? Colors.blue.shade50 : Colors.transparent),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hasWord
                    ? (_showCorrectAnswer ? Colors.amber.shade700 : Colors.green.shade600)
                    : (_isDraggingOver ? Colors.blue : Colors.transparent),
                width: _isDraggingOver || hasWord ? 3 : 0,
              ),
              boxShadow: hasWord
                  ? [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 6, offset: const Offset(0, 2))]
                  : [],
            ),
            child: hasWord
                ? Center(
                    child: Text(
                      _droppedWord!,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 28 * scaleX,
                        fontWeight: FontWeight.bold,
                        color: _showCorrectAnswer ? Colors.brown.shade800 : Colors.green.shade900,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildCardWidget(
    _Round rd,
    int i,
    double ox,
    double oy,
    double scaleX,
    double scaleY,
  ) {
    final card = rd.cards[i];
    final cx = ox + rd.cardPx * scaleX;
    final cy = oy + rd.cardPyList[i] * scaleY;
    const cW = 112.0, cH = 74.0;
    final cardW = cW * scaleX, cardH = cH * scaleY;
    final isShaking = _shakingCard == i;
    final isDone = _roundDone || _showCorrectAnswer;

    Widget cardFace = Container(
      width: cardW,
      height: cardH,
      decoration: BoxDecoration(
        color: Colors.transparent, // شفاف ليظهر كرت الأسطوانة المرسوم تحتها تماماً
        borderRadius: BorderRadius.circular(14),
      ),
    );

    // بطاقة قابلة للسحب والنقر معاً
    Widget interactiveCard = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onCardSelected(i),
      child: Draggable<int>(
        data: i,
        maxSimultaneousDrags: isDone ? 0 : 1,
        feedback: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: card.color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              card.word,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24 * scaleX,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        childWhenDragging: Opacity(opacity: 0.3, child: cardFace),
        child: cardFace,
      ),
    );

    if (isShaking) {
      return Positioned(
        left: cx - cardW / 2,
        top: cy - cardH / 2,
        child: AnimatedBuilder(
          animation: _shakeAnim,
          builder: (context, child) => Transform.translate(
            offset: Offset(_shakeAnim.value, 0),
            child: Container(
              width: cardW,
              height: cardH,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent, width: 3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: child,
            ),
          ),
          child: interactiveCard,
        ),
      );
    }

    return Positioned(
      left: cx - cardW / 2,
      top: cy - cardH / 2,
      child: interactiveCard,
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
              _token++;
              AudioService.instance.stop();
              setState(() {
                if (_round > 0) _round--;
                _roundDone = false;
                _wrongAttempts = 0;
                _showCorrectAnswer = false;
                _droppedWord = null;
                _shakingCard = null;
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
                      _roundDone = false;
                      _wrongAttempts = 0;
                      _showCorrectAnswer = false;
                      _droppedWord = null;
                      _shakingCard = null;
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

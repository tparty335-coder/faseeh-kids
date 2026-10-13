import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// لعبة الكلمات: اسحب اسم الصورة الصحيح إلى مكانه (drag & drop)
// بنفس منطق words_match_game.dart لحرف الألف، لكن بصور الباء


class _WordCard {
  final String word;
  final bool isCorrect;
  final Color color;
  final String audioPath;
  const _WordCard({
    required this.word,
    required this.isCorrect,
    required this.color,
    required this.audioPath,
  });
}

class _Round {
  final String imagePath; // صورة الأسطوانة
  final String pictureLabel; // الكلمة الصحيحة
  final List<_WordCard> cards;
  const _Round({
    required this.imagePath,
    required this.pictureLabel,
    required this.cards,
  });
}

const List<_Round> _rounds = [
  _Round(
    imagePath: 'assets/images/lessons/baa/sounds/baqara.png',
    pictureLabel: 'بَقَرَة',
    cards: [
      _WordCard(word: 'بَقَرَة', isCorrect: true,  color: Color(0xFFFF9EB5),
          audioPath: 'audio/lessons/baa/sounds/word_baqara.mp3'),
      _WordCard(word: 'أَسَد',  isCorrect: false, color: Color(0xFF5AC8FA),
          audioPath: 'audio/lessons/baa/sounds/word_baqara.mp3'),
      _WordCard(word: 'أَرْنَب', isCorrect: false, color: Color(0xFFFFD17A),
          audioPath: 'audio/lessons/baa/sounds/word_baqara.mp3'),
    ],
  ),
  _Round(
    imagePath: 'assets/images/lessons/baa/sounds/tabeeb.png',
    pictureLabel: 'طَبِيب',
    cards: [
      _WordCard(word: 'طَبِيب', isCorrect: true,  color: Color(0xFF5AC8FA),
          audioPath: 'audio/lessons/baa/sounds/word_tabeeb.mp3'),
      _WordCard(word: 'بَاب',   isCorrect: false, color: Color(0xFFFF9EB5),
          audioPath: 'audio/lessons/baa/sounds/word_tabeeb.mp3'),
      _WordCard(word: 'بِنْت',  isCorrect: false, color: Color(0xFFFFD17A),
          audioPath: 'audio/lessons/baa/sounds/word_tabeeb.mp3'),
    ],
  ),
  _Round(
    imagePath: 'assets/images/lessons/baa/sounds/borg.png',
    pictureLabel: 'بُرْج',
    cards: [
      _WordCard(word: 'نَحْلَة', isCorrect: false, color: Color(0xFFFFD17A),
          audioPath: 'audio/lessons/baa/sounds/word_borg.mp3'),
      _WordCard(word: 'بُرْج',   isCorrect: true,  color: Color(0xFF5AC8FA),
          audioPath: 'audio/lessons/baa/sounds/word_borg.mp3'),
      _WordCard(word: 'قِطَّة',  isCorrect: false, color: Color(0xFFFF9EB5),
          audioPath: 'audio/lessons/baa/sounds/word_borg.mp3'),
    ],
  ),
  _Round(
    imagePath: 'assets/images/lessons/baa/sounds/hobob.png',
    pictureLabel: 'حُبُوب',
    cards: [
      _WordCard(word: 'حُبُوب',  isCorrect: true,  color: Color(0xFFFF9EB5),
          audioPath: 'audio/lessons/baa/sounds/word_hobob.mp3'),
      _WordCard(word: 'بَقَرَة', isCorrect: false, color: Color(0xFF5AC8FA),
          audioPath: 'audio/lessons/baa/sounds/word_hobob.mp3'),
      _WordCard(word: 'طَبِيب',  isCorrect: false, color: Color(0xFFFFD17A),
          audioPath: 'audio/lessons/baa/sounds/word_hobob.mp3'),
    ],
  ),
  _Round(
    imagePath: 'assets/images/lessons/baa/sounds/yaktb.png',
    pictureLabel: 'يَكْتُب',
    cards: [
      _WordCard(word: 'بَاب',   isCorrect: false, color: Color(0xFFFFD17A),
          audioPath: 'audio/lessons/baa/sounds/word_yaktb.mp3'),
      _WordCard(word: 'بُرْج',  isCorrect: false, color: Color(0xFFFF9EB5),
          audioPath: 'audio/lessons/baa/sounds/word_yaktb.mp3'),
      _WordCard(word: 'يَكْتُب', isCorrect: true, color: Color(0xFF5AC8FA),
          audioPath: 'audio/lessons/baa/sounds/word_yaktb.mp3'),
    ],
  ),
];

class BaaWordsMatchGame extends ConsumerStatefulWidget {
  const BaaWordsMatchGame({super.key});
  @override
  ConsumerState<BaaWordsMatchGame> createState() => _BaaWordsMatchGameState();
}

class _BaaWordsMatchGameState extends ConsumerState<BaaWordsMatchGame> {
  late ConfettiController _confetti;
  int _round = 0, _score = 0;
  int? _selected;
  bool _roundDone = false, _gameOver = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 600), _playInstruction);
    });
  }

  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  Future<void> _playInstruction() async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(
        'audio/lessons/baa/medium/baa_56.mp3', // "أمامك مجموعة من"
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  Future<void> _playWordAudio(String path) async {
    try {
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  Future<void> _onTap(int idx) async {
    if (_roundDone) return;
    HapticFeedback.lightImpact();
    final card = _rounds[_round].cards[idx];
    setState(() { _selected = idx; _roundDone = true; });

    await _playWordAudio(card.audioPath);
    await Future.delayed(const Duration(milliseconds: 600));

    if (card.isCorrect) {
      _score++;
      _confetti.play();
      await AudioService.instance.playAsset(
        'audio/lessons/baa/short/baa_13.mp3', channel: AudioChannel.sfx);
    } else {
      await AudioService.instance.playAsset(
        'audio/lessons/baa/medium/baa_51.mp3', channel: AudioChannel.sfx);
    }
    await Future.delayed(const Duration(milliseconds: 1400));
    _nextRound();
  }

  void _nextRound() {
    if (_round < _rounds.length - 1) {
      setState(() { _round++; _selected = null; _roundDone = false; });
      Future.delayed(const Duration(milliseconds: 400), _playInstruction);
    } else {
      setState(() => _gameOver = true);
      _confetti.play();
      AudioService.instance.playAsset(
        'audio/lessons/baa/short/baa_20.mp3', channel: AudioChannel.voice);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver(context);
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;
    final round = _rounds[_round];

    return Stack(
      children: [
        // ── خلفية الأسطوانة ───────────────────────────────────────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_drag_words.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // ── صورة الكلمة + خيارات ─────────────────────────────────────────
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                // ── الخيارات على اليمين ────────────────────────────────
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: round.cards.asMap().entries.map((e) {
                    final idx = e.key;
                    final card = e.value;
                    final isSel = _selected == idx;
                    final isCorrect = card.isCorrect;
                    Color bg = card.color;
                    if (_roundDone && isSel) {
                      bg = isCorrect ? Colors.green.shade600 : Colors.red.shade600;
                    } else if (_roundDone && isCorrect) {
                      bg = Colors.green.shade600;
                    }
                    return GestureDetector(
                      onTap: () => _onTap(idx),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: isTablet ? 180 : 140,
                        height: isTablet ? 70 : 56,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSel ? Colors.white : Colors.white54,
                            width: isSel ? 3 : 1,
                          ),
                          boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black26, offset: const Offset(0, 3))],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          card.word,
                          style: TextStyle(
                            fontSize: isTablet ? 26 : 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                      ).animate(delay: Duration(milliseconds: idx * 80))
                          .fadeIn(duration: 300.ms)
                          .slideX(begin: 0.3),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 16),
                // ── صورة الكلمة في الوسط ──────────────────────────────
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            round.imagePath,
                            fit: BoxFit.contain,
                          ),
                        ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9)),
                      ),
                      const SizedBox(height: 8),
                      // مؤشر التقدم
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_rounds.length, (i) => Container(
                          width: 14, height: 14,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i < _round ? Colors.green : i == _round ? Colors.amber : Colors.white54,
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // ── كونفيتي ─────────────────────────────────────────────────────
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 20,
            colors: const [Colors.red, Colors.amber, Colors.green, Colors.blue],
          ),
        ),
      ],
    );
  }

  Widget _buildGameOver(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌟', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            'ممتاز! نتيجتك $_score/${_rounds.length}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                fontFamily: 'Cairo', color: Color(0xFF1565C0)),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => setState(() {
              _round = 0; _score = 0; _gameOver = false;
              _selected = null; _roundDone = false;
            }),
            icon: const Icon(Icons.replay_rounded),
            label: const Text('العب مرة أخرى', style: TextStyle(fontFamily: 'Cairo', fontSize: 20)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
    );
  }
}

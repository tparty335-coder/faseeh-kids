import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// لعبة التلوين: اضغط على الكلمة التي بها مد
// مطابقة للأسطوانة: "التلوين - اضغط على الكلمة التي بها مد"

class _MaddOption {
  final String word;
  final bool hasMadd;
  const _MaddOption({required this.word, required this.hasMadd});
}

class _ColoringRound {
  final String imagePath; // صورة الكلمة للتلوين
  final List<_MaddOption> options;
  final String correctWord;
  final String wordAudio;
  const _ColoringRound({
    required this.imagePath,
    required this.options,
    required this.correctWord,
    required this.wordAudio,
  });
}

const List<_ColoringRound> _rounds = [
  _ColoringRound(
    imagePath: 'assets/images/lessons/baa/sounds/tabeeb.png',
    options: [
      _MaddOption(word: 'بَقَرَة', hasMadd: false),
      _MaddOption(word: 'طَبِيب',  hasMadd: true),  // ← مد بالياء طَبِيب
      _MaddOption(word: 'بِنْت',   hasMadd: false),
    ],
    correctWord: 'طَبِيب',
    wordAudio: 'audio/lessons/baa/sounds/word_tabeeb.mp3',
  ),
  _ColoringRound(
    imagePath: 'assets/images/lessons/baa/sounds/hobob.png',
    options: [
      _MaddOption(word: 'حُبُوب',  hasMadd: true),  // ← مد بالواو حُبُوب
      _MaddOption(word: 'بُرْج',   hasMadd: false),
      _MaddOption(word: 'أَرْنَب', hasMadd: false),
    ],
    correctWord: 'حُبُوب',
    wordAudio: 'audio/lessons/baa/sounds/word_hobob.mp3',
  ),
  _ColoringRound(
    imagePath: 'assets/images/lessons/baa/sounds/bab.png',
    options: [
      _MaddOption(word: 'بِنْت',   hasMadd: false),
      _MaddOption(word: 'نَحْلَة', hasMadd: false),
      _MaddOption(word: 'بَاب',   hasMadd: true),   // ← مد بالألف بَاب
    ],
    correctWord: 'بَاب',
    wordAudio: 'audio/lessons/baa/sounds/word_bab.mp3',
  ),
];

// ألوان لوحة التلوين
const List<Color> _palette = [
  Color(0xFFE53935), Color(0xFF43A047), Color(0xFF1E88E5),
  Color(0xFF8E24AA), Color(0xFFFDD835), Color(0xFFFB8C00),
  Color(0xFFE91E63), Color(0xFF00ACC1),
];

class BaaColoringGame extends ConsumerStatefulWidget {
  const BaaColoringGame({super.key});
  @override
  ConsumerState<BaaColoringGame> createState() => _BaaColoringGameState();
}

class _BaaColoringGameState extends ConsumerState<BaaColoringGame> {
  late ConfettiController _confetti;
  int _round = 0, _score = 0;
  int? _selected;
  bool _roundDone = false, _gameOver = false;
  Color _paintColor = const Color(0xFFE53935);
  Color _bgColor = Colors.white;
  bool _isPainted = false;

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
        'audio/lessons/baa/medium/baa_56.mp3',
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  Future<void> _onSelect(int idx) async {
    if (_roundDone) return;
    HapticFeedback.lightImpact();
    final opt = _rounds[_round].options[idx];
    setState(() { _selected = idx; _roundDone = true; });

    if (opt.hasMadd) {
      _score++;
      setState(() { _bgColor = _paintColor; _isPainted = true; });
      _confetti.play();
      try {
        await AudioService.instance.playAsset(
          _rounds[_round].wordAudio, channel: AudioChannel.voice);
      } catch (_) {}
      await Future.delayed(const Duration(milliseconds: 800));
      try {
        await AudioService.instance.playAsset(
          'audio/lessons/baa/short/baa_13.mp3', channel: AudioChannel.sfx);
      } catch (_) {}
    } else {
      try {
        await AudioService.instance.playAsset(
          'audio/lessons/baa/medium/baa_51.mp3', channel: AudioChannel.sfx);
      } catch (_) {}
    }
    await Future.delayed(const Duration(milliseconds: 1600));
    _nextRound();
  }

  void _nextRound() {
    if (_round < _rounds.length - 1) {
      setState(() {
        _round++; _selected = null; _roundDone = false;
        _bgColor = Colors.white; _isPainted = false;
      });
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
        // ── خلفية الأسطوانة ────────────────────────────────────────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_coloring.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // ── المحتوى ────────────────────────────────────────────────────────
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                'اضغط على الكلمة التي بها مَد:',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 18,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const [Shadow(blurRadius: 4, color: Colors.black87)],
                ),
              ),
              const SizedBox(height: 8),
              // ── لوحة التلوين ──────────────────────────────────────────────
              Expanded(
                flex: 3,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: _bgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.brown.shade300, width: 3),
                    boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: ColorFiltered(
                      colorFilter: _isPainted
                          ? ColorFilter.mode(_paintColor.withValues(alpha: 0.35), BlendMode.multiply)
                          : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                      child: Image.asset(round.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // ── لوحة الألوان ──────────────────────────────────────────────
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: _palette.map((c) => GestureDetector(
                    onTap: () => setState(() => _paintColor = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40, height: 40,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: _paintColor == c
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                        boxShadow: [BoxShadow(blurRadius: 4, color: c.withValues(alpha: 0.5))],
                      ),
                    ),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 12),
              // ── خيارات الكلمات ────────────────────────────────────────────
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: round.options.asMap().entries.map((e) {
                    final idx = e.key;
                    final opt = e.value;
                    final isSel = _selected == idx;
                    Color bg = const Color(0xFF795548);
                    if (_roundDone && isSel) {
                      bg = opt.hasMadd ? Colors.green.shade700 : Colors.red.shade700;
                    } else if (_roundDone && opt.hasMadd) {
                      bg = Colors.green.shade700;
                    }
                    return GestureDetector(
                      onTap: () => _onSelect(idx),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSel ? Colors.white : Colors.white54,
                            width: isSel ? 3 : 1,
                          ),
                          boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black38, offset: const Offset(0, 3))],
                        ),
                        child: Text(
                          opt.word,
                          style: TextStyle(
                            fontSize: isTablet ? 28 : 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                      ).animate(delay: Duration(milliseconds: idx * 80))
                          .fadeIn(duration: 300.ms)
                          .scale(begin: const Offset(0.85, 0.85), curve: Curves.easeOutBack),
                    );
                  }).toList(),
                ),
              ),
              // ── مؤشر التقدم ───────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_rounds.length, (i) => Container(
                  width: 14, height: 14,
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < _round ? Colors.green : i == _round ? Colors.amber : Colors.white54,
                  ),
                )),
              ),
            ],
          ),
        ),
        // ── كونفيتي ─────────────────────────────────────────────────────────
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 25,
            colors: const [Colors.red, Colors.amber, Colors.green, Colors.blue, Colors.purple],
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
          const Text('🎨', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            'ممتاز! نتيجتك $_score/${_rounds.length}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                fontFamily: 'Cairo', color: Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => setState(() {
              _round = 0; _score = 0; _gameOver = false;
              _selected = null; _roundDone = false;
              _bgColor = Colors.white; _isPainted = false;
            }),
            icon: const Icon(Icons.replay_rounded),
            label: const Text('العب مرة أخرى', style: TextStyle(fontFamily: 'Cairo', fontSize: 20)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
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

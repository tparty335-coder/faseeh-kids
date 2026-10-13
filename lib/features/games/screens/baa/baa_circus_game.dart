import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

const double _imgW = 800, _imgH = 600;

class _ImageZone {
  final String label;
  final bool hasBaa;
  final double px, py;
  final String? wordAudio; // صوت الكلمة من الأسطوانة
  const _ImageZone({
    required this.label,
    required this.hasBaa,
    required this.px,
    required this.py,
    this.wordAudio,
  });
}

class _Round {
  final String imagePath;
  final List<_ImageZone> zones;
  const _Round({required this.imagePath, required this.zones});
}

// التعليمات: "اضغط على الصورة التي بها حرف ب"
const List<_Round> _rounds = [
  _Round(
    imagePath: 'assets/images/lessons/baa/baa_circus.jpg',
    zones: [
      _ImageZone(label: 'بَقَرَة', hasBaa: true,  px: 200, py: 200,
          wordAudio: 'audio/lessons/baa/sounds/word_baqara.mp3'),
      _ImageZone(label: 'كَلْب',  hasBaa: false, px: 450, py: 380),
      _ImageZone(label: 'نَحْلَة', hasBaa: false, px: 200, py: 560),
    ],
  ),
  _Round(
    imagePath: 'assets/images/lessons/baa/baa_circus.jpg',
    zones: [
      _ImageZone(label: 'قِطَّة',  hasBaa: false, px: 200, py: 200),
      _ImageZone(label: 'بَاب',    hasBaa: true,  px: 450, py: 380,
          wordAudio: 'audio/lessons/baa/sounds/word_bab.mp3'),
      _ImageZone(label: 'جَمَل',   hasBaa: false, px: 200, py: 560),
    ],
  ),
  _Round(
    imagePath: 'assets/images/lessons/baa/baa_circus.jpg',
    zones: [
      _ImageZone(label: 'طَبِيب',  hasBaa: true,  px: 200, py: 200,
          wordAudio: 'audio/lessons/baa/sounds/word_tabeeb.mp3'),
      _ImageZone(label: 'حِمَار',  hasBaa: false, px: 450, py: 380),
      _ImageZone(label: 'نَمِر',   hasBaa: false, px: 200, py: 560),
    ],
  ),
];

class BaaCircusGame extends ConsumerStatefulWidget {
  const BaaCircusGame({super.key});
  @override
  ConsumerState<BaaCircusGame> createState() => _BaaCircusGameState();
}

class _BaaCircusGameState extends ConsumerState<BaaCircusGame> {
  late ConfettiController _confetti;
  int _round = 0, _score = 0, _wrongAttempts = 0;
  int? _tapped;
  bool _roundDone = false, _gameOver = false, _showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Future.delayed(const Duration(milliseconds: 700), _playInstruction));
  }

  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  Future<void> _playInstruction() async {
    try {
      await AudioService.instance.stop();
      // "أمامك مجموعة من" — تعليمات النشاط
      await AudioService.instance.playAsset(
        'audio/lessons/baa/medium/baa_56.mp3',
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  Future<void> _playCorrect() => AudioService.instance.playAsset(
    'audio/lessons/baa/short/baa_13.mp3', channel: AudioChannel.sfx);
  Future<void> _playWrong() => AudioService.instance.playAsset(
    'audio/lessons/baa/medium/baa_51.mp3', channel: AudioChannel.sfx);
  Future<void> _playPraise() => AudioService.instance.playAsset(
    'audio/lessons/baa/short/baa_20.mp3', channel: AudioChannel.voice);

  Future<void> _onTap(int idx) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.lightImpact();
    final zone = _rounds[_round].zones[idx];

    if (zone.hasBaa) {
      setState(() { _tapped = idx; _roundDone = true; _score++; });
      _confetti.play();
      if (zone.wordAudio != null) {
        await AudioService.instance.playAsset(zone.wordAudio!, channel: AudioChannel.voice);
      } else {
        await _playCorrect();
      }
      await Future.delayed(const Duration(milliseconds: 1800));
      _nextRound();
    } else {
      setState(() { _tapped = idx; _wrongAttempts++; });
      await _playWrong();
      await Future.delayed(const Duration(milliseconds: 900));
      if (mounted) setState(() => _tapped = null);
      if (_wrongAttempts >= 2) {
        setState(() => _showCorrectAnswer = true);
        await Future.delayed(const Duration(milliseconds: 2200));
        _nextRound();
      }
    }
  }

  void _nextRound() {
    if (_round < _rounds.length - 1) {
      setState(() {
        _round++; _roundDone = false; _tapped = null;
        _showCorrectAnswer = false; _wrongAttempts = 0;
      });
      Future.delayed(const Duration(milliseconds: 400), _playInstruction);
    } else {
      setState(() => _gameOver = true);
      _confetti.play();
      Future.delayed(const Duration(milliseconds: 500), _playPraise);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver(context);
    return _buildGame(context);
  }

  Widget _buildGame(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final round = _rounds[_round];

    return Stack(
      children: [
        Positioned.fill(child: Image.asset(round.imagePath, fit: BoxFit.cover)),
        ...round.zones.asMap().entries.map((e) {
          final idx = e.key;
          final zone = e.value;
          final scaleX = size.width / _imgW;
          final scaleY = size.height / _imgH;
          final isTapped = _tapped == idx;
          final showGreen = _showCorrectAnswer && zone.hasBaa;

          return Positioned(
            left: zone.px * scaleX - 80,
            top: zone.py * scaleY - 40,
            child: GestureDetector(
              onTap: () => _onTap(idx),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 160, height: 80,
                decoration: BoxDecoration(
                  color: isTapped
                      ? (zone.hasBaa
                          ? Colors.green.withValues(alpha: 0.85)
                          : Colors.red.withValues(alpha: 0.75))
                      : showGreen
                          ? Colors.green.withValues(alpha: 0.85)
                          : Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: (isTapped || showGreen)
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.4),
                    width: (isTapped || showGreen) ? 3 : 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  zone.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: (isTapped || showGreen)
                        ? Colors.white
                        : Colors.yellow.shade100,
                    fontFamily: 'Cairo',
                    shadows: const [Shadow(blurRadius: 4, color: Colors.black54)],
                  ),
                ),
              ),
            ),
          );
        }),
        Positioned(
          top: 16, left: 16,
          child: Row(
            children: List.generate(_rounds.length, (i) => Container(
              width: 18, height: 18,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < _round ? Colors.green : i == _round ? Colors.amber : Colors.white.withValues(alpha: 0.5),
              ),
            )),
          ),
        ),
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
          const Text('🎉', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            'أحسنت! نتيجتك $_score/${_rounds.length}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                fontFamily: 'Cairo', color: Color(0xFFC62828)),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => setState(() {
              _round = 0; _score = 0; _gameOver = false;
              _roundDone = false; _tapped = null;
              _showCorrectAnswer = false; _wrongAttempts = 0;
            }),
            icon: const Icon(Icons.replay_rounded),
            label: const Text('العب مرة أخرى',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 20)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
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

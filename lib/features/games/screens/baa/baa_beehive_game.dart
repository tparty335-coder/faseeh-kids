import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// لعبة الخلية: اضغط على الشكل الصحيح لحرف الباء حسب موضعه في الكلمة
// التعليمات من الأسطوانة: خلية الحروف

class _BeehiveRound {
  final String word;         // الكلمة المعروضة
  final String correctForm;  // الشكل الصحيح: 'start'/'middle'/'end'/'alone'
  final String wordAudio;
  const _BeehiveRound({
    required this.word,
    required this.correctForm,
    required this.wordAudio,
  });
}

const List<_BeehiveRound> _rounds = [
  _BeehiveRound(word: 'بَقَرَة',  correctForm: 'start',  wordAudio: 'audio/lessons/baa/sounds/word_baqara.mp3'),
  _BeehiveRound(word: 'طَبِيب',  correctForm: 'middle', wordAudio: 'audio/lessons/baa/sounds/word_tabeeb.mp3'),
  _BeehiveRound(word: 'بَاب',    correctForm: 'start',  wordAudio: 'audio/lessons/baa/sounds/word_bab.mp3'),
  _BeehiveRound(word: 'حُبُوب',  correctForm: 'middle', wordAudio: 'audio/lessons/baa/sounds/word_hobob.mp3'),
  _BeehiveRound(word: 'يَكْتُب', correctForm: 'end',    wordAudio: 'audio/lessons/baa/sounds/word_yaktb.mp3'),
];

// أشكال الحرف حسب الموضع
const Map<String, String> _formLabels = {
  'alone':  'بْ\nمفردة',
  'start':  'بـ\nأول',
  'middle': 'ـبـ\nوسط',
  'end':    'ـب\nآخر',
};

const Map<String, Color> _formColors = {
  'alone':  Color(0xFF6A1B9A),
  'start':  Color(0xFF1565C0),
  'middle': Color(0xFF2E7D32),
  'end':    Color(0xFFC62828),
};

class BaaBeeHiveGame extends ConsumerStatefulWidget {
  const BaaBeeHiveGame({super.key});
  @override
  ConsumerState<BaaBeeHiveGame> createState() => _BaaBeeHiveGameState();
}

class _BaaBeeHiveGameState extends ConsumerState<BaaBeeHiveGame> {
  late ConfettiController _confetti;
  int _round = 0, _score = 0;
  String? _selected;
  bool _roundDone = false, _gameOver = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 600), _playWordAudio);
    });
  }

  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  Future<void> _playWordAudio() async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(
        _rounds[_round].wordAudio,
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  Future<void> _playCorrect() => AudioService.instance.playAsset(
    'audio/lessons/baa/short/baa_13.mp3', channel: AudioChannel.sfx);
  Future<void> _playWrong() => AudioService.instance.playAsset(
    'audio/lessons/baa/medium/baa_51.mp3', channel: AudioChannel.sfx);
  Future<void> _playPraise() => AudioService.instance.playAsset(
    'audio/lessons/baa/short/baa_69.mp3', channel: AudioChannel.voice);

  Future<void> _onSelect(String form) async {
    if (_roundDone) return;
    HapticFeedback.lightImpact();
    setState(() { _selected = form; _roundDone = true; });
    final isCorrect = form == _rounds[_round].correctForm;
    if (isCorrect) {
      _score++;
      _confetti.play();
      await _playCorrect();
    } else {
      await _playWrong();
    }
    await Future.delayed(const Duration(milliseconds: 1600));
    _nextRound();
  }

  void _nextRound() {
    if (_round < _rounds.length - 1) {
      setState(() {
        _round++; _selected = null; _roundDone = false;
      });
      Future.delayed(const Duration(milliseconds: 400), _playWordAudio);
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
    final isTablet = size.width > 600;
    final round = _rounds[_round];

    return Stack(
      children: [
        // ── الخلفية (صورة من الأسطوانة) ─────────────────────────────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_wheel.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // ── المحتوى الرئيسي ──────────────────────────────────────────────────
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // ── الكلمة المعروضة ──────────────────────────────────────────
              GestureDetector(
                onTap: _playWordAudio,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withValues(alpha: 0.2))],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        round.word,
                        style: TextStyle(
                          fontSize: isTablet ? 56 : 44,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: const Color(0xFF1A237E),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.volume_up_rounded, color: Color(0xFF1565C0), size: 32),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.3),
              ),
              const SizedBox(height: 12),
              Text(
                'أين حرف الباء في هذه الكلمة؟',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 18,
                  fontFamily: 'Cairo',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  shadows: const [Shadow(blurRadius: 4, color: Colors.black87)],
                ),
              ),
              // ── مؤشر التقدم ───────────────────────────────────────────────
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_rounds.length, (i) => Container(
                  width: 16, height: 16,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < _round ? Colors.green : i == _round ? Colors.amber : Colors.white54,
                  ),
                )),
              ),
              const Spacer(),
              // ── أزرار الاختيار ────────────────────────────────────────────
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: _formLabels.keys.map((form) {
                  final isSelected = _selected == form;
                  final isCorrect = form == round.correctForm;
                  Color btnColor = _formColors[form]!;
                  if (_roundDone && isSelected) {
                    btnColor = isCorrect ? Colors.green.shade700 : Colors.red.shade700;
                  } else if (_roundDone && isCorrect) {
                    btnColor = Colors.green.shade700;
                  }

                  return GestureDetector(
                    onTap: () => _onSelect(form),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: isTablet ? 150 : 130,
                      height: isTablet ? 130 : 110,
                      decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.white54,
                          width: isSelected ? 4 : 2,
                        ),
                        boxShadow: [BoxShadow(blurRadius: 8, color: btnColor.withValues(alpha: 0.5), offset: const Offset(0, 4))],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _formLabels[form]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ).animate(delay: Duration(milliseconds: _formLabels.keys.toList().indexOf(form) * 80))
                        .fadeIn(duration: 300.ms)
                        .scale(begin: const Offset(0.85, 0.85), curve: Curves.easeOutBack),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
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
          const Text('🏆', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            'رائع! نتيجتك $_score/${_rounds.length}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                fontFamily: 'Cairo', color: Color(0xFFF9A825)),
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
              backgroundColor: const Color(0xFFF9A825),
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

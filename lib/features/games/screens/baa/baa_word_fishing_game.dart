import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';

// ─── بيانات الأسماك والكلمات ────────────────────────────────────────────────
class _RoundData {
  final List<String> words;
  const _RoundData({required this.words});
}

const List<_RoundData> _rounds = [
  _RoundData(words: ['أَرْنَب', 'أَسَد', 'فَأْس']),
  _RoundData(words: ['بَقَرَة', 'أَسَد', 'قِرْد']), // قرد بدلاً من كلب لضمان إجابة واحدة صحيحة
  _RoundData(words: ['تِين', 'بَاب', 'نَحْلَة']),
  _RoundData(words: ['ذَيْل', 'جَمَل', 'طَبِيب']),
];

const List<Color> _fishColors = [
  Color(0xFFE53935), // أحمر
  Color(0xFF1E88E5), // أزرق
  Color(0xFF43A047), // أخضر
  Color(0xFFFF8F00), // برتقالي
  Color(0xFF8E24AA), // بنفسجي
];

class BaaWordFishingGame extends ConsumerStatefulWidget {
  const BaaWordFishingGame({super.key});

  @override
  ConsumerState<BaaWordFishingGame> createState() => _BaaWordFishingGameState();
}

class _BaaWordFishingGameState extends ConsumerState<BaaWordFishingGame> {
  late ConfettiController _confetti;

  int _round = 0;
  bool _roundDone = false;
  bool _gameOver = false;
  String? _tappedWord;
  int _wrongAttempts = 0;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 600), _playInstruction);
    });
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  bool _hasBaa(String word) {
    // إزالة التشكيل للبحث عن حرف الباء
    final normalized = word.replaceAll(RegExp(r'[\u064B-\u065F]'), '');
    return normalized.contains('ب');
  }

  Future<void> _playInstruction() async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(
        'audio/lessons/baa/short/baa_11.mp3', // "صيد الكلمات" أو تعليمات الصيد
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  Future<void> _playCorrect() async {
    try {
      await AudioService.instance.playAsset(
        'audio/lessons/baa/short/baa_13.mp3', // "إجابة صحيحة"
        channel: AudioChannel.sfx,
      );
    } catch (_) {}
  }

  Future<void> _playWrong() async {
    try {
      await AudioService.instance.playAsset(
        'audio/lessons/baa/medium/baa_51.mp3', // "حاول مرة أخرى"
        channel: AudioChannel.sfx,
      );
    } catch (_) {}
  }

  Future<void> _playPraise() async {
    try {
      await AudioService.instance.playAsset(
        'audio/lessons/baa/short/baa_20.mp3', // "ممتاز"
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  Future<void> _onFishTap(String word) async {
    if (_roundDone) return;
    HapticFeedback.lightImpact();

    if (_hasBaa(word)) {
      setState(() {
        _tappedWord = word;
        _roundDone = true;
      });
      _confetti.play();
      await _playCorrect();
      await Future.delayed(const Duration(milliseconds: 2000));
      _nextRound();
    } else {
      setState(() {
        _tappedWord = word;
        _wrongAttempts++;
      });
      await _playWrong();
      await Future.delayed(const Duration(milliseconds: 1000));
      if (mounted) setState(() => _tappedWord = null);
      
      // مساعدة بعد خطأين
      if (_wrongAttempts >= 2) {
        final correctWord = _rounds[_round].words.firstWhere((w) => _hasBaa(w));
        setState(() {
          _tappedWord = correctWord;
          _roundDone = true;
        });
        await Future.delayed(const Duration(milliseconds: 2000));
        _nextRound();
      }
    }
  }

  void _nextRound() {
    if (_round < _rounds.length - 1) {
      setState(() {
        _round++;
        _roundDone = false;
        _tappedWord = null;
        _wrongAttempts = 0;
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
    final round = _rounds[_round];

    // مواقع عشوائية للأسماك لتبدو ديناميكية
    final List<Alignment> positions = [
      const Alignment(-0.7, 0.4),
      const Alignment(0.0, 0.6),
      const Alignment(0.7, 0.3),
    ];

    return Stack(
      children: [
        // ─── خلفية اللعبة النظيفة المستخرجة ─────────────────────────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_fishing_bg_clean.jpg',
            fit: BoxFit.cover,
          ),
        ),

        // ─── زر الخروج ─────────────────────────────────────────────────────
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white, size: 32),
            style: IconButton.styleFrom(
              backgroundColor: Colors.black.withValues(alpha: 0.3),
              padding: const EdgeInsets.all(12),
            ),
            onPressed: () {
              AudioService.instance.stop();
              Navigator.of(context).pop();
            },
          ),
        ),

        // ─── الأسماك الديناميكية ───────────────────────────────────────────
        for (int i = 0; i < round.words.length; i++)
          Align(
            alignment: positions[i],
            child: _FloatingFish(
              word: round.words[i],
              color: _fishColors[i % _fishColors.length],
              delay: i * 0.3,
              isCorrect: _roundDone && _hasBaa(round.words[i]),
              isWrong: _tappedWord == round.words[i] && !_hasBaa(round.words[i]),
              onTap: () => _onFishTap(round.words[i]),
            ),
          ),

        // ─── العنوان ───────────────────────────────────────────────────────
        SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade800.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Text(
                'اِضْغَطْ عَلَى الْكَلِمَةِ الَّتِي بِهَا حَرْفُ (ب)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.white,
                ),
              ),
            ).animate().slideY(begin: -1, duration: 600.ms, curve: Curves.easeOutBack),
          ),
        ),

        // ─── مؤشر التقدم ───────────────────────────────────────────────────
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_rounds.length, (i) {
              return Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < _round
                      ? Colors.green
                      : i == _round
                          ? Colors.amber
                          : Colors.white.withValues(alpha: 0.5),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black45, blurRadius: 4),
                  ],
                ),
              );
            }),
          ),
        ),

        // ─── الاحتفال ──────────────────────────────────────────────────────
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 30,
            gravity: 0.2,
            colors: const [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple],
          ),
        ),
      ],
    );
  }

  Widget _buildGameOver(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_fishing_bg_clean.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.black.withValues(alpha: 0.6),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 120)
                  .animate(onPlay: (c) => c.repeat())
                  .shimmer(duration: 1500.ms)
                  .scaleXY(begin: 0.9, end: 1.1, duration: 1.seconds, curve: Curves.easeInOut)
                  .then()
                  .scaleXY(begin: 1.1, end: 0.9, duration: 1.seconds, curve: Curves.easeInOut),
              const SizedBox(height: 24),
              const Text(
                'أَحْسَنْتَ يَا بَطَل!',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.white,
                ),
              ).animate().scaleXY(begin: 0.8, end: 1.0, duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward_rounded, size: 32),
                label: const Text('مُتَابَعَة', style: TextStyle(fontSize: 28, fontFamily: 'Cairo')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  AudioService.instance.stop();
                  ref.read(currentLessonProvider.notifier).completeCurrentActivity();
                },
              ).animate().fadeIn(delay: 1.seconds),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
          ),
        ),
      ],
    );
  }
}

// ─── عنصر السمكة المتحرك ────────────────────────────────────────────────────
class _FloatingFish extends StatefulWidget {
  final String word;
  final Color color;
  final double delay;
  final bool isCorrect;
  final bool isWrong;
  final VoidCallback onTap;

  const _FloatingFish({
    required this.word,
    required this.color,
    required this.delay,
    required this.isCorrect,
    required this.isWrong,
    required this.onTap,
  });

  @override
  State<_FloatingFish> createState() => _FloatingFishState();
}

class _FloatingFishState extends State<_FloatingFish> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget fish = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: 180,
          height: 90,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // الذيل
              Positioned(
                right: 0,
                child: ClipPath(
                  clipper: _FishTailClipper(),
                  child: Container(
                    width: 50,
                    height: 70,
                    color: widget.color.withValues(alpha: 0.8),
                  ),
                ),
              ),
              // الجسم
              Container(
                width: 145,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.elliptical(72, 40),
                    right: Radius.elliptical(25, 40),
                  ),
                  boxShadow: const [
                    BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 4)),
                  ],
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.word,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(1, 2))],
                  ),
                ),
              ),
              // العين
              Positioned(
                left: 20,
                top: 25,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (widget.isWrong) {
      fish = fish.animate(onPlay: (c) => c.repeat()).shakeX(duration: 400.ms, amount: 5);
    }
    if (widget.isCorrect) {
      fish = fish.animate().scaleXY(end: 1.2, duration: 400.ms, curve: Curves.easeOutBack)
          .then().scaleXY(end: 1.0, duration: 400.ms);
    }

    return fish;
  }
}

class _FishTailClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2); // متصل بالجسم
    path.lineTo(size.width, 0); // الزاوية العلوية
    path.lineTo(size.width, size.height); // الزاوية السفلية
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

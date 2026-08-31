import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── ثوابت الصورة الأصلية (بيكسل) ─────────────────────────────────────────
const double _imgW = 1270;
const double _imgH = 950;

// ─── بيانات جولة واحدة ────────────────────────────────────────────────────
class _FishZone {
  final String word;
  final bool hasAlif;
  final double px; // بيكسل أفقي
  final double py; // بيكسل رأسي
  const _FishZone({
    required this.word,
    required this.hasAlif,
    required this.px,
    required this.py,
  });
}

class _RoundData {
  final String imagePath;
  final List<_FishZone> zones;
  const _RoundData({required this.imagePath, required this.zones});
}

// مواضع الأسماك مقيسة على الصور الأصلية (1270×950)
const List<_RoundData> _rounds = [
  _RoundData(
    imagePath: 'assets/images/games/fishing/fishing_round_1.png',
    zones: [
      _FishZone(word: 'أَكَلَ',  hasAlif: true,  px: 155,  py: 545),
      _FishZone(word: 'بُرْجٌ',  hasAlif: false, px: 575,  py: 510),
      _FishZone(word: 'كَتَبَ',  hasAlif: false, px: 955,  py: 545),
    ],
  ),
  _RoundData(
    imagePath: 'assets/images/games/fishing/fishing_round_2.png',
    zones: [
      _FishZone(word: 'تِينٌ',   hasAlif: false, px: 155,  py: 545),
      _FishZone(word: 'خَرَجَ',  hasAlif: false, px: 575,  py: 510),
      _FishZone(word: 'أُذُنٌ',  hasAlif: true,  px: 955,  py: 545),
    ],
  ),
  _RoundData(
    imagePath: 'assets/images/games/fishing/fishing_round_3.png',
    zones: [
      _FishZone(word: 'ذَيْلٌ',  hasAlif: false, px: 155,  py: 545),
      _FishZone(word: 'رَأْسٌ',  hasAlif: true,  px: 575,  py: 510),
      _FishZone(word: 'فِيلٌ',   hasAlif: false, px: 955,  py: 545),
    ],
  ),
  _RoundData(
    imagePath: 'assets/images/games/fishing/fishing_round_4.png',
    zones: [
      _FishZone(word: 'جَمَلٌ',  hasAlif: false, px: 155,  py: 545),
      _FishZone(word: 'نَحْلَةٌ', hasAlif: false, px: 575,  py: 510),
      _FishZone(word: 'إِبْرَةٌ', hasAlif: true,  px: 955,  py: 545),
    ],
  ),
];

// ─── Widget الرئيسي ─────────────────────────────────────────────────────────
class WordFishingGame extends ConsumerStatefulWidget {
  const WordFishingGame({super.key});

  @override
  ConsumerState<WordFishingGame> createState() => _WordFishingGameState();
}

class _WordFishingGameState extends ConsumerState<WordFishingGame> {
  late ConfettiController _confetti;

  int _round = 0;
  int _score = 0;
  int? _tappedZoneIndex;
  bool _roundDone = false;
  bool _gameOver = false;
  int _wrongAttempts = 0; // تتبع المحاولات الخاطئة
  bool _showCorrectAnswer = false; // لإظهار الإجابة الصحيحة بعد محاولتين

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 700), _playInstruction);
    });
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  // ─── الصوت ────────────────────────────────────────────────────────────────
  Future<void> _playInstruction() async {
    await AudioService.instance.playAsset(
      'audio/instructions/alif_quiz_fish_explain.mp3',
      channel: AudioChannel.voice,
    );
  }

  Future<void> _playCorrect() async {
    // أحسنت
    await AudioService.instance.playAsset(
      'audio/stories/alif_correct.mp3',
      channel: AudioChannel.sfx,
    );
  }

  Future<void> _playWrong() async {
    // إجابة خاطئة حاول مرة أخرى
    await AudioService.instance.playAsset(
      'audio/instructions/alif_quiz_option_d.mp3',
      channel: AudioChannel.sfx,
    );
  }

  Future<void> _playThisIsCorrect() async {
    // إجابة صحيحة
    await AudioService.instance.playAsset(
      'audio/feedback/wow.mp3',
      channel: AudioChannel.voice,
    );
  }

  // ─── منطق اللعبة ────────────────────────────────────────────────────────
  Future<void> _onZoneTap(int zoneIndex) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.lightImpact();

    final zone = _rounds[_round].zones[zoneIndex];
    final isCorrect = zone.hasAlif;

    if (isCorrect) {
      // إجابة صحيحة
      setState(() {
        _tappedZoneIndex = zoneIndex;
        _roundDone = true;
        _score++;
      });
      _confetti.play();
      await _playCorrect();
      await Future.delayed(const Duration(milliseconds: 1800));
      if (!mounted) return;
      _advanceRound();
    } else {
      // إجابة خاطئة
      setState(() {
        _tappedZoneIndex = zoneIndex; // لإظهار علامة خطأ مؤقتة
        _wrongAttempts++;
      });
      
      await _playWrong();
      
      if (_wrongAttempts >= 2) {
        // بعد محاولتين، إظهار الإجابة الصحيحة
        setState(() {
          _showCorrectAnswer = true;
        });
        await _playThisIsCorrect();
        await Future.delayed(const Duration(milliseconds: 3000));
        if (!mounted) return;
        _advanceRound();
      } else {
        // محاولة أولى، إخفاء علامة الخطأ بعد ثانية ليتيح له المحاولة مرة أخرى
        await Future.delayed(const Duration(milliseconds: 1000));
        if (!mounted) return;
        setState(() {
          _tappedZoneIndex = null;
        });
      }
    }
  }

  void _advanceRound() {
    if (_round + 1 >= _rounds.length) {
      setState(() => _gameOver = true);
      if (_score >= (_rounds.length / 2)) _confetti.play();
    } else {
      setState(() {
        _round++;
        _tappedZoneIndex = null;
        _roundDone = false;
        _wrongAttempts = 0;
        _showCorrectAnswer = false;
      });
      Future.delayed(const Duration(milliseconds: 500), _playInstruction);
    }
  }

  // ─── واجهة المستخدم ──────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver();
    return Column(
      children: [
        Expanded(child: _buildGameScene()),
        _buildBottomNavBar(context),
      ],
    );
  }

  Widget _buildGameScene() {
    final roundData = _rounds[_round];

    return Stack(
      children: [
        LayoutBuilder(builder: (ctx, constraints) {
          final screenW = constraints.maxWidth;
          final screenH = constraints.maxHeight;

          final imageAspect = _imgW / _imgH;
          final screenAspect = screenW / screenH;

          double drawnW, drawnH, offsetX, offsetY;
          if (screenAspect < imageAspect) {
            drawnW = screenW;
            drawnH = screenW / imageAspect;
            offsetX = 0;
            offsetY = (screenH - drawnH) / 2;
          } else {
            drawnH = screenH;
            drawnW = screenH * imageAspect;
            offsetX = (screenW - drawnW) / 2;
            offsetY = 0;
          }

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  roundData.imagePath,
                  fit: BoxFit.contain,
                ),
              ),

              // الأسماك التفاعلية
              ...List.generate(roundData.zones.length, (i) {
                final zone = roundData.zones[i];

                final cx = offsetX + (zone.px / _imgW) * drawnW;
                final cy = offsetY + (zone.py / _imgH) * drawnH;
                const radius = 75.0; 

                Color ringColor = Colors.transparent;
                Color fillColor = Colors.transparent;
                Widget child = const SizedBox.shrink();

                if (_showCorrectAnswer) {
                  // وضع عرض الإجابة الصحيحة إجبارياً
                  if (zone.hasAlif) {
                    ringColor = Colors.greenAccent;
                    fillColor = Colors.green.withValues(alpha: 0.50);
                    child = const Text('✅', style: TextStyle(fontSize: 40));
                  }
                } else if (_tappedZoneIndex == i) {
                  // تفاعل النقر العادي
                  if (zone.hasAlif) {
                    ringColor = Colors.greenAccent;
                    fillColor = Colors.green.withValues(alpha: 0.50);
                    child = const Text('✅', style: TextStyle(fontSize: 40));
                  } else {
                    ringColor = Colors.redAccent;
                    fillColor = Colors.red.withValues(alpha: 0.50);
                    child = const Text('❌', style: TextStyle(fontSize: 40));
                  }
                } else if (_roundDone && zone.hasAlif) {
                  ringColor = Colors.greenAccent.withValues(alpha: 0.70);
                  fillColor = Colors.green.withValues(alpha: 0.20);
                }

                return Positioned(
                  left: cx - radius,
                  top: cy - radius,
                  width: radius * 2,
                  height: radius * 2,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _onZoneTap(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: fillColor,
                        border: ringColor != Colors.transparent ? Border.all(color: ringColor, width: 4) : null,
                      ),
                      child: Center(child: child),
                    ),
                  ),
                );
              }),

              // رسالة "هذه هي الإجابة الصحيحة"
              if (_showCorrectAnswer)
                Positioned(
                  top: offsetY + drawnH * 0.35,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.greenAccent, width: 2),
                      ),
                      child: const Text(
                        'هَذِهِ هِيَ الْإِجَابَةُ الصَّحِيحَةُ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ).animate().fadeIn().scale(),
                  ),
                ),

              // ── زر صوت السؤال والأهداف (أعلى الشاشة) ─────────────────────────────
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _scoreChip(),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _playInstruction,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 28),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _roundChip(),
                  ],
                ),
              ),
            ],
          );
        }),

        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 25,
            gravity: 0.4,
            colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange],
          ),
        ),
      ],
    );
  }

  // ─── شريط التنقل السفلي المخصص (أسفل الصورة) ──────────────────────────
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // زر التالي (يسار)
          _navButton(
            label: 'التالي',
            icon: Icons.arrow_back_rounded,
            enabled: _roundDone || _showCorrectAnswer,
            onTap: () {
              if (_roundDone || _showCorrectAnswer) {
                HapticFeedback.lightImpact();
                _advanceRound();
              }
            },
          ),
          
          // زر الرئيسية (وسط)
          _homeButton(context),
          
          // زر السابق (يمين)
          _navButton(
            label: 'السابق',
            icon: Icons.arrow_forward_rounded,
            enabled: _round > 0 && !_roundDone && !_showCorrectAnswer,
            onTap: () {
              if (_round > 0 && !_roundDone && !_showCorrectAnswer) {
                HapticFeedback.lightImpact();
                setState(() {
                  _round--;
                  _tappedZoneIndex = null;
                  _roundDone = false;
                  _wrongAttempts = 0;
                  _showCorrectAnswer = false;
                });
                Future.delayed(const Duration(milliseconds: 400), _playInstruction);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _homeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFF4CAF50), // لون أخضر جذاب للرئيسية
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        child: const Icon(Icons.home_rounded, color: Colors.white, size: 28),
      ),
    ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms);
  }

  Widget _navButton({
    required String label,
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    final isNext = label == 'التالي';
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: enabled ? const Color(0xFFE53935) : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(24),
            boxShadow: enabled
                ? [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 6, offset: const Offset(0, 3))]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isNext) Icon(icon, color: Colors.white, size: 20),
              if (isNext) const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (!isNext) const SizedBox(width: 6),
              if (!isNext) Icon(icon, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms);
  }

  Widget _scoreChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Text('⭐', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 5),
          Text(
            '$_score',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'سؤال ${_round + 1} / ${_rounds.length}',
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGameOver() {
    final perfect = _score == _rounds.length;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            _rounds.last.imagePath,
            fit: BoxFit.contain,
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withValues(alpha: 0.65)),
        ),
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
              Text(
                perfect ? '🏆' : '🎯',
                style: const TextStyle(fontSize: 90),
              ).animate().scale(begin: const Offset(0, 0), curve: Curves.elasticOut, duration: 800.ms),
              const SizedBox(height: 20),
              Text(
                perfect ? 'مُمْتَازٌ! صِدْتَ كُلَّ الْكَلِمَاتِ! 🎣' : 'أَحْسَنْتَ! صِدْتَ $_score مِنْ ${_rounds.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.3),
              const SizedBox(height: 12),
              Text(
                'نَتِيجَتُكَ: $_score / ${_rounds.length}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.yellow,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ).animate(delay: 600.ms).fadeIn(),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _round = 0;
                    _score = 0;
                    _gameOver = false;
                    _tappedZoneIndex = null;
                    _roundDone = false;
                    _wrongAttempts = 0;
                    _showCorrectAnswer = false;
                  });
                  Future.delayed(const Duration(milliseconds: 500), _playInstruction);
                },
                icon: const Icon(Icons.replay_rounded),
                label: const Text(
                  'الْعَبْ مَرَّةً أُخْرَى',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ).animate(delay: 800.ms).fadeIn().scale(begin: const Offset(0.8, 0.8)),
            ],
          ),
        ),
      ],
    );
  }
}

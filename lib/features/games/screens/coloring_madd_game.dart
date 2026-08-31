import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

const double _imgW = 1270, _imgH = 950;

class _MaddWordOption {
  final String word;
  final bool hasMadd;
  const _MaddWordOption({required this.word, required this.hasMadd});
}

class _ColoringRound {
  final String imagePath;
  final List<_MaddWordOption> options;
  final String correctWord;
  final List<String> letterSegments; // The individual letters to color
  final String wordAudioPath;

  const _ColoringRound({
    required this.imagePath,
    required this.options,
    required this.correctWord,
    required this.letterSegments,
    required this.wordAudioPath,
  });
}

const List<_ColoringRound> _coloringRounds = [
  _ColoringRound(
    imagePath: 'assets/images/games/coloring/coloring_round_1.png',
    options: [
      _MaddWordOption(word: 'إِبْرَةٌ', hasMadd: false),
      _MaddWordOption(word: 'أَسَدٌ',  hasMadd: false),
      _MaddWordOption(word: 'أُولَى',  hasMadd: true),
    ],
    correctWord: 'أُولَى',
    letterSegments: ['أُ', 'و', 'لَ', 'ـى'],
    wordAudioPath: 'audio/instructions/alif_trace_step_06.mp3', // الأولى
  ),
  _ColoringRound(
    imagePath: 'assets/images/games/coloring/coloring_round_2.png',
    options: [
      _MaddWordOption(word: 'أَرْنَبٌ', hasMadd: false),
      _MaddWordOption(word: 'إِينَاسٌ', hasMadd: true),
      _MaddWordOption(word: 'فَأْسٌ',   hasMadd: false),
    ],
    correctWord: 'إِينَاسٌ',
    letterSegments: ['إِ', 'يـ', 'نَـ', 'ـا', 'س'],
    wordAudioPath: 'audio/instructions/alif_trace_step_13.mp3', // إيناس
  ),
  _ColoringRound(
    imagePath: 'assets/images/games/coloring/coloring_round_3.png',
    options: [
      _MaddWordOption(word: 'آمَالٌ',  hasMadd: true),
      _MaddWordOption(word: 'رَأْسٌ',  hasMadd: false),
      _MaddWordOption(word: 'أُذُنٌ',  hasMadd: false),
    ],
    correctWord: 'آمَالٌ',
    letterSegments: ['آ', 'مَـ', 'ـا', 'ل'],
    wordAudioPath: 'audio/instructions/alif_trace_step_08.mp3', // آمال
  ),
];

class ColoringMaddGame extends ConsumerStatefulWidget {
  const ColoringMaddGame({super.key});

  @override
  ConsumerState<ColoringMaddGame> createState() => _ColoringMaddGameState();
}

class _ColoringMaddGameState extends ConsumerState<ColoringMaddGame> with TickerProviderStateMixin {
  late ConfettiController _confetti;

  int _round = 0;
  int _score = 0;
  bool _gameOver = false;

  // Round state
  int? _selectedOption;
  bool _isWordSelected = false; // true when correct word selected
  bool _roundDone = false;
  int _wrongAttempts = 0;

  // Coloring state
  Color _selectedPaletteColor = const Color(0xFFE53935); // Default red
  late List<Color> _letterColors;

  static const List<Color> _palette = [
    Color(0xFFE53935), // Red
    Color(0xFF43A047), // Green
    Color(0xFF1E88E5), // Blue
    Color(0xFF8E24AA), // Purple
    Color(0xFFFDD835), // Yellow
    Color(0xFFFB8C00), // Orange
    Color(0xFFE91E63), // Pink
    Color(0xFF00ACC1), // Cyan
  ];

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _initLetterColors();
    WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(const Duration(milliseconds: 700), _playInstruction));
  }

  void _initLetterColors() {
    final round = _coloringRounds[_round];
    _letterColors = List.generate(round.letterSegments.length, (_) => Colors.white);
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  Future<void> _playInstruction() =>
      AudioService.instance.playAsset(
        !_isWordSelected 
          ? 'audio/instructions/coloring_madd_instruction.mp3'
          : 'audio/instructions/coloring_paint_instruction.mp3', 
        channel: AudioChannel.voice);
  Future<void> _playCorrect() =>
      AudioService.instance.playAsset('audio/stories/alif_correct.mp3', channel: AudioChannel.sfx);
  Future<void> _playWrong() =>
      AudioService.instance.playAsset('audio/instructions/alif_quiz_option_d.mp3', channel: AudioChannel.sfx);
  Future<void> _playWordAudio(String path) =>
      AudioService.instance.playAsset(path, channel: AudioChannel.voice);

  Future<void> _onOptionTap(int idx) async {
    if (_isWordSelected || _roundDone) return;
    HapticFeedback.lightImpact();

    final rd = _coloringRounds[_round];
    final opt = rd.options[idx];

    if (opt.hasMadd) {
      setState(() {
        _selectedOption = idx;
        _isWordSelected = true;
        _score++;
      });
      _confetti.play();
      await _playWordAudio(rd.wordAudioPath);
    } else {
      setState(() { _selectedOption = idx; });
      await _playWrong();
      _wrongAttempts++;
      if (_wrongAttempts >= 2) {
        // Reveal correct answer
        final correctIdx = rd.options.indexWhere((o) => o.hasMadd);
        setState(() {
          _selectedOption = correctIdx;
          _isWordSelected = true;
        });
        await _playWordAudio(rd.wordAudioPath);
      } else {
        await Future.delayed(const Duration(milliseconds: 700));
        if (!mounted) return;
        setState(() { _selectedOption = null; });
      }
    }
  }

  void _colorLetter(int letterIdx) {
    HapticFeedback.selectionClick();
    setState(() {
      _letterColors[letterIdx] = _selectedPaletteColor;
    });

    // Check if all letters are colored
    final allColored = _letterColors.every((c) => c != Colors.white);
    if (allColored && !_roundDone) {
      setState(() { _roundDone = true; });
      _confetti.play();
      _playCorrect();
    }
  }

  void _advance() {
    if (_round + 1 >= _coloringRounds.length) {
      setState(() => _gameOver = true);
      if (_score >= _coloringRounds.length / 2) _confetti.play();
    } else {
      setState(() {
        _round++;
        _selectedOption = null;
        _isWordSelected = false;
        _roundDone = false;
        _wrongAttempts = 0;
        _initLetterColors();
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
    final rd = _coloringRounds[_round];
    return Stack(
      children: [
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
            // Background image
            Positioned.fill(child: Image.asset(rd.imagePath, fit: BoxFit.contain)),

            // White cover for left options area to avoid any text distortion
            Positioned(
              left: ox + 15 * scaleX,
              top: oy + 120 * scaleY,
              width: 175 * scaleX,
              height: 600 * scaleY,
              child: Container(color: Colors.transparent),
            ),

            // Left Option Cards
            ...List.generate(rd.options.length, (i) =>
              _buildOptionCard(rd, i, ox, oy, scaleX, scaleY)),

            // Main Central Board (Word Display & Coloring Canvas)
            if (_isWordSelected)
              _buildColoringCanvas(rd, ox, oy, scaleX, scaleY),

            // Color Palette Bar
            if (_isWordSelected)
              _buildColorPalette(ox, oy, scaleX, scaleY),

            // Top HUD
            Positioned(top: 10, left: 0, right: 0, child: _topBar()),
          ]);
        }),

        // Confetti
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 35,
            gravity: 0.4,
            colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange, Colors.cyan],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard(_ColoringRound rd, int i, double ox, double oy, double scaleX, double scaleY) {
    final opt = rd.options[i];
    final pyList = [200.0, 445.0, 685.0];
    final cx = ox + 105 * scaleX;
    final cy = oy + pyList[i] * scaleY;
    final cardW = 160.0 * scaleX;
    final cardH = 92.0 * scaleY;

    final isSelected = _selectedOption == i;
    final isCorrect = isSelected && opt.hasMadd;

    return Positioned(
      left: cx - cardW / 2,
      top: cy - cardH / 2,
      width: cardW,
      height: cardH,
      child: GestureDetector(
        onTap: () => _onOptionTap(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isCorrect
                ? Colors.green.shade50
                : (isSelected ? Colors.red.shade50 : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCorrect
                  ? Colors.green
                  : (isSelected ? Colors.red : Colors.green.shade600),
              width: isCorrect || isSelected ? 4 : 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: (isCorrect ? Colors.green : Colors.black12).withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              opt.word,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 26 * scaleX,
                fontWeight: FontWeight.bold,
                color: isCorrect
                    ? Colors.green.shade800
                    : (isSelected ? Colors.red.shade800 : Colors.black87),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColoringCanvas(_ColoringRound rd, double ox, double oy, double scaleX, double scaleY) {
    final boardX = ox + 240 * scaleX;
    final boardY = oy + 240 * scaleY;
    final boardW = 630 * scaleX;
    final boardH = 380 * scaleY;

    return Positioned(
      left: boardX,
      top: boardY,
      width: boardW,
      height: boardH,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.green.shade400, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.2),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'لَوِّنْ حُرُوفَ الْكَلِمَةِ بِأَلْوَانِكَ الْجَمِيلَةِ 🎨',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16 * scaleX,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: List.generate(rd.letterSegments.length, (idx) {
                final letter = rd.letterSegments[idx];
                final color = _letterColors[idx];
                final isColored = color != Colors.white;

                return GestureDetector(
                  onTap: () => _colorLetter(idx),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isColored ? color.withValues(alpha: 0.15) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isColored ? color : Colors.grey.shade400,
                        width: 2.5,
                      ),
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 48 * scaleX,
                        fontWeight: FontWeight.bold,
                        color: isColored ? color : Colors.black87,
                        shadows: isColored
                            ? [Shadow(color: color.withValues(alpha: 0.5), blurRadius: 8)]
                            : [],
                      ),
                    ).animate(target: isColored ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.15, 1.15), duration: 200.ms),
                  ),
                );
              }),
            ),
          ],
        ),
      ).animate().scale(begin: const Offset(0.7, 0.7), curve: Curves.elasticOut, duration: 600.ms),
    );
  }

  Widget _buildColorPalette(double ox, double oy, double scaleX, double scaleY) {
    final palX = ox + 240 * scaleX;
    final palY = oy + 650 * scaleY;
    final palW = 630 * scaleX;
    final palH = 80 * scaleY;

    return Positioned(
      left: palX,
      top: palY,
      width: palW,
      height: palH,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber.shade400, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _palette.map((c) {
            final isSelected = _selectedPaletteColor == c;
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedPaletteColor = c);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSelected ? 38 * scaleX : 30 * scaleX,
                height: isSelected ? 38 * scaleX : 30 * scaleX,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: c.withValues(alpha: isSelected ? 0.6 : 0.3),
                      blurRadius: isSelected ? 8 : 4,
                      spreadRadius: isSelected ? 2 : 0,
                    ),
                  ],
                ),
                child: isSelected
                    ? const Icon(Icons.brush_rounded, color: Colors.white, size: 18)
                    : null,
              ),
            );
          }).toList(),
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3, end: 0),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -3))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navBtn('التالي', Icons.arrow_back_rounded, _isWordSelected, () {
            if (_isWordSelected) { HapticFeedback.lightImpact(); _advance(); }
          }),
          GestureDetector(
            onTap: () { HapticFeedback.lightImpact(); Navigator.of(context).popUntil((r) => r.isFirst); },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
              child: const Icon(Icons.home_rounded, color: Colors.white, size: 28),
            ),
          ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms),
          _navBtn('السابق', Icons.arrow_forward_rounded, _round > 0 && !_isWordSelected, () {
            if (_round > 0 && !_isWordSelected) {
              HapticFeedback.lightImpact();
              setState(() {
                _round--;
                _selectedOption = null;
                _isWordSelected = false;
                _roundDone = false;
                _wrongAttempts = 0;
                _initLetterColors();
              });
            }
          }),
        ],
      ),
    );
  }

  Widget _navBtn(String label, IconData icon, bool enabled, VoidCallback onTap) {
    final isNext = label == 'التالي';
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200), opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: enabled ? const Color(0xFFE53935) : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(24),
            boxShadow: enabled ? [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 6, offset: const Offset(0, 3))] : [],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (isNext) Icon(icon, color: Colors.white, size: 20),
            if (isNext) const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            if (!isNext) const SizedBox(width: 6),
            if (!isNext) Icon(icon, color: Colors.white, size: 20),
          ]),
        ),
      ),
    ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms);
  }

  Widget _topBar() => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    _chip('⭐ $_score'), const SizedBox(width: 10),
    GestureDetector(
      onTap: _playInstruction,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
        child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 26),
      ),
    ),
    const SizedBox(width: 10), _chip('${_round + 1} / ${_coloringRounds.length}'),
  ]);

  Widget _chip(String t) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
    child: Text(t, style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
  );

  Widget _gameOverScreen() => Stack(children: [
    Positioned.fill(child: Image.asset(_coloringRounds.last.imagePath, fit: BoxFit.contain)),
    Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.65))),
    Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _confetti,
        blastDirectionality: BlastDirectionality.explosive,
        numberOfParticles: 50, gravity: 0.3,
        colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange, Colors.cyan],
      ),
    ),
    Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('🎨', style: TextStyle(fontSize: 90))
            .animate().scale(begin: const Offset(0, 0), curve: Curves.elasticOut, duration: 800.ms),
        const SizedBox(height: 20),
        Text(
          _score == _coloringRounds.length
              ? 'مُمْتَازٌ! أَكْمَلْتَ تَلْوِينَ كُلِّ الْكَلِمَاتِ!'
              : 'أَحْسَنْتَ! إِجَابَتُكَ: $_score / ${_coloringRounds.length}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo'),
        ).animate(delay: 400.ms).fadeIn(),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _round = 0; _score = 0; _gameOver = false;
              _selectedOption = null; _isWordSelected = false;
              _roundDone = false; _wrongAttempts = 0;
              _initLetterColors();
            });
            Future.delayed(const Duration(milliseconds: 500), _playInstruction);
          },
          icon: const Icon(Icons.replay_rounded),
          label: const Text('الْعَبْ مَرَّةً أُخْرَى', style: TextStyle(fontFamily: 'Cairo', fontSize: 18)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber, foregroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ).animate(delay: 700.ms).fadeIn().scale(begin: const Offset(0.8, 0.8)),
      ]),
    ),
  ]);
}
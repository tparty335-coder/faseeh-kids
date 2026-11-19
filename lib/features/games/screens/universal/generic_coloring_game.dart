import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/games/widgets/universal_game_bottom_bar.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// لعبة التلوين الموحّدة — تُغذَّى بالكامل من LetterUnitManifest
class GenericColoringGame extends StatefulWidget {
  final LetterUnitManifest manifest;
  final VoidCallback? onExit;

  const GenericColoringGame({
    super.key,
    required this.manifest,
    this.onExit,
  });

  @override
  State<GenericColoringGame> createState() => _GenericColoringGameState();
}

class _GenericColoringGameState extends State<GenericColoringGame> {
  static const List<Color> _palette = [
    Color(0xFFE30613),
    Color(0xFF048200),
    Color(0xFF03A0E3),
    Color(0xFFDC15C3),
    Color(0xFFFDD835),
    Color(0xFFFB8C00),
    Color(0xFFC2185B),
    Color(0xFF00ACC1),
  ];

  late ConfettiController _confetti;
  int _round = 0;
  int _score = 0;
  int _token = 0;
  bool _gameOver = false;
  int? _selectedOption;
  bool _isWordSelected = false;
  bool _isProcessing = false;
  bool _roundDone = false;
  final Set<int> _wrongPressed = {};
  Color _selectedPaletteColor = _palette.first;
  late List<Color?> _sliceColors;

  List<ColoringRound> get _rounds => widget.manifest.games.coloring;
  GamesSpec get _games => widget.manifest.games;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _initSliceColors();
    final tk = _token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_alive(tk) && _rounds.isNotEmpty) {
        _playRoundIntro(isFirstRound: true);
      }
    });
  }

  @override
  void dispose() {
    _token++;
    AudioService.instance.stop();
    _confetti.dispose();
    super.dispose();
  }

  bool _alive(int token) => mounted && !_gameOver && token == _token;

  void _initSliceColors() {
    if (_rounds.isEmpty) {
      _sliceColors = [];
      return;
    }
    _sliceColors = List<Color?>.filled(_rounds[_round].slices.length, null);
  }

  Future<void> _say(String path, {int maxMs = 4500, AudioChannel channel = AudioChannel.voice}) async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(path, channel: channel);
      final done = AudioService.instance.onPlayerComplete(channel);
      if (done != null) {
        await done.first.timeout(Duration(milliseconds: maxMs), onTimeout: () {});
      } else {
        await Future.delayed(Duration(milliseconds: maxMs));
      }
    } catch (_) {}
  }

  Future<void> _playRoundIntro({bool isFirstRound = false}) async {
    if (!mounted || _gameOver || _rounds.isEmpty) return;
    final tk = ++_token;
    if (!_isWordSelected) {
      if (isFirstRound && _games.coloringIntroAudio != null) {
        await _say(_games.coloringIntroAudio!, maxMs: 2500);
        if (!_alive(tk) || _isWordSelected) return;
      }
      final step1 = _games.coloringStep1Audio ?? 'audio/games/coloring/3_qu2.mp3';
      await _say(step1, maxMs: 4500);
    } else {
      final step2 = _games.coloringStep2Audio ?? 'audio/games/coloring/2_qu3.mp3';
      await _say(step2, maxMs: 6000);
    }
  }

  List<String> _distractorWords() {
    const pool = ['قَلَم', 'وَلَد', 'أَسَد', 'جَبَل', 'عِنَب', 'لَبَن'];
    final ch = widget.manifest.letter.replaceAll('ـ', '').trim();
    final filtered = pool.where((w) => !w.contains(ch)).toList();
    return filtered.length >= 2 ? filtered : pool;
  }

  List<GameZoneChoice> _effectiveOptions(ColoringRound rd) {
    if (rd.options != null && rd.options!.isNotEmpty) return rd.options!;
    const correctByRound = [2, 0, 2];
    final corr = correctByRound[_round % 3];
    final d = _distractorWords();
    return [
      GameZoneChoice(label: corr == 0 ? rd.word : d[(_round * 2) % d.length], isCorrect: corr == 0),
      GameZoneChoice(label: corr == 1 ? rd.word : d[(_round * 2 + 1) % d.length], isCorrect: corr == 1),
      GameZoneChoice(label: corr == 2 ? rd.word : d[(_round * 2 + 2) % d.length], isCorrect: corr == 2),
    ];
  }

  Future<void> _onOptionTap(int idx) async {
    if (_isWordSelected || _roundDone || _isProcessing || _rounds.isEmpty) return;
    HapticFeedback.lightImpact();

    final tk = ++_token;
    try {
      AudioService.instance.stop();
    } catch (_) {}
    final rd = _rounds[_round];
    final opts = _effectiveOptions(rd);
    final opt = opts[idx];

    setState(() {
      _selectedOption = idx;
      _isProcessing = true;
    });

    try {
      if (opt.isCorrect) {
        setState(() {
          _score++;
          _isWordSelected = true;
          _isProcessing = false;
        });
        _confetti.play();
        await _say(rd.revealAudioPath, maxMs: 3800);
        if (!_alive(tk)) return;
        final step2 = _games.coloringStep2Audio ?? 'audio/games/coloring/2_qu3.mp3';
        await _say(step2, maxMs: 5500);
        return;
      }

      _wrongPressed.add(idx);
      final wrongIdxs = [for (int i = 0; i < opts.length; i++) if (!opts[i].isCorrect) i];
      if (wrongIdxs.isNotEmpty && wrongIdxs.every(_wrongPressed.contains)) {
        final revealWrong = rd.wrongRevealAudioPath ?? rd.revealAudioPath;
        await _say(revealWrong, maxMs: 6500);
        if (!_alive(tk)) return;
        setState(() {
          _selectedOption = opts.indexWhere((o) => o.isCorrect);
          _isWordSelected = true;
          _isProcessing = false;
        });
        final step2 = _games.coloringStep2Audio ?? 'audio/games/coloring/2_qu3.mp3';
        await _say(step2, maxMs: 5500);
      } else {
        final wrong = _games.coloringWrongAudio ?? 'audio/games/coloring/5_al23.mp3';
        await _say(wrong, maxMs: 3200);
        if (!_alive(tk)) return;
        setState(() {
          _selectedOption = null;
        });
      }
    } finally {
      if (mounted && tk == _token) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _colorSlice(int sliceIdx) async {
    if (!_isWordSelected || _roundDone || _sliceColors.isEmpty) return;
    if (_sliceColors[sliceIdx] == _selectedPaletteColor) return;

    HapticFeedback.selectionClick();
    setState(() => _sliceColors[sliceIdx] = _selectedPaletteColor);

    if (!_sliceColors.every((c) => c != null)) {
      try {
        AudioService.instance.playAsset('audio/sfx/tap.mp3', channel: AudioChannel.sfx);
      } catch (_) {}
      return;
    }

    final tk = ++_token;
    setState(() => _roundDone = true);
    _confetti.play();
    final rd = _rounds[_round];
    final wordAudio = rd.wordAudioPath ?? rd.introAudioPath;
    final praise = _games.praiseFinishAudio ?? 'audio/games/fishing/ahsnt.mp3';
    await _say('audio/sfx/tap.mp3', maxMs: 450, channel: AudioChannel.sfx);
    if (!_alive(tk)) return;
    await _say(praise, maxMs: 2500);
    if (!_alive(tk)) return;
    await _say(wordAudio, maxMs: 2800);
    if (!_alive(tk)) return;
    await Future.delayed(const Duration(milliseconds: 400));
    if (!_alive(tk)) return;
    _advance();
  }

  void _resetRoundState() {
    _selectedOption = null;
    _isWordSelected = false;
    _roundDone = false;
    _isProcessing = false;
    _wrongPressed.clear();
    _initSliceColors();
  }

  void _advance() {
    final tk = ++_token;
    AudioService.instance.stop();
    if (_round + 1 >= _rounds.length) {
      setState(() => _gameOver = true);
      _confetti.play();
      final fin = _games.praiseFinishAudio ?? 'audio/games/fishing/ahsnt.mp3';
      try {
        AudioService.instance.playAsset(fin, channel: AudioChannel.voice);
      } catch (_) {}
    } else {
      setState(() {
        _round++;
        _resetRoundState();
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_alive(tk)) _playRoundIntro();
      });
    }
  }

  void _prev() {
    if (_round <= 0) return;
    final tk = ++_token;
    AudioService.instance.stop();
    setState(() {
      _round--;
      _resetRoundState();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_alive(tk)) _playRoundIntro();
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
    final opts = _effectiveOptions(rd);
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
                Positioned.fill(child: Image.asset(rd.bgImagePath, fit: BoxFit.contain)),

                // بطاقات الخطوة 1 (مناطق ضغط شفافة تماماً تحافظ على الخط الأصلي)
                ...List.generate(opts.length, (i) {
                  final opt = opts[i];
                  final cw = rd.cardW * sx, ch = rd.cardH * sy;
                  final cy = rd.cardCyList[i % rd.cardCyList.length];
                  final isSel = _selectedOption == i;
                  final isCorr = isSel && opt.isCorrect;
                  final isWrong = isSel && !opt.isCorrect;
                  final isWrongDimmed = !isSel && _wrongPressed.contains(i);
                  return Positioned(
                    left: ox + rd.cardCx * sx - cw / 2,
                    top: oy + cy * sy - ch / 2,
                    width: cw,
                    height: ch,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onOptionTap(i),
                      child: isSel
                          ? Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isCorr ? Colors.green.shade600 : Colors.red.shade600,
                                      width: 3.5,
                                    ),
                                    color: (isCorr ? Colors.green : Colors.red).withValues(alpha: 0.16),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      isCorr ? Icons.check_circle_rounded : Icons.cancel_rounded,
                                      color: isCorr ? Colors.green.shade600 : Colors.red.shade600,
                                      size: (22 * sx).clamp(16.0, 28.0),
                                    ),
                                  ),
                                ),
                              ],
                            ).animate().shake(duration: isWrong ? 380.ms : 0.ms)
                          : (isWrongDimmed
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.black.withValues(alpha: 0.14),
                                  ),
                                )
                              : const SizedBox.expand()),
                    ),
                  );
                }),

                // الخطوة 2: الكلمة المفرغة وشرائح التلوين
                if (_isWordSelected) _buildHollowWord(rd, ox, oy, sx, sy),

                // شريط الألوان أسفل الكلمة (متموضع نسبياً مع أبعاد الكلمة)
                if (_isWordSelected)
                  () {
                    final palH = (58.0 * (rd.imgH / 450.0)) * sy;
                    final palTop = (oy + (rd.wordY + rd.wordH + 14.0 * (rd.imgH / 450.0)) * sy)
                        .clamp(oy, oy + dH - palH - 4);
                    return Positioned(
                      left: ox + rd.wordX * sx,
                      top: palTop,
                      width: rd.wordW * sx,
                      height: palH,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8 * sx),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.94),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: widget.manifest.topBarColor, width: 2),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _palette.map((col) {
                              final sel = _selectedPaletteColor == col;
                              final sz = (sel ? 34.0 : 26.0) * sx;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() => _selectedPaletteColor = col);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 160),
                                    width: sz.clamp(18.0, 42.0),
                                    height: sz.clamp(18.0, 42.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: col,
                                      border: Border.all(
                                        color: sel ? Colors.black : Colors.white,
                                        width: sel ? 3 : 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }(),

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
                        '🎨 الجولة ${_round + 1} / ${_rounds.length}  •  ⭐ $_score',
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

  Widget _buildHollowWord(ColoringRound rd, double ox, double oy, double sx, double sy) {
    final wW = rd.wordW * sx;
    final wH = rd.wordH * sy;
    final n = rd.slices.length;
    return Positioned(
      left: ox + rd.wordX * sx,
      top: oy + rd.wordY * sy,
      width: wW,
      height: wH,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => _paintAt(d.localPosition.dx, wW, n),
        onPanUpdate: (d) => _paintAt(d.localPosition.dx, wW, n),
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(rd.wordRevealImagePath, fit: BoxFit.fill)),
            ...List.generate(n, (i) {
              final slice = rd.slices[i];
              final color = _sliceColors[i];
              if (color == null) return const SizedBox.shrink();
              final bandW = wW / n;
              return Positioned(
                left: bandW * i,
                top: 0,
                width: bandW,
                height: wH,
                child: ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    minWidth: wW,
                    maxWidth: wW,
                    minHeight: wH,
                    maxHeight: wH,
                    child: Transform.translate(
                      offset: Offset(-bandW * i, 0),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                        child: Image.asset(
                          slice.maskImagePath.isNotEmpty ? slice.maskImagePath : rd.wordRevealImagePath,
                          width: wW,
                          height: wH,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ).animate().fadeIn(duration: 280.ms),
    );
  }

  void _paintAt(double localX, double totalW, int count) {
    if (totalW <= 0 || count <= 0) return;
    final idx = ((localX / totalW) * count).floor().clamp(0, count - 1);
    _colorSlice(idx);
  }

  Widget _buildBottomBar() {
    return UniversalGameBottomBar(
      onPrevious: _round > 0 ? _prev : null,
      onNext: _advance,
      onReplayAudio: () => _playRoundIntro(),
      onGamesMenu: widget.onExit,
      accentColor: widget.manifest.topBarColor,
      isLastRound: _round + 1 >= _rounds.length,
    );
  }

  Widget _buildGameOver() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🎨', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          Text(
            'أبدعت في تلوين (${widget.manifest.letter})!',
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
                    _resetRoundState();
                  });
                  _playRoundIntro(isFirstRound: true);
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

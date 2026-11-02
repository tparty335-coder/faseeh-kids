import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── لعبة التلوين لحرف الباء ──────────────────────────────────────────────────
// مطابقة لشاشات الأسطوانة الأصلية (paint1.swf → paint2.swf → paint3.swf) وبخطوتيها:
// الخطوة 1: «اضغط على الكلمة التي بها مد» — الخطأ يُسمِع «حاول مرة أخرى»،
//           وبعد الضغط على البطاقتين الخاطئتين تُنطق الإجابة الصحيحة وتُكشف.
// الخطوة 2: تُسمَع عبارة التشجيع + الكلمة، ثم يُطلب تلوين الكلمة بألوانه المفضلة.
//
// ترتيب الجولات في الأسطوانة: ثعبان ← طبيب ← حبوب (مأخوذ من تسلسل loadMovieNum).

const double _imgW = 1024;
const double _imgH = 490;

// موضع وأبعاد الكلمة المفرغة داخل اللوحة البيضاء (بكسل الصورة الأصلية)
const double _wordX = 210;
const double _wordY = 190;
const double _wordW = 490;
const double _wordH = 160;

class _MaddOption {
  final String word;
  final bool hasMadd;
  const _MaddOption({required this.word, required this.hasMadd});
}

class _ColoringRound {
  final String bgImagePath;
  final String wordMaskPath;
  final String correctWord;
  // «أحسنت + الكلمة» بصوت الأسطوانة (مدتها ≈ 2 ثانية)
  final String correctAudio;
  // الجملة التي تُسمَع عند كشف الإجابة بعد الخطأين (≈ 5 ثوانٍ)
  final String revealAudio;
  final String wordAudio;
  final List<_MaddOption> options;
  // حدود حروف الكلمة على محور x داخل صورة الكلمة (عرضها 490)
  final List<double> cuts;

  const _ColoringRound({
    required this.bgImagePath,
    required this.wordMaskPath,
    required this.correctWord,
    required this.correctAudio,
    required this.revealAudio,
    required this.wordAudio,
    required this.options,
    required this.cuts,
  });

  /// مقاطع الكلمة (من اليسار إلى اليمين) كأزواج [بداية، نهاية].
  List<List<double>> get slices {
    final edges = [0.0, ...cuts, _wordW];
    return List.generate(edges.length - 1, (i) => [edges[i], edges[i + 1]]);
  }
}

const List<_ColoringRound> _rounds = [
  // الجولة 1 (paint1): تَمْر ❌، بِنْت ❌، تِمْسَاح ✅
  _ColoringRound(
    bgImagePath: 'assets/images/games/coloring/taa_coloring_round_1.png',
    wordMaskPath: 'assets/images/games/coloring/taa_coloring_word_1.png',
    correctWord: 'تِمْسَاح',
    correctAudio: 'audio/games/coloring/goodtmsah.mp3',
    revealAudio: 'audio/games/coloring/rongtems.mp3',
    wordAudio: 'audio/lessons/taa/final/taa_word_timsah.mp3',
    options: [
      _MaddOption(word: 'تَمْر', hasMadd: false),
      _MaddOption(word: 'بِنْت', hasMadd: false),
      _MaddOption(word: 'تِمْسَاح', hasMadd: true),
    ],
    cuts: [142, 215, 290, 360],
  ),
  // الجولة 2 (paint2): تِين ✅، تَأْكُل ❌، يَكْتُب ❌
  _ColoringRound(
    bgImagePath: 'assets/images/games/coloring/taa_coloring_round_2.png',
    wordMaskPath: 'assets/images/games/coloring/taa_coloring_word_2.png',
    correctWord: 'تِين',
    correctAudio: 'audio/games/coloring/goodteen.mp3',
    revealAudio: 'audio/games/coloring/rongteen.mp3',
    wordAudio: 'audio/lessons/taa/sounds/word_teen.mp3',
    options: [
      _MaddOption(word: 'تِين', hasMadd: true),
      _MaddOption(word: 'تَأْكُل', hasMadd: false),
      _MaddOption(word: 'يَكْتُب', hasMadd: false),
    ],
    cuts: [165, 290, 380],
  ),
  // الجولة 3 (paint3): أَرْنَب ❌، يَلْعَب ❌، تُوت ✅
  _ColoringRound(
    bgImagePath: 'assets/images/games/coloring/taa_coloring_round_3.png',
    wordMaskPath: 'assets/images/games/coloring/taa_coloring_word_3.png',
    correctWord: 'تُوت',
    correctAudio: 'audio/games/coloring/goodtoot.mp3',
    revealAudio: 'audio/games/coloring/rongtoot.mp3',
    wordAudio: 'audio/lessons/taa/sounds/word_toot.mp3',
    options: [
      _MaddOption(word: 'أَرْنَب', hasMadd: false),
      _MaddOption(word: 'يَلْعَب', hasMadd: false),
      _MaddOption(word: 'تُوت', hasMadd: true),
    ],
    cuts: [160, 290, 380],
  ),
];

// مراكز بطاقات الكلمات الثلاث على اليسار (بكسل الصورة الأصلية)
const double _cardCx = 76;
const List<double> _cardCy = [103, 222, 347];
const double _cardW = 144;
const double _cardH = 96;

// البقع اللونية الأربع على باليت الزرافة (ألوانها مأخوذة من الصورة الأصلية)
class _GiraffeBlob {
  final double px;
  final double py;
  final Color color;
  const _GiraffeBlob({required this.px, required this.py, required this.color});
}

const List<_GiraffeBlob> _giraffeBlobs = [
  _GiraffeBlob(px: 860, py: 264, color: Color(0xFFDC15C3)),
  _GiraffeBlob(px: 922, py: 254, color: Color(0xFF03A0E3)),
  _GiraffeBlob(px: 830, py: 292, color: Color(0xFFE30613)),
  _GiraffeBlob(px: 861, py: 311, color: Color(0xFF048200)),
];

const List<Color> _palette = [
  Color(0xFFE30613),
  Color(0xFF048200),
  Color(0xFF03A0E3),
  Color(0xFFDC15C3),
  Color(0xFFFDD835),
  Color(0xFFFB8C00),
  Color(0xFF8E24AA),
  Color(0xFF00ACC1),
];

class TaaColoringGame extends ConsumerStatefulWidget {
  const TaaColoringGame({super.key});

  @override
  ConsumerState<TaaColoringGame> createState() => _TaaColoringGameState();
}

class _TaaColoringGameState extends ConsumerState<TaaColoringGame> {
  late ConfettiController _confetti;

  int _round = 0;
  int _score = 0;
  bool _gameOver = false;

  // يُزاد عند أي انتقال/إعادة فتتوقف التسلسلات الصوتية القديمة تلقائياً
  int _token = 0;

  // الخطوة 1
  int? _selectedOption;
  bool _isWordSelected = false;
  bool _isProcessing = false;
  final Set<int> _wrongPressed = {};

  // الخطوة 2
  bool _roundDone = false;
  Color _selectedPaletteColor = _palette.first;
  late List<Color?> _sliceColors;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _initSliceColors();
    final tk = _token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_alive(tk)) {
        _playRoundIntro(isFirstRound: true);
      }
    });
  }

  @override
  void dispose() {
    _token++;
    _stopAudio();
    _confetti.dispose();
    super.dispose();
  }

  void _initSliceColors() {
    _sliceColors = List.generate(_rounds[_round].slices.length, (_) => null);
  }

  bool _alive(int token) => mounted && !_gameOver && token == _token;

  /// يشغّل ملفاً صوتياً وينتظر انتهاءه فعلاً (لا توقيتات تقديرية تقطع الصوت).
  Future<void> _say(
    String path, {
    required int maxMs,
    AudioChannel channel = AudioChannel.voice,
  }) async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(path, channel: channel);
      final done = AudioService.instance.onPlayerComplete(channel);
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

  void _stopAudio() {
    try {
      AudioService.instance.stop();
    } catch (_) {}
  }

  // ─── افتتاح الجولة ───────────────────────────────────────────────────────────
  Future<void> _playRoundIntro({bool isFirstRound = false}) async {
    if (!mounted || _gameOver) return;
    final tk = ++_token;
    _stopAudio();
    if (!_isWordSelected) {
      if (isFirstRound) {
        await _say('audio/games/coloring/6_al15.mp3', maxMs: 2200); // «التلوين»
        if (!_alive(tk) || _isWordSelected) return;
      }
      // «اضغط على الكلمة التي بها مد»
      await _say('audio/games/coloring/3_qu2.mp3', maxMs: 4500);
    } else {
      // «لوّن الكلمة بألوانك المفضلة»
      await _say('audio/games/coloring/2_qu3.mp3', maxMs: 6000);
    }
  }

  // ─── الخطوة 1: اختيار الكلمة التي بها مد ─────────────────────────────────────
  Future<void> _onOptionTap(int idx) async {
    if (_isWordSelected || _roundDone || _isProcessing) return;
    HapticFeedback.lightImpact();

    final tk = ++_token;
    final rd = _rounds[_round];
    final opt = rd.options[idx];

    setState(() {
      _selectedOption = idx;
      _isProcessing = true;
    });
    _stopAudio();

    if (opt.hasMadd) {
      setState(() {
        _score++;
        _isWordSelected = true;
        _isProcessing = false;
      });
      _confetti.play();

      // «أحسنت + الكلمة» ثم طلب التلوين
      await _say(rd.correctAudio, maxMs: 3500);
      if (!_alive(tk)) return;
      await _say('audio/games/coloring/2_qu3.mp3', maxMs: 6000);
      return;
    }

    // خاطئة
    _wrongPressed.add(idx);
    final wrongIndexes = [
      for (int i = 0; i < rd.options.length; i++)
        if (!rd.options[i].hasMadd) i,
    ];
    final bothWrongPressed = wrongIndexes.every(_wrongPressed.contains);

    if (bothWrongPressed) {
      // كما في الأصل: بعد الضغط على البطاقتين الخاطئتين تُنطق الإجابة وتُكشف
      await _say(rd.revealAudio, maxMs: 7000);
      if (!_alive(tk)) return;
      setState(() {
        _selectedOption = rd.options.indexWhere((o) => o.hasMadd);
        _isWordSelected = true;
        _isProcessing = false;
      });
      await _say('audio/games/coloring/2_qu3.mp3', maxMs: 6000);
    } else {
      // «حاول مرة أخرى»
      await _say('audio/games/coloring/5_al23.mp3', maxMs: 3200);
      if (!_alive(tk)) return;
      setState(() {
        _selectedOption = null;
        _isProcessing = false;
      });
    }
  }

  // ─── الخطوة 2: تلوين مقاطع الكلمة ───────────────────────────────────────────
  Future<void> _colorSlice(int sliceIdx) async {
    if (!_isWordSelected || _roundDone) return;
    if (_sliceColors[sliceIdx] == _selectedPaletteColor) return;

    HapticFeedback.selectionClick();
    setState(() => _sliceColors[sliceIdx] = _selectedPaletteColor);

    final allColored = _sliceColors.every((c) => c != null);
    if (!allColored) {
      try {
        AudioService.instance.playAsset(
          'audio/games/coloring/6_b2.mp3',
          channel: AudioChannel.sfx,
        );
      } catch (_) {}
      return;
    }

    final tk = ++_token;
    setState(() => _roundDone = true);
    _confetti.play();
    final rd = _rounds[_round];

    await _say(
      'audio/games/coloring/6_b2.mp3',
      maxMs: 450,
      channel: AudioChannel.sfx,
    );
    if (!_alive(tk)) return;
    await _say('audio/games/fishing/ahsnt.mp3', maxMs: 2500); // «أحسنت»
    if (!_alive(tk)) return;
    await _say(rd.wordAudio, maxMs: 2500); // نطق الكلمة
    if (!_alive(tk)) return;
    await Future.delayed(const Duration(milliseconds: 500));
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
    _stopAudio();
    if (_round + 1 >= _rounds.length) {
      setState(() => _gameOver = true);
      _confetti.play();
      try {
        AudioService.instance.playAsset(
          'audio/games/fishing/ahsnt.mp3',
          channel: AudioChannel.voice,
        );
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

  void _previous() {
    final tk = ++_token;
    _stopAudio();
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
    if (_gameOver) return _buildGameOver();
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
            final ia = _imgW / _imgH, sa = sw / sh;
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
            final scaleX = dW / _imgW;
            final scaleY = dH / _imgH;

            return Stack(
              children: [
                // 1. صورة الشاشة الأصلية من الأسطوانة
                Positioned.fill(
                  child: Image.asset(rd.bgImagePath, fit: BoxFit.contain),
                ),

                // 2. بطاقات الكلمات الثلاث (الخطوة 1)
                ...List.generate(
                  rd.options.length,
                  (i) => _buildOptionCard(rd, i, ox, oy, scaleX, scaleY),
                ),

                // 3. الكلمة المفرغة للتلوين (الخطوة 2)
                if (_isWordSelected)
                  _buildHollowWord(rd, ox, oy, scaleX, scaleY),

                // 4. بقع الألوان على باليت الزرافة (نقر لاختيار اللون)
                ..._giraffeBlobs.map((blob) {
                  final isSel = _selectedPaletteColor == blob.color;
                  final bw = 56 * scaleX;
                  final bh = 40 * scaleY;
                  return Positioned(
                    left: ox + blob.px * scaleX - bw / 2,
                    top: oy + blob.py * scaleY - bh / 2,
                    width: bw,
                    height: bh,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() => _selectedPaletteColor = blob.color);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSel
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                        ),
                      ),
                    ),
                  );
                }),

                // 5. شريط الألوان أسفل اللوحة (الخطوة 2)
                if (_isWordSelected)
                  _buildColorPaletteBar(ox, oy, scaleX, scaleY),

                // 6. شريط الحالة
                Positioned(top: 8, left: 0, right: 0, child: _topBar()),
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
            colors: const [
              Colors.yellow,
              Colors.green,
              Colors.red,
              Colors.purple,
              Colors.orange,
              Colors.cyan,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard(
    _ColoringRound rd,
    int i,
    double ox,
    double oy,
    double scaleX,
    double scaleY,
  ) {
    final opt = rd.options[i];
    final cw = _cardW * scaleX;
    final ch = _cardH * scaleY;
    final isSelected = _selectedOption == i;
    final isCorrect = isSelected && opt.hasMadd;
    final isWrong = isSelected && !opt.hasMadd;

    return Positioned(
      left: ox + _cardCx * scaleX - cw / 2,
      top: oy + _cardCy[i] * scaleY - ch / 2,
      width: cw,
      height: ch,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onOptionTap(i),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Container(
                width: cw * 0.96,
                height: ch * 0.92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isCorrect ? Colors.green.shade600 : Colors.red.shade600,
                    width: 4,
                  ),
                  color: (isCorrect ? Colors.green : Colors.red).withValues(alpha: 0.15),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1.0, 1.0),
                    duration: 220.ms,
                    curve: Curves.easeOutBack,
                  )
                  .shake(duration: isWrong ? 400.ms : 0.ms, hz: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildHollowWord(
    _ColoringRound rd,
    double ox,
    double oy,
    double scaleX,
    double scaleY,
  ) {
    final wW = _wordW * scaleX;
    final wH = _wordH * scaleY;
    final slices = rd.slices;

    return Positioned(
      left: ox + _wordX * scaleX,
      top: oy + _wordY * scaleY,
      width: wW,
      height: wH,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => _paintAt(d.localPosition.dx / scaleX, slices),
        onPanUpdate: (d) => _paintAt(d.localPosition.dx / scaleX, slices),
        child: Stack(
          children: List.generate(slices.length, (i) {
            final x0 = slices[i][0] * scaleX;
            final x1 = slices[i][1] * scaleX;
            final color = _sliceColors[i];
            return Positioned(
              left: x0,
              top: 0,
              width: x1 - x0,
              height: wH,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topLeft,
                  minWidth: wW,
                  maxWidth: wW,
                  minHeight: wH,
                  maxHeight: wH,
                  child: Transform.translate(
                    offset: Offset(-x0, 0),
                    child: color == null
                        ? Image.asset(rd.wordMaskPath, width: wW, height: wH, fit: BoxFit.fill)
                        : ColorFiltered(
                            colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                            child: Image.asset(rd.wordMaskPath, width: wW, height: wH, fit: BoxFit.fill),
                          ),
                  ),
                ),
              ),
            );
          }),
        ),
      ).animate().fadeIn(duration: 300.ms),
    );
  }

  void _paintAt(double localX, List<List<double>> slices) {
    for (int i = 0; i < slices.length; i++) {
      if (localX >= slices[i][0] && localX < slices[i][1]) {
        _colorSlice(i);
        return;
      }
    }
  }

  Widget _buildColorPaletteBar(
    double ox,
    double oy,
    double scaleX,
    double scaleY,
  ) {
    return Positioned(
      left: ox + 205 * scaleX,
      top: oy + 385 * scaleY,
      width: 495 * scaleX,
      height: 70 * scaleY,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10 * scaleX, vertical: 5 * scaleY),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF2E7D32), width: 2.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _palette.map((c) {
            final isSelected = _selectedPaletteColor == c;
            final sz = (isSelected ? 44.0 : 34.0) * scaleX;
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedPaletteColor = c);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: sz,
                height: sz,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black87 : Colors.white,
                    width: isSelected ? 3.0 : 2.0,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.brush_rounded, color: Colors.white, size: 20 * scaleX)
                    : null,
              ),
            );
          }).toList(),
        ),
      ).animate().fadeIn(duration: 300.ms),
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
          _navBtn('التالي', Icons.arrow_back_rounded, _isWordSelected, () {
            HapticFeedback.lightImpact();
            _advance();
          }),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _token++;
              _stopAudio();
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: const Icon(Icons.home_rounded, color: Colors.white, size: 26),
            ),
          ),
          _navBtn('السابق', Icons.arrow_forward_rounded, _round > 0, () {
            HapticFeedback.lightImpact();
            _previous();
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
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: enabled ? const Color(0xFFE53935) : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(24),
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
    );
  }

  Widget _topBar() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _chip('⭐ $_score'),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _playRoundIntro(),
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

  Widget _buildGameOver() => Stack(
        children: [
          Positioned.fill(
            child: Image.asset(_rounds.last.bgImagePath, fit: BoxFit.contain),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.65)),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 45,
              gravity: 0.3,
              colors: const [
                Colors.yellow,
                Colors.green,
                Colors.red,
                Colors.purple,
                Colors.orange,
                Colors.cyan,
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎨', style: TextStyle(fontSize: 85)),
                const SizedBox(height: 18),
                Text(
                  _score == _rounds.length
                      ? 'مُمْتَازٌ! أَكْمَلْتَ تَلْوِينَ كُلِّ الْكَلِمَاتِ! 🌟'
                      : 'أَحْسَنْتَ! نَتِيجَتُكَ: $_score / ${_rounds.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  onPressed: () {
                    final tk = ++_token;
                    _stopAudio();
                    setState(() {
                      _round = 0;
                      _score = 0;
                      _gameOver = false;
                      _resetRoundState();
                    });
                    Future.delayed(
                      const Duration(milliseconds: 400),
                      () {
                        if (_alive(tk)) _playRoundIntro(isFirstRound: true);
                      },
                    );
                  },
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text(
                    'الْعَبْ مَرَّةً أُخْرَى',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/services/audio_service.dart';

const double _imgW = 1270, _imgH = 950;

class _CellZone {
  final String label;
  final bool isCorrect;
  final double px, py;
  const _CellZone({required this.label, required this.isCorrect, required this.px, required this.py});
}

class _Round {
  final String imagePath;
  final List<_CellZone> cells;
  const _Round({required this.imagePath, required this.cells});
}

const List<_Round> _rounds = [
  _Round(imagePath: 'assets/images/games/beehive/beehive_round_1.png', cells: [
    _CellZone(label: 'أُ', isCorrect: false, px: 985, py: 295), // Top
    _CellZone(label: 'أَ', isCorrect: false, px: 875, py: 452), // Left
    _CellZone(label: 'إِ', isCorrect: true,  px: 1110, py: 452), // Right (Correct for إِبْرَةٌ)
    _CellZone(label: 'أْ', isCorrect: false, px: 985, py: 575), // Bottom
  ]),
  _Round(imagePath: 'assets/images/games/beehive/beehive_round_2.png', cells: [
    _CellZone(label: 'أُ', isCorrect: true,  px: 985, py: 295), // Top (Correct for أُذُنٌ)
    _CellZone(label: 'أَ', isCorrect: false, px: 875, py: 452), // Left
    _CellZone(label: 'إِ', isCorrect: false, px: 1110, py: 452), // Right
    _CellZone(label: 'أْ', isCorrect: false, px: 985, py: 575), // Bottom
  ]),
  _Round(imagePath: 'assets/images/games/beehive/beehive_round_3.png', cells: [
    _CellZone(label: 'أُ', isCorrect: false, px: 985, py: 295), // Top
    _CellZone(label: 'أَ', isCorrect: true,  px: 875, py: 452), // Left (Correct for أَسَدٌ)
    _CellZone(label: 'إِ', isCorrect: false, px: 1110, py: 452), // Right
    _CellZone(label: 'أْ', isCorrect: false, px: 985, py: 575), // Bottom
  ]),
  _Round(imagePath: 'assets/images/games/beehive/beehive_round_4.png', cells: [
    _CellZone(label: 'أُ', isCorrect: false, px: 985, py: 295), // Top
    _CellZone(label: 'أَ', isCorrect: false, px: 875, py: 452), // Left
    _CellZone(label: 'إِ', isCorrect: false, px: 1110, py: 452), // Right
    _CellZone(label: 'أْ', isCorrect: true,  px: 985, py: 575), // Bottom (Correct for رَأْسٌ)
  ]),
];

class BeehiveGame extends ConsumerStatefulWidget {
  const BeehiveGame({super.key});
  @override
  ConsumerState<BeehiveGame> createState() => _BeehiveGameState();
}

class _BeehiveGameState extends ConsumerState<BeehiveGame> {
  late ConfettiController _confetti;
  int _round = 0, _score = 0, _wrongAttempts = 0;
  int? _tapped;
  bool _roundDone = false, _gameOver = false, _showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(const Duration(milliseconds: 700), _playInstruction));
  }

  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  Future<void> _playInstruction() => AudioService.instance.playAsset('audio/instructions/alif_quiz_bee_explain.mp3', channel: AudioChannel.voice);
  Future<void> _playCorrect() => AudioService.instance.playAsset('audio/stories/alif_correct.mp3', channel: AudioChannel.sfx);
  Future<void> _playWrong() => AudioService.instance.playAsset('audio/instructions/alif_quiz_option_d.mp3', channel: AudioChannel.sfx);
  Future<void> _playThisIsCorrect() => AudioService.instance.playAsset('audio/feedback/wow.mp3', channel: AudioChannel.voice);

  Future<void> _onCellTap(int idx) async {
    if (_roundDone || _showCorrectAnswer) return;
    HapticFeedback.lightImpact();
    final cell = _rounds[_round].cells[idx];
    if (cell.isCorrect) {
      setState(() { _tapped = idx; _roundDone = true; _score++; });
      _confetti.play();
      await _playCorrect();
      await Future.delayed(const Duration(milliseconds: 1800));
      if (!mounted) return;
      _advance();
    } else {
      setState(() { _tapped = idx; _wrongAttempts++; });
      await _playWrong();
      if (_wrongAttempts >= 2) {
        setState(() { _showCorrectAnswer = true; });
        await _playThisIsCorrect();
        await Future.delayed(const Duration(milliseconds: 3000));
        if (!mounted) return;
        _advance();
      } else {
        await Future.delayed(const Duration(milliseconds: 1000));
        if (!mounted) return;
        setState(() { _tapped = null; });
      }
    }
  }

  void _advance() {
    if (_round + 1 >= _rounds.length) { setState(() => _gameOver = true); if (_score >= _rounds.length / 2) _confetti.play(); }
    else { setState(() { _round++; _tapped = null; _roundDone = false; _wrongAttempts = 0; _showCorrectAnswer = false; }); Future.delayed(const Duration(milliseconds: 400), _playInstruction); }
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
    return Stack(children: [
      LayoutBuilder(builder: (ctx, c) {
        final sw = c.maxWidth, sh = c.maxHeight;
        final ia = _imgW / _imgH, sa = sw / sh;
        double dW, dH, ox, oy;
        if (sa < ia) { dW = sw; dH = sw / ia; ox = 0; oy = (sh - dH) / 2; }
        else { dH = sh; dW = sh * ia; ox = (sw - dW) / 2; oy = 0; }
        return Stack(children: [
          Positioned.fill(child: Image.asset(rd.imagePath, fit: BoxFit.contain)),
          ...List.generate(rd.cells.length, (i) {
            final cell = rd.cells[i];
            final cx = ox + (cell.px / _imgW) * dW, cy = oy + (cell.py / _imgH) * dH;
            const r = 62.0;
            Color fill = Colors.transparent, ring = Colors.white.withValues(alpha: 0.30);
            Widget child = const SizedBox.shrink();

            if (_showCorrectAnswer) {
              if (cell.isCorrect) { fill = Colors.green.withValues(alpha: 0.45); ring = Colors.greenAccent; child = const Text('✅', style: TextStyle(fontSize: 32)); }
            } else if (_tapped == i) {
              if (cell.isCorrect) { fill = Colors.green.withValues(alpha: 0.45); ring = Colors.greenAccent; child = const Text('✅', style: TextStyle(fontSize: 32)); }
              else { fill = Colors.red.withValues(alpha: 0.45); ring = Colors.redAccent; child = const Text('❌', style: TextStyle(fontSize: 32)); }
            } else if (_roundDone && cell.isCorrect) { fill = Colors.green.withValues(alpha: 0.20); ring = Colors.greenAccent.withValues(alpha: 0.70); }

            return Positioned(left: cx - r, top: cy - r, width: r * 2, height: r * 2,
              child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => _onCellTap(i),
                child: AnimatedContainer(duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: fill, border: Border.all(color: ring, width: 3)),
                  child: Center(child: child))));
          }),
          
          if (_showCorrectAnswer)
            Positioned(top: oy + dH * 0.35, left: 0, right: 0, child: Center(
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.greenAccent, width: 2)),
                child: const Text('هَذِهِ هِيَ الْإِجَابَةُ الصَّحِيحَةُ', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Cairo'))).animate().fadeIn().scale(),
            )),

          Positioned(top: 10, left: 0, right: 0, child: _topBar()),
        ]);
      }),
      Align(alignment: Alignment.topCenter, child: ConfettiWidget(confettiController: _confetti, blastDirectionality: BlastDirectionality.explosive, numberOfParticles: 25, gravity: 0.4, colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange])),
    ]);
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -3))]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navBtn('التالي', Icons.arrow_back_rounded, _roundDone || _showCorrectAnswer, () { if (_roundDone || _showCorrectAnswer) { HapticFeedback.lightImpact(); _advance(); } }),
          GestureDetector(
            onTap: () { HapticFeedback.lightImpact(); Navigator.of(context).popUntil((route) => route.isFirst); },
            child: Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]), child: const Icon(Icons.home_rounded, color: Colors.white, size: 28)),
          ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms),
          _navBtn('السابق', Icons.arrow_forward_rounded, _round > 0 && !_roundDone && !_showCorrectAnswer, () {
            if (_round > 0 && !_roundDone && !_showCorrectAnswer) { HapticFeedback.lightImpact(); setState(() { _round--; _tapped = null; _roundDone = false; _wrongAttempts = 0; _showCorrectAnswer = false; }); Future.delayed(const Duration(milliseconds: 400), _playInstruction); }
          }),
        ],
      ),
    );
  }

  Widget _navBtn(String label, IconData icon, bool enabled, VoidCallback onTap) {
    final isNext = label == 'التالي';
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(duration: const Duration(milliseconds: 200), opacity: enabled ? 1.0 : 0.4,
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: enabled ? const Color(0xFFE53935) : Colors.grey.shade400, borderRadius: BorderRadius.circular(24), boxShadow: enabled ? [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 6, offset: const Offset(0, 3))] : []),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (isNext) Icon(icon, color: Colors.white, size: 20), if (isNext) const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            if (!isNext) const SizedBox(width: 6), if (!isNext) Icon(icon, color: Colors.white, size: 20),
          ]),
        ),
      ),
    ).animate().scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack, duration: 300.ms);
  }

  Widget _topBar() => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    _chip('⭐ $_score'), const SizedBox(width: 10),
    GestureDetector(onTap: _playInstruction, child: Container(padding: const EdgeInsets.all(9), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 26))),
    const SizedBox(width: 10), _chip('${_round + 1} / ${_rounds.length}'),
  ]);
  Widget _chip(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)), child: Text(t, style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)));
  Widget _gameOverScreen() => Stack(children: [
    Positioned.fill(child: Image.asset(_rounds.last.imagePath, fit: BoxFit.contain)), Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.65))),
    Align(alignment: Alignment.topCenter, child: ConfettiWidget(confettiController: _confetti, blastDirectionality: BlastDirectionality.explosive, numberOfParticles: 50, gravity: 0.3, colors: const [Colors.yellow, Colors.green, Colors.red, Colors.purple, Colors.orange])),
    Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(_score == _rounds.length ? '🏆' : '🎯', style: const TextStyle(fontSize: 90)).animate().scale(begin: const Offset(0, 0), curve: Curves.elasticOut, duration: 800.ms),
      const SizedBox(height: 20),
      Text(_score == _rounds.length ? 'مُمْتَازٌ! أَجَبْتَ عَلَى كُلِّ الأَسْئِلَةِ!' : 'أَحْسَنْتَ! إِجَابَتُكَ: $_score / ${_rounds.length}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo')).animate(delay: 400.ms).fadeIn(),
      const SizedBox(height: 30),
      ElevatedButton.icon(onPressed: () { setState(() { _round = 0; _score = 0; _gameOver = false; _tapped = null; _roundDone = false; _wrongAttempts = 0; _showCorrectAnswer = false; }); Future.delayed(const Duration(milliseconds: 500), _playInstruction); }, icon: const Icon(Icons.replay_rounded), label: const Text('الْعَبْ مَرَّةً أُخْرَى', style: TextStyle(fontFamily: 'Cairo', fontSize: 18)), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black87, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))).animate(delay: 700.ms).fadeIn().scale(begin: const Offset(0.8, 0.8)),
    ])),
  ]);
}

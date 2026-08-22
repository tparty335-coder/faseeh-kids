import 'package:flutter/material.dart';
import 'package:faseeh_kids/services/audio_service.dart';

class BaaWritingStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaWritingStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<BaaWritingStation> createState() => _BaaWritingStationState();
}

class _BaaWritingStationState extends State<BaaWritingStation> {
  final List<List<Offset>> _strokes = [];
  int _currentFormIndex = 0;

  static const List<Map<String, dynamic>> _forms = [
    {
      'title': 'مُنْفَصِل',
      'letter': 'ب',
      'instruction': 'اِكْتُبْ حَرْفَ الْبَاءِ الْمُنْفَصِلِ مَعَ النُّقْطَةِ تَحْتَهُ',
    },
    {
      'title': 'أَوَّلُ الْكَلِمَةِ',
      'letter': 'بـ',
      'instruction': 'اِكْتُبْ حَرْفَ الْبَاءِ فِي أَوَّلِ الْكَلِمَةِ',
    },
    {
      'title': 'وَسَطُ الْكَلِمَةِ',
      'letter': 'ـبـ',
      'instruction': 'اِكْتُبْ حَرْفَ الْبَاءِ فِي وَسَطِ الْكَلِمَةِ',
    },
    {
      'title': 'آخِرُ الْكَلِمَةِ',
      'letter': 'ـب',
      'instruction': 'اِكْتُبْ حَرْفَ الْبَاءِ فِي آخِرِ الْكَلِمَةِ مُتَّصِلاً',
    },
  ];

  @override
  void initState() {
    super.initState();
    _playInstructionAudio();
  }

  @override
  void dispose() {
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playInstructionAudio() async {
    await AudioService.instance.stop();
    await AudioService.instance.playAsset('audio/lessons/baa/medium/baa_51.mp3');
  }

  Future<void> _onPraise() async {
    await AudioService.instance.stop();
    await AudioService.instance.playAsset('audio/lessons/baa/short/baa_5.mp3');
  }

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = _forms[_currentFormIndex];

    return Stack(
      children: [
        // ── 1. Authentic Lined Notebook Background ────────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_writing.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFFFFDE7)),
          ),
        ),

        // ── 2. Top Header ─────────────────────────────────────────
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF57C00),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: const Text(
                'كِتَابَةُ حَرْفِ الْبَاءِ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // ── 3. Letter Form Selector ───────────────────────────────
        Positioned(
          top: 75,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_forms.length, (i) {
              final isSelected = i == _currentFormIndex;
              final f = _forms[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentFormIndex = i;
                    _strokes.clear();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFF57C00) : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFF57C00), width: 2),
                  ),
                  child: Text(
                    f['title'] as String,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : const Color(0xFFE65100),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        // ── 4. Interactive Drawing Area on Notebook ───────────────
        Positioned(
          top: 130,
          left: 30,
          right: 30,
          bottom: 90,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFFFB74D), width: 3),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Stack(
              children: [
                // Faded Letter Guide in background
                Center(
                  child: Text(
                    form['letter'] as String,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 140,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),

                // Active Gesture Canvas
                GestureDetector(
                  onPanStart: (details) {
                    setState(() {
                      _strokes.add([details.localPosition]);
                    });
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      _strokes.last.add(details.localPosition);
                    });
                  },
                  onPanEnd: (_) {
                    if (_strokes.length >= 2) {
                      _onPraise();
                    }
                  },
                  child: CustomPaint(
                    painter: _StrokePainter(_strokes),
                    size: Size.infinite,
                  ),
                ),

                // Clear / Replay Controls
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: IconButton(
                    icon: const Icon(Icons.refresh_rounded, color: Color(0xFFF57C00), size: 30),
                    onPressed: _clearCanvas,
                    tooltip: 'إعادة المسح',
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: IconButton(
                    icon: const Icon(Icons.volume_up_rounded, color: Color(0xFFF57C00), size: 30),
                    onPressed: _playInstructionAudio,
                    tooltip: 'استمع للتوجيه',
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── 5. Bottom Navigation Arrows ───────────────────────────
        Positioned(
          bottom: 16,
          left: 24,
          right: 24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: widget.onPrevious,
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                label: const Text('السابق', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Colors.brown.shade800,
                  side: BorderSide(color: Colors.brown.shade400, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: widget.onNext,
                icon: const Text('التالي', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                label: const Icon(Icons.arrow_forward_ios, size: 18),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StrokePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  _StrokePainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (final stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(stroke[i], stroke[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StrokePainter oldDelegate) => true;
}

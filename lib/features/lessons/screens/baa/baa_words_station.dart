import 'package:flutter/material.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BaaWordsStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaWordsStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<BaaWordsStation> createState() => _BaaWordsStationState();
}

class _BaaWordsStationState extends State<BaaWordsStation> {
  int? _activeWordIndex;

  static const List<Map<String, dynamic>> _words = [
    {
      'word': 'بَقَرَة',
      'haraka': 'حَرَكَةُ الْفَتْحِ',
      'color': Color(0xFFD32F2F), // Red
      'audio': 'audio/lessons/baa/short/baa_11.mp3',
    },
    {
      'word': 'بَاب',
      'haraka': 'مَدٌّ بِالأَلِفِ',
      'color': Color(0xFFEF6C00), // Orange
      'audio': 'audio/lessons/baa/medium/baa_28.mp3',
    },
    {
      'word': 'بِطِّيخ',
      'haraka': 'حَرَكَةُ الْكَسْرِ',
      'color': Color(0xFF2E7D32), // Green
      'audio': 'audio/lessons/baa/short/baa_13.mp3',
    },
    {
      'word': 'بِنْت',
      'haraka': 'حَرَكَةُ الْكَسْرِ مَعَ السُّكُونِ',
      'color': Color(0xFF1565C0), // Blue
      'audio': 'audio/lessons/baa/short/baa_17.mp3',
    },
  ];

  @override
  void dispose() {
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playWord(int index) async {
    setState(() => _activeWordIndex = index);
    await AudioService.instance.stop();
    await AudioService.instance.playAsset(_words[index]['audio'] as String);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── 1. Authentic Vocabulary Screen Background ─────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_words.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE0F7FA)),
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
                color: const Color(0xFF00838F),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: const Text(
                'كَلِمَاتُ حَرْفِ الْبَاءِ',
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

        // ── 3. Four Sliding Word Cards ────────────────────────────
        Positioned(
          top: 80,
          left: 30,
          right: 90, // Leave room for the girl on the right
          bottom: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_words.length, (i) {
              final w = _words[i];
              final isSelected = i == _activeWordIndex;
              final color = w['color'] as Color;

              return GestureDetector(
                onTap: () => _playWord(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: isSelected ? 3.5 : 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: isSelected ? 12 : 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        isSelected ? Icons.volume_up_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      Text(
                        w['word'] as String,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: (i * 100).ms).slideX(begin: -0.2),
              );
            }),
          ),
        ),

        // ── 4. Bottom Navigation Arrows ───────────────────────────
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
